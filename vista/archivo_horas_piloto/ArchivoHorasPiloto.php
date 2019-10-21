<?php
/**
*@package pXP
*@file ArchivoHorasPiloto.php
*@author  (breydi.vasquez)
*@date 20-09-2019 13:42:10
*@description Archivo con la interfaz de usuario que permite la ejecucion de todas las funcionalidades del sistema
*/

header("content-type: text/javascript; charset=UTF-8");
?>
<style>
.button-up-excel{
    background-image: url('../../../sis_horas_piloto/media/logo/upload_file.png');
    background-repeat: no-repeat;
    filter: saturate(250%);
    background-size: 30%;        
}
.button-rollback{
    background-image: url('../../../sis_horas_piloto/media/logo/rollback_1.jpg');
    background-repeat: no-repeat;
    filter: saturate(250%);
    background-size: 30%;    
}
.seeFile{
    background-image: url('../../../sis_horas_piloto/media/logo/seeFile.png');
    background-repeat: no-repeat;
    filter: saturate(250%);
    background-size: 30%;        
}
.procesData{
    background-image: url('../../../sis_horas_piloto/media/logo/prosData.png');
    background-repeat: no-repeat;
    filter: saturate(250%);
    background-size: 30%;        
}
.log{
    background-image: url('../../../sis_horas_piloto/media/logo/file-manager.png');
    background-repeat: no-repeat;
    filter: saturate(250%);
    background-size: 30%;        
}
.button-delte-calc{
    background-image: url('../../../sis_horas_piloto/media/logo/del.jpg');
    background-repeat: no-repeat;
    filter: saturate(250%);
    background-size: 70%;    
}
.button-repoExcel{
    background-image: url('../../../sis_horas_piloto/media/logo/excel-icon.png');
    background-repeat: no-repeat;
    filter: saturate(250%);
    background-size: 35%;    
}
</style>
<script>
Phx.vista.ArchivoHorasPiloto=Ext.extend(Phx.gridInterfaz,{

	constructor:function(config){
        this.initButtons = ['-','<span style="font-size:14px;color:#2B4364;font-weight:bold;">Gestión: </span>',this.cmbGestion];
		this.maestro=config.maestro;
        var fecha = new Date();        
            Ext.Ajax.request({
                url: '../../sis_parametros/control/Gestion/obtenerGestionByFecha',
                params: {fecha: fecha.getDate() + '/' + (fecha.getMonth() + 1) + '/' + fecha.getFullYear()},
                success: function (resp) {
                    var reg = Ext.decode(Ext.util.Format.trim(resp.responseText));                    
                    this.cmbGestion.setValue(reg.ROOT.datos.id_gestion);
                    this.cmbGestion.setRawValue(fecha.getFullYear());
                    this.store.baseParams.id_gestion = reg.ROOT.datos.id_gestion;                    
                },
                failure: this.conexionFailure,
                timeout: this.timeout,
                scope: this
            });        
    	//llama al constructor de la clase padre
		Phx.vista.ArchivoHorasPiloto.superclass.constructor.call(this,config);
        this.cmbGestion.on('select', function () {
                    if (this.validarFiltros()) {
                        this.capturarGestion();
                    }
                }, this);

        this.grid.addListener('cellclick',this.oncellclick,this);
        this.init();
        this.iniciarEventos();

        this.addButton('btnsubir_archivo', {                    
                text: 'Cargar Excel Simuladores',
                //iconCls: 'bsubir',
                iconCls:'button-up-excel',
                disabled: true,
                handler: this.subirArchivo,
                tooltip: '<b>Cargar Archivo</b><br/>Carga un Archivo del tipo Excel.'
            }
        );
        
        this.addButton('btnCalPagoVariable', {                
            text: 'Calcular Pago Variable',
            //iconCls: 'bcalculator',
            iconCls:'procesData',
            disabled: true,
            handler:this.calPagoVariable,
            tooltip: '<b>Medicion y Calculo</b><br/>Del Pago Variable'
        });

        this.addButton('btnborrar_archivo', {                
            text: 'Borrar Archivo Excel',
            //iconCls: 'bundo',
            iconCls:'button-rollback',
            disabled: true,
            handler:this.borrarDetalle,
            tooltip: '<b>Borrar</b><br/>Elimina los datos Cargados del excel'
        }); 

        this.addButton('btnborrar_calculo', {                
            text: 'Borrar Calculo',
            iconCls:'button-delte-calc',
            disabled: true,
            handler:this.borrarCalculo,
            tooltip: '<b>Borrar</b><br/>Elimina los datos calculados'
        });

        this.addButton('btnFinPagoVariable', {                
            text: 'Finaliza Pago Variable',
            iconCls: 'bassign',
            disabled: true,
            handler:this.finPagoVariable,
            tooltip: '<b>Finaliza</b><br/>El Pago Variable.'
        });

        this.addButton('btnRepPagoVariable', {                
            text: 'Reporte Pago Variable',
            //iconCls: 'bexcel', 
            iconCls:'button-repoExcel',           
            disabled: true,
            handler:this.repPagoVariable,
            tooltip: '<b>Reporte</b><br/>Genera reporte excel, del Pago Variable.'
        });

        this.addButton('btnLogPagoVariable', {                
            text: 'Historial Modificaciones',
            //iconCls: 'blist',
            iconCls:'log',
            disabled: true,
            handler:this.logPagoVariable,
            tooltip: '<b>Finaliza</b><br/>Historial de cambios de estado.'
        });        

		this.load({params:{start:0, limit:this.tam_pag}})
	},

    // filtro gestion 
    cmbGestion: new Ext.form.ComboBox({
            fieldLabel: 'Gestion',                
            allowBlank: false,
            emptyText: 'Gestion...',
            store: new Ext.data.JsonStore(
                {
                    url: '../../sis_parametros/control/Gestion/listarGestion',
                    id: 'id_gestion',
                    root: 'datos',
                    sortInfo: {
                        field: 'gestion',
                        direction: 'DESC'
                    },
                    totalProperty: 'total',
                    fields: ['id_gestion', 'gestion'],
                    // turn on remote sorting
                    remoteSort: true,
                    baseParams: {par_filtro: 'gestion'}
                }),
            valueField: 'id_gestion',
            triggerAction: 'all',
            displayField: 'gestion',
            hiddenName: 'id_gestion',
            mode: 'remote',
            pageSize: 5,
            queryDelay: 500,
            listWidth: '220',
            width: 80
        }),    
			
	Atributos:[
		{
			//configuracion del componente
			config:{
					labelSeparator:'',
					inputType:'hidden',
					name: 'id_archivo_horas_piloto'
			},
			type:'Field',
			form:true 
		},
        {
            config:{
                name:'id_gestion',
                fieldLabel:'Gestión',
                allowBlank:false,
                emptyText:'Gestión...',
                store: new Ext.data.JsonStore({
                    url: '../../sis_parametros/control/Gestion/listarGestion',
                    id: 'id_gestion',
                    root: 'datos',
                    sortInfo:{
                        field: 'gestion',
                        direction: 'DESC'
                    },
                    totalProperty: 'total',
                    fields: ['id_gestion','gestion','moneda','codigo_moneda'],                    
                    remoteSort: true,
                    baseParams:{par_filtro:'gestion'}
                }),
                valueField: 'id_gestion',
                displayField: 'gestion',                
                hiddenName: 'id_gestion',
                forceSelection:true,
                typeAhead: false,
                triggerAction: 'all',
                lazyRender:true,
                mode:'remote',
                pageSize:10,
                queryDelay:1000,
                listWidth:200,
                resizable:true,
                anchor:'50%',
                gwidth: 50,
				renderer : function(value, p, record) {					
					return String.format('{0}', record.data['gestion']);
				}                
            },
            type:'ComboBox',
            id_grupo:0,
            filters:{
                pfiltro:'gestion',
                type:'string'
            },
            grid:true,
            form:true
        },
        {
            config:{
                name:'id_periodo',
                fieldLabel:'Periodo',
                allowBlank:false,
                emptyText:'Periodo...',
                store: new Ext.data.JsonStore({
                    url: '../../sis_parametros/control/Periodo/listarPeriodo',
                    id: 'id_periodo',
                    root: 'datos',
                    sortInfo:{
                        field: 'id_periodo',
                        direction: 'ASC'
                    },
                    totalProperty: 'total',
                    fields: ['id_periodo','literal','periodo','fecha_ini','fecha_fin'],                    
                    remoteSort: true,
                    baseParams:{par_filtro:'periodo#literal'}
                }),
                valueField: 'id_periodo',
                displayField: 'literal',                
                hiddenName: 'id_periodo',
                forceSelection:true,
                typeAhead: false,
                triggerAction: 'all',
                lazyRender:true,
                mode:'remote',
                pageSize:12,
                queryDelay:1000,
                listWidth:200,
                resizable:true,
                anchor:'80%',
                gwidth: 80,
				renderer : function(value, p, record) {					
					return String.format('{0}', record.data['literal']);
				}                

            },
            type:'ComboBox',
            id_grupo:0,
            filters:{
                pfiltro:'literal',
                type:'string'
            },
            grid:true,
            form:true
        },
		{
			config:{
				name: 'nombre',
				fieldLabel: 'nombre',
				allowBlank: false,
				anchor: '80%',
				gwidth: 250,
				maxLength:200
			},
				type:'TextField',
				filters:{pfiltro:'arhopi.nombre',type:'string'},
                bottom_filter:true,
				id_grupo:1,
				grid:true,
				form:true
		},
		{
			config:{
				name: 'estado',
				fieldLabel: 'Estado',
				allowBlank: false,
				anchor: '80%',
				gwidth: 115,
                renderer: (value, p, record) => {
                    if (value == 'registrado'){
                        return '<div style="color:#EFAA35; font-size:12px; font-weight:bold;">Registrado</div>';
                    }else if(value == 'archivo_cargado'){
                        return '<div style="color:black; font-size:12px; font-weight:bold;">Archivo Cargado</div>';
                    }else if(value == 'calculado'){
                        return '<div style="color:blue; font-size:12px; font-weight:bold;">Calculado</div>';
                    }else{
                        return '<div style="color:green; font-size:12px; font-weight:bold;">Finalizado</div>';
                    }
                }				
			},
				type:'TextField',
				filters:{pfiltro:'arhopi.estado',type:'string'},
				id_grupo:1,
				grid:true,
				form:true
		},
		{
			config:{
				name: 'pago_total',
				fieldLabel: 'Total Pagado',
				allowBlank: false,
				anchor: '40%',
				gwidth: 130,
                renderer: (value, p, record) => {                                            
                    return  String.format('<div style="font-size:15px; float:right; color:blue;"><b><font>{0}</font><b></div>', Ext.util.Format.number(record.data.pago_total,'0.000,00/i'));
                }                	
			},
				type:'NumberField',				
				id_grupo:1,
				grid:true,
				form:false
		},        
        {
            config:{
                fieldLabel: "Archivo",
                gwidth: 60,
                inputType:'file',
                name: 'archivo',
                buttonText: '',   
                maxLength:150,
                anchor:'100%',
                renderer:function (value, p, record){  
                            if(record.data['archivo'].length!=0) {                                
                                return  String.format('{0}',"<div style='text-align:center'><img border='0' style='-webkit-user-select:auto;cursor:pointer;' title='Descargar Archivo' src='../../../sis_horas_piloto/media/logo/excel-icon.png' align='center' width='30' height='20'></div>");
                            }
                        },  
                buttonCfg: {
                    iconCls: 'upload-icon'
                }
            },
            type:'Field',
            sortable:false,
            id_grupo:0,
            grid:true,
            form:false
        },         
		{
			config:{
				name: 'usr_reg',
				fieldLabel: 'Creado por',
				allowBlank: true,
				anchor: '80%',
				gwidth: 100,
				maxLength:4
			},
				type:'Field',
				filters:{pfiltro:'usu1.cuenta',type:'string'},
				id_grupo:1,
				grid:true,
				form:false
		},
		{
			config:{
				name: 'fecha_reg',
				fieldLabel: 'Fecha creación',
				allowBlank: true,
				anchor: '80%',
				gwidth: 120,
							format: 'd/m/Y', 
							renderer:function (value,p,record){return value?value.dateFormat('d/m/Y H:i:s'):''}
			},
				type:'DateField',
				filters:{pfiltro:'arhopi.fecha_reg',type:'date'},
				id_grupo:1,
				grid:true,
				form:false
		},
		{
			config:{
				name: 'estado_reg',
				fieldLabel: 'Estado Reg.',
				allowBlank: true,
				anchor: '80%',
				gwidth: 100,
				maxLength:10
			},
				type:'TextField',
				filters:{pfiltro:'arhopi.estado_reg',type:'string'},
				id_grupo:1,
				grid:true,
				form:false
		},        
		{
			config:{
				name: 'id_usuario_ai',
				fieldLabel: 'Fecha creación',
				allowBlank: true,
				anchor: '80%',
				gwidth: 100,
				maxLength:4
			},
				type:'Field',
				filters:{pfiltro:'arhopi.id_usuario_ai',type:'numeric'},
				id_grupo:1,
				grid:false,
				form:false
		},
		{
			config:{
				name: 'usuario_ai',
				fieldLabel: 'Funcionaro AI',
				allowBlank: true,
				anchor: '80%',
				gwidth: 100,
				maxLength:300
			},
				type:'TextField',
				filters:{pfiltro:'arhopi.usuario_ai',type:'string'},
				id_grupo:1,
				grid:true,
				form:false
		},
		{
			config:{
				name: 'usr_mod',
				fieldLabel: 'Modificado por',
				allowBlank: true,
				anchor: '80%',
				gwidth: 100,
				maxLength:4
			},
				type:'Field',
				filters:{pfiltro:'usu2.cuenta',type:'string'},
				id_grupo:1,
				grid:true,
				form:false
		},
		{
			config:{
				name: 'fecha_mod',
				fieldLabel: 'Fecha Modif.',
				allowBlank: true,
				anchor: '80%',
				gwidth: 100,
							format: 'd/m/Y', 
							renderer:function (value,p,record){return value?value.dateFormat('d/m/Y H:i:s'):''}
			},
				type:'DateField',
				filters:{pfiltro:'arhopi.fecha_mod',type:'date'},
				id_grupo:1,
				grid:true,
				form:false
		}
	],
	tam_pag:50,	
	title:'Registro planilla excel',
	ActSave:'../../sis_horas_piloto/control/ArchivoHorasPiloto/insertarArchivoHorasPiloto',
	ActDel:'../../sis_horas_piloto/control/ArchivoHorasPiloto/eliminarArchivoHorasPiloto',
	ActList:'../../sis_horas_piloto/control/ArchivoHorasPiloto/listarArchivoHorasPiloto',
	id_store:'id_archivo_horas_piloto',
	fields: [
		{name:'id_archivo_horas_piloto', type: 'numeric'},
		{name:'estado_reg', type: 'string'},
		{name:'id_gestion', type: 'numeric'},
		{name:'id_periodo', type: 'numeric'},		
		{name:'nombre', type: 'string'},
		{name:'gestion', type: 'numeric'},
        {name:'literal', type: 'string'},
        {name:'archivo', type: 'string'},
        {name:'pago_total', type:'numeric'},
        {name:'estado', type: 'string'},
		{name:'id_usuario_reg', type: 'numeric'},
		{name:'fecha_reg', type: 'date',dateFormat:'Y-m-d H:i:s.u'},
		{name:'id_usuario_ai', type: 'numeric'},
		{name:'usuario_ai', type: 'string'},
		{name:'id_usuario_mod', type: 'numeric'},
		{name:'fecha_mod', type: 'date',dateFormat:'Y-m-d H:i:s.u'},
		{name:'usr_reg', type: 'string'},
		{name:'usr_mod', type: 'string'}        
		
	],
	sortInfo:{
		field: 'id_archivo_horas_piloto',
		direction: 'ASC'
	},
	bdel: false,
	bsave: false,
    btest: false,
    bnew: false,
    bedit: false,
    //detalle
    tabsouth:[{
			url : '../../../sis_horas_piloto/vista/horas_piloto/HorasPiloto.php',
			title : 'Detalle Horas Piloto',
			height: '50%',
			cls : 'HorasPiloto'
		}],
    //funcionalidades 
    iniciarEventos:function(){
        this.Cmp.id_gestion.on('select',function(c,r,n){

            this.Cmp.id_periodo.reset();
            this.Cmp.id_periodo.store.baseParams={id_gestion:c.value, vista: 'reporte'};
            this.Cmp.id_periodo.modificado=true;

        },this);
    }, 
    //botones
    preparaMenu:function(n){
        var data = this.getSelectedData();		              
        
        Phx.vista.ArchivoHorasPiloto.superclass.preparaMenu.call(this,n); 
        if ( data.estado == 'registrado' ) {            
            this.getBoton('btnFinPagoVariable').disable();
            this.getBoton('btnborrar_archivo').disable();
            this.getBoton('btnCalPagoVariable').disable();
            this.getBoton('btnRepPagoVariable').disable();
            this.getBoton('btnborrar_calculo').disable();
            this.getBoton('btnLogPagoVariable').disable();
            this.getBoton('btnsubir_archivo').enable();
        }else if (data.estado == 'archivo_cargado'){           
            this.getBoton('btnFinPagoVariable').disable();
            this.getBoton('btnRepPagoVariable').disable();
            this.getBoton('btnborrar_calculo').disable();
            this.getBoton('btnsubir_archivo').disable();
            this.getBoton('btnLogPagoVariable').enable();
            this.getBoton('btnborrar_archivo').enable();
            this.getBoton('btnCalPagoVariable').enable();            
        }else if (data.estado == 'calculado'){            
            this.getBoton('btnsubir_archivo').disable();
            this.getBoton('btnborrar_calculo').enable();
            this.getBoton('btnFinPagoVariable').enable();
            this.getBoton('btnLogPagoVariable').enable();
            this.getBoton('btnborrar_archivo').disable();
            this.getBoton('btnCalPagoVariable').disable();
            this.getBoton('btnRepPagoVariable').enable();        
        }else if(data.estado == 'finalizado'){
            this.getBoton('btnFinPagoVariable').disable();
            this.getBoton('btnborrar_archivo').disable();
            this.getBoton('btnCalPagoVariable').disable();
            this.getBoton('btnsubir_archivo').disable(); 
            this.getBoton('btnborrar_calculo').disable();
            this.getBoton('btnRepPagoVariable').enable();
            this.getBoton('btnLogPagoVariable').enable();
        }
    },    

    logPagoVariable:function(){
        var rec=this.sm.getSelected();
        var NumSelect = this.sm.getCount();
        if(NumSelect != 0){
            Phx.CP.loadWindows('../../../sis_horas_piloto/vista/log_estado/LogEstado.php',
                `<span style="font-size:15px; font-weight:bold;">HISTORIAL PAGO VARIABLE GESTION ${rec.data.gestion} MES DE ${rec.data.literal.toUpperCase()}`,
                {
                    modal:true,
                    width:1000,
                    height:600
                },rec.data,this.idContenedor,'LogEstado')
        }else{
            Ext.MessageBox.alert('Alerta', 'Antes debe seleccionar un item.');
        }
    },

    subirArchivo: function () {
        var rec=this.sm.getSelected();
        var NumSelect = this.sm.getCount();
        if(NumSelect != 0){                    
            Phx.CP.loadWindows('../../../sis_horas_piloto/vista/archivo_horas_piloto/HorasPilotoExcel.php',
                `<span style="font-size:15px; font-weight:bold;">CARGAR ARCHIVO EXCEL ${rec.data.gestion} MES DE ${rec.data.literal.toUpperCase()}`,
                {
                    modal:true,
                    width:450,
                    height:200
                },rec.data,this.idContenedor,'HorasPilotoExcel')
        }else{
            Ext.MessageBox.alert('Alerta', 'Antes debe seleccionar un item.');
        }
    },
    //borrar Datos Calculado 
    borrarCalculo: function(){
        Phx.CP.loadingShow();
        var d = this.sm.getSelected().data;
        var NumSelect = this.sm.getCount();
        if(NumSelect != 0){
            Ext.Ajax.request({            
                url:'../../sis_horas_piloto/control/ArchivoHorasPiloto/eliminarDatosCalculados',
                params:{id_archivo_horas_piloto: d.id_archivo_horas_piloto, ruta_excel: d.archivo},
                success: (resp) => {
                    Phx.CP.loadingHide();
                    var reg = Ext.util.JSON.decode(Ext.util.Format.trim(resp.responseText));
                    if(!reg.ROOT.error){
                        this.reload();
                    }                
                },
                failure: this.conexionFailure,
                timeout:this.timeout,
                scope:this
            });
        }else{
            Ext.MessageBox.alert('Alerta', 'Antes debe seleccionar un item.');
        }
    },

    //Borrar Archivos cargado 
    borrarDetalle: function(){
        Phx.CP.loadingShow();
        var d = this.sm.getSelected().data;
        var NumSelect = this.sm.getCount();
        if(NumSelect != 0){
            Ext.Ajax.request({            
                url:'../../sis_horas_piloto/control/ArchivoHorasPiloto/eliminarArchivoHorPilotoExcel',
                params:{id_archivo_horas_piloto: d.id_archivo_horas_piloto, ruta_excel: d.archivo},
                success: (resp) => {
                    Phx.CP.loadingHide();
                    var reg = Ext.util.JSON.decode(Ext.util.Format.trim(resp.responseText));
                    if(!reg.ROOT.error){
                        this.reload();
                    }                
                },
                failure: this.conexionFailure,
                timeout:this.timeout,
                scope:this
            });
        }else{
            Ext.MessageBox.alert('Alerta', 'Antes debe seleccionar un item.');
        }
    },

    //Llamada a funcion para calular el pago de variable a pilotos
    calPagoVariable: function (){
        Phx.CP.loadingShow();
        var rec = this.sm.getSelected().data;
        var NumSelect = this.sm.getCount();
        if(NumSelect != 0){
            Ext.Ajax.request({
                url:'../../sis_horas_piloto/control/ArchivoHorasPiloto/calculoPagoVariable',
                params:{id_archivo_horas_piloto: rec.id_archivo_horas_piloto},
                success: (resp) => {
                    Phx.CP.loadingHide();
                    var reg = Ext.util.JSON.decode(Ext.util.Format.trim(resp.responseText));
                    if(!reg.ROOT.error){
                        this.reload();
                    }                
                },
                failure: this.conexionFailure,
                timeout:this.timeout,
                scope:this
            });
        }else{
            Ext.MessageBox.alert('Alerta', 'Antes debe seleccionar un item.');
        }    
    },
    //Finalizar el pago variable 
    finPagoVariable: function(){
        Phx.CP.loadingShow();
        var rec = this.sm.getSelected().data;
        var NumSelect = this.sm.getCount();
        if(NumSelect != 0){
            Ext.Ajax.request({
                url:'../../sis_horas_piloto/control/ArchivoHorasPiloto/finalizarPagoVariable',
                params:{id_archivo_horas_piloto: rec.id_archivo_horas_piloto},
                success: (resp) => {
                    Phx.CP.loadingHide();
                    var reg = Ext.util.JSON.decode(Ext.util.Format.trim(resp.responseText));
                    if(!reg.ROOT.error){
                        this.reload();
                    }                
                },
                failure: this.conexionFailure,
                timeout:this.timeout,
                scope:this
            }); 
        }else{
            Ext.MessageBox.alert('Alerta', 'Antes debe seleccionar un item.');
        }            
    },
    repPagoVariable: function (){
            var data = this.getSelectedData();
            var NumSelect = this.sm.getCount();        

			if(NumSelect != 0)
			{	
				Phx.CP.loadingShow();					 				
				Ext.Ajax.request({
								url:'../../sis_horas_piloto/control/ArchivoHorasPiloto/reportePagoVariable',
								params:{id_archivo_horas_piloto:data.id_archivo_horas_piloto},
								success: this.successExport,
								failure: this.conexionFailure,
								timeout:this.timeout,
								scope:this
				});				
			}else{
				Ext.MessageBox.alert('Alerta', 'Antes debe seleccionar un item.');
			}
    },    
    validarFiltros: function () {
        if (this.cmbGestion.isValid()) {
            return true;
        }
        else {
            return false;
        }

    },

    capturarGestion: function (combo, record, index) {    
        this.getParametrosFiltro();
        this.load({params: {start: 0, limit:this.tam_pag}});
    },
    getParametrosFiltro: function () {
        this.store.baseParams.id_gestion = this.cmbGestion.getValue();
    },            
    // descarga de archivo excel cargado
	oncellclick : function(grid, rowIndex, columnIndex, e) {
	    var record = this.store.getAt(rowIndex);  
	    var fieldName = grid.getColumnModel().getDataIndex(columnIndex);        
           
	    if (fieldName == 'archivo' && record.data['archivo'].length!=0) {
            var ruta = record.data['archivo'];            
            var extension = ruta.split('.').pop();            
            window.open(`../../../sis_horas_piloto/vista/archivo_horas_piloto/OpenExcel.php?ruta=${ruta}&ext=${extension}`);                
            }
	}  
})
</script>
		
		
