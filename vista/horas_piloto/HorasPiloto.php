<?php
/**
*@package pXP
*@file HorasPiloto.php
*@author  (breydi.vasquez)
*@date 20-09-2019 13:43:39
*@description Archivo con la interfaz de usuario que permite la ejecucion de todas las funcionalidades del sistema
*/

header("content-type: text/javascript; charset=UTF-8");
?>
<script>
Phx.vista.HorasPiloto=Ext.extend(Phx.gridInterfaz,{
	plantaIni:'si',
	constructor:function(config){
		this.maestro=config.maestro;
    	//llama al constructor de la clase padre
		Phx.vista.HorasPiloto.superclass.constructor.call(this,config);
		this.init();
        this.iniciarEventos();
        this.addButton('btnPiHorasVuelo', {
            text: 'Rep. Pilotos Horas Vuelo',
            iconCls:'bexcel',
            disabled: true,
            handler:this.PilHorasVuelo,
            tooltip: '<b>Finaliza</b><br/>Historial de cambios de estado.'
        });
		this.finCons = true;
	},
	gruposBarraTareas:[
			{name: 'si', title: '<h1 style="text-align: center; color: #00B167;">PLANTA</h1>',grupo: 0, height: 0} ,
			{name: 'no', title: '<h1 style="text-align: center; color: #FF8F85;">OTROS</h1>', grupo: 1, height: 1},
			],
	actualizarSegunTab: function(name, indice){
		if(this.finCons){
			(name=='si')?this.plantaIni='si':this.plantaIni='no';
			this.store.baseParams.planta = name;
			this.load({params:{start:0, limit:this.tam_pag}});
		}
	},
	bnewGroups: [],
	bdelGroups:  [],
	bactGroups:  [0,1],
	bexcelGroups: [0,1],
	btnPiHorasVuelo:[0,1],	
	Atributos:[
		{
			//configuracion del componente
			config:{
					labelSeparator:'',
					inputType:'hidden',
					name: 'id_horas_piloto'
			},
			type:'Field',
			form:true
		},
        {
            config: {
                name: 'id_funcionario',
                fieldLabel: 'Nombre Piloto',
                allowBlank: true,
                emptyText: 'Elija una opción...',
                store: new Ext.data.JsonStore({
                    url: '../../sis_organigrama/control/Funcionario/listarFuncionarioCargo',
                    id: 'id_funcionario',
                    root: 'datos',
                    sortInfo: {
                        field: 'desc_funcionario1',
                        direction: 'ASC'
                    },
                    totalProperty: 'total',
                    fields: ['id_funcionario','desc_funcionario1','ci','email_empresa','nombre_cargo','lugar_nombre','oficina_nombre'],
                    remoteSort: true,
                    baseParams: {par_filtro: 'FUNCAR.desc_funcionario1#ci#nombre_cargo'}
                }),
                valueField: 'id_funcionario',
                displayField: 'desc_funcionario1',
                gdisplayField: 'nombre_piloto',
                tpl:'<tpl for="."><div class="x-combo-list-item" style="color: black"><p><b>{desc_funcionario1}</b></p><p style="color: #80251e">{nombre_cargo}<br>{email_empresa}</p><p style="color:green">{oficina_nombre} - {lugar_nombre}</p></div></tpl>',
                hiddenName: 'id_funcionario',
                forceSelection: true,
                typeAhead: false,
                triggerAction: 'all',
                lazyRender: true,
                mode: 'remote',
                pageSize: 20,
                queryDelay: 1000,
                anchor: '60%',
                width: 260,
                gwidth: 250,
                minChars: 2,
                resizable:true,
                listWidth:'240',
                renderer: function (value, p, record) {
                    return String.format('{0}', record.data['nombre_piloto']);
                }
            },
            type: 'ComboBox',
            bottom_filter:true,
            id_grupo:1,
            filters:{
                pfiltro:'hopilo.nombre_piloto',
                type:'string'
            },
            grid: true,
            form: true
        },
		/*{
			config:{
				name: 'nombre_piloto',
				fieldLabel: 'Nombre Piloto',
				allowBlank: true,
				anchor: '70%',
				gwidth: 150,
				maxLength:500
			},
				type:'TextField',
				filters:{pfiltro:'hopilo.nombre_piloto',type:'string'},
				id_grupo:1,
				grid:true,
				form:true
		},*/
		{
			config:{
				name: 'ci',
				fieldLabel: 'CI',
				allowBlank: true,
				anchor: '40%',
				gwidth: 100,
				maxLength:20
			},
				type:'TextField',
				filters:{pfiltro:'hopilo.ci',type:'string'},
                bottom_filter: true,
				id_grupo:1,
				grid:true,
				form:true
		},
		{
			config:{
				name: 'pic_sic',
				fieldLabel: 'Piloto || Copiloto Item ERP',
				allowBlank: true,
				anchor: '40%',
				gwidth: 150,
                renderer: (value) => {
                    if(value == 'PIC'){
                        return String.format('<div style="color:blue;font-weight:bold;">Piloto</div>');
                    }else if(value == 'SIC'){
                        return String.format('<div style="color:black;font-weight:bold;">CoPiloto</div>');
                    }else{
                        return '';
                    }
                }
			},
				type:'TextField',
				filters:{pfiltro:'hopilo.pic_sic',type:'string'},
                bottom_filter: true,
				id_grupo:1,
				grid:true,
				form:true
		},
		{
			config:{
				name: 'pic_sic_servicio',
				fieldLabel: 'Piloto || Copiloto SICNO',
				allowBlank: true,
				anchor: '40%',
				gwidth: 150,
                renderer: (value) => {
                    if(value == 'PIC'){
                        return String.format('<div style="color:blue;font-weight:bold;">Piloto</div>');
                    }else if(value == 'SIC'){
                        return String.format('<div style="color:black;font-weight:bold;">CoPiloto</div>');
                    }else{
                        return '';
                    }
                }
			},
				type:'TextField',
				filters:{pfiltro:'hopilo.pic_sic',type:'string'},
                bottom_filter: true,
				id_grupo:1,
				grid:true,
				form:true
		},		
		{
			config:{
				name: 'escala_salarial',
				fieldLabel: 'Cargo',
				allowBlank: true,
				anchor: '80%',
				gwidth: 140,
			},
				type:'TextField',
				id_grupo:1,
				grid:true,
				form:true
		},
		{
			config:{
				name: 'tipo_flota',
				fieldLabel: 'Tipo Flota',
				allowBlank: true,
				anchor: '40%',
				gwidth: 100,
				maxLength:100,
                renderer: (value, p, record) => {
                    if (value == 'largo_alcance'){
                        return 'Largo Alcance';
                    }else if (value == 'mediano_alcance'){
                        return 'Mediano Alcance';
                    }else if (value == 'corto_alcance'){
                        return 'Corto Alcance';
                    }
                }
			},
				type:'TextField',
				filters:{pfiltro:'hopilo.tipo_flota',type:'string'},
                bottom_filter: true,
				id_grupo:1,
				grid:true,
				form:true
		},
		{
			config:{
				name: 'horas_vuelo',
				fieldLabel: 'Horas Vuelo',
				allowBlank: true,
				anchor: '40%',
				gwidth: 100,
                renderer: (value, p, record) => {
                    return  String.format('<div style="text-align:center;">{0}</div>', value);
                }
			},
				type:'NumberField',
				filters:{pfiltro:'hopilo.horas_vuelo',type:'numeric'},
				id_grupo:1,
				grid:true,
				form:true
		},
		{
			config:{
				name: 'horas_simulador_full',
				fieldLabel: 'Horas Simulador Full',
				allowBlank: true,
				anchor: '40%',
				gwidth: 150,
                renderer: (value, p, record) => {
                    if (value == null) {
                        return  '';
                    }else{
                        return  String.format('<div style="text-align:center;">{0}</div>', value);
                    }
                }
			},
				type:'NumberField',
				filters:{pfiltro:'hopilo.horas_simulador_full',type:'numeric'},
				id_grupo:1,
				grid:true,
				form:true
		},
		{
			config:{
				name: 'horas_simulador_fix',
				fieldLabel: 'Horas Simulador Fix',
				allowBlank: true,
				anchor: '40%',
				gwidth: 120,
                renderer: (value,p,record) => {
                        if (value == null){
                            return  '';
                        }else{
                            return  String.format('<div style="text-align:center;">{0}</div>', value);
                        }
                }
			},
				type:'NumberField',
				filters:{pfiltro:'hopilo.horas_simulador_fix',type:'numeric'},
				id_grupo:1,
				grid:true,
				form:true
		},
		{
			config:{
				name: 'horas_simulador_full_efectivas',
				fieldLabel: 'Horas Efectivas Full',
				allowBlank: true,
				anchor: '40%',
				gwidth: 120,
                renderer: (value,p,record) => {
                        if (value == null){
                            return  '';
                        }else{
                            return  String.format('<div style="text-align:center;">{0}</div>', value);
                        }
                }
			},
				type:'NumberField',
				filters:{pfiltro:'hopilo.horas_simulador_fix',type:'numeric'},
				id_grupo:1,
				grid:true,
				form:true
		},
		{
			config:{
				name: 'horas_simulador_fix_efectivas',
				fieldLabel: 'Horas Efectivas Fix',
				allowBlank: true,
				anchor: '40%',
				gwidth: 120,
                renderer: (value,p,record) => {
                    if(record.data.tipo_reg != 'summary'){
                        if (value == null){
                            return  '';
                        }else{
                            return  String.format('<div style="text-align:center;">{0}</div>', value);
                        }
                    }
                    else{
                        return '<hr><center><b><p style=" color:green; font-size:15px;">Total: </p></b></center>';
                    }
                }
			},
				type:'NumberField',
				filters:{pfiltro:'hopilo.horas_simulador_fix',type:'numeric'},
				id_grupo:1,
				grid:true,
				form:true
		},
		{
			config:{
				name: 'pago_variable',
				fieldLabel: 'Pago Variable(bs)',
				allowBlank: false,
				anchor: '40%',
				gwidth: 100,
                renderer: (value, p, record) => {
                    if(record.data.tipo_reg != 'summary'){
                        return  String.format('<div style="text-align:right;">{0}</div>', Ext.util.Format.number(value,'0.000,00/i'));
                    }else{
                        return  String.format('<hr><div style="font-size:15px; float:right; color:black;"><b><font>{0}</font><b></div>', Ext.util.Format.number(record.data.total_pago_variable,'0.000,00/i'));
                    }
                }
			},
				type:'NumberField',
				id_grupo:1,
				grid:true,
				form:false
		},
		{
			config:{
				name: 'factor_esfuerzo',
				fieldLabel: 'Factor Esfuerzo',
				allowBlank: false,
				anchor: '40%',
				gwidth: 100,
                renderer: (value, p, record) => {
                    return  String.format('<div style="text-align:right;">{0}</div>', Ext.util.Format.number(value,'0.000,00/i'));
                }
			},
				type:'NumberField',
				id_grupo:1,
				grid:true,
				form:false
		},
		{
			config:{
				name: 'monto_horas_vuelo',
				fieldLabel: 'Monto horas vuelo(bs)',
				allowBlank: false,
				anchor: '40%',
				gwidth: 150,
                renderer: (value, p, record) => {
                    return  String.format('<div style="text-align:right;">{0}</div>', Ext.util.Format.number(value,'0.000,00/i'));
                }
			},
				type:'NumberField',
				id_grupo:1,
				grid:true,
				form:false
		},
		{
			config:{
				name: 'monto_horas_simulador_full',
				fieldLabel: 'Monto simulador full(bs)',
				allowBlank: false,
				anchor: '40%',
				gwidth: 150,
                renderer: (value, p, record) => {
                    return  String.format('<div style="text-align:right;">{0}</div>', Ext.util.Format.number(value,'0.000,00/i'));
                }
			},
				type:'NumberField',
				id_grupo:1,
				grid: true,
				form: false
		},
		{
			config:{
				name: 'monto_horas_simulador_fix',
				fieldLabel: 'Monto simulador fix(bs)',
				allowBlank: false,
				anchor: '40%',
				gwidth: 150,
                renderer: (value, p, record) => {
                    return  String.format('<div style="text-align:right;">{0}</div>', Ext.util.Format.number(value,'0.000,00/i'));
                }
			},
				type:'NumberField',
				id_grupo:1,
				grid: true,
				form: false
		},
		{
			config:{
				name: 'gestion',
				fieldLabel: 'gestion',
				allowBlank: false,
				anchor: '50%',
				gwidth: 50,
				maxLength:4
			},
				type:'NumberField',
				filters:{pfiltro:'hopilo.gestion',type:'numeric'},
				id_grupo:1,
				grid:true,
				form:false
		},
		{
			config:{
				name: 'mes',
				fieldLabel: 'Mes',
				allowBlank: false,
				anchor: '80%',
				gwidth: 80,
				maxLength:4
			},
				type:'Field',
				filters:{pfiltro:'hopilo.mes',type:'numeric'},
				id_grupo:1,
				grid:true,
				form:false
		},
		{
			config:{
				name: 'estado',
				fieldLabel: 'Estado',
				allowBlank: false,
				anchor: '80%',
				gwidth: 100,
				maxLength:50
			},
				type:'TextField',
				filters:{pfiltro:'hopilo.estado',type:'string'},
				id_grupo:1,
				grid:false,
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
				gwidth: 100,
							format: 'd/m/Y',
							renderer:function (value,p,record){return value?value.dateFormat('d/m/Y H:i:s'):''}
			},
				type:'DateField',
				filters:{pfiltro:'hopilo.fecha_reg',type:'date'},
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
				filters:{pfiltro:'hopilo.id_usuario_ai',type:'numeric'},
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
				filters:{pfiltro:'hopilo.usuario_ai',type:'string'},
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
				filters:{pfiltro:'hopilo.fecha_mod',type:'date'},
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
				filters:{pfiltro:'hopilo.estado_reg',type:'string'},
				id_grupo:1,
				grid:true,
				form:false
		}
	],
	tam_pag:50,
	title:'Detalle Calculo sueldo piloto',
	ActSave:'../../sis_horas_piloto/control/HorasPiloto/insertarHorasPiloto',
	ActDel:'../../sis_horas_piloto/control/HorasPiloto/eliminarHorasPiloto',
	ActList:'../../sis_horas_piloto/control/HorasPiloto/listarHorasPiloto',
	id_store:'id_horas_piloto',
	fields: [
		{name:'id_horas_piloto', type: 'numeric'},
		{name:'estado_reg', type: 'string'},
		{name:'gestion', type: 'numeric'},
		{name:'mes', type: 'string'},
		{name:'ci', type: 'string'},
		{name:'nombre_piloto', type: 'string'},
        {name:'escala_salarial', type: 'string'},
		{name:'tipo_flota', type: 'string'},
		{name:'horas_vuelo', type: 'numeric'},
		{name:'horas_simulador_full', type: 'numeric'},
		{name:'horas_simulador_fix', type: 'numeric'},
        {name:'factor_esfuerzo', type:'numeric'},
        {name:'pago_variable', type:'numeric'},
        {name:'monto_horas_vuelo', type:'numeric'},
        {name:'monto_horas_simulador_full', type:'numeric'},
        {name:'monto_horas_simulador_fix', type:'numeric'},
        {name:'tipo_reg', type: 'string'},
        {name:'total_pago_variable', type: 'numeric'},
		{name:'estado', type: 'string'},
        {name:'pic_sic', type: 'string'},
        {name:'monto_horas_simulador_full', type: 'numeric'},
        {name:'monto_horas_simulador_fix', type: 'string'},
		{name:'id_usuario_reg', type: 'numeric'},
		{name:'fecha_reg', type: 'date',dateFormat:'Y-m-d H:i:s.u'},
		{name:'id_usuario_ai', type: 'numeric'},
		{name:'usuario_ai', type: 'string'},
		{name:'id_usuario_mod', type: 'numeric'},
		{name:'fecha_mod', type: 'date',dateFormat:'Y-m-d H:i:s.u'},
		{name:'usr_reg', type: 'string'},
		{name:'usr_mod', type: 'string'},
        {name:'id_funcionario', type:'numeric'},
        {name:'pic_sic_servicio', type:'string'}

	],
	sortInfo:{
		field: 'nombre_piloto',
		direction: 'ASC'
	},
	bdel: false,
	bsave: false,
    btest: false,
    bnew: false,
    bedit: false,


	onReloadPage:function(m)
	{		
		this.maestro=m;
		this.store.baseParams={id_archivo_horas_piloto:this.maestro.id_archivo_horas_piloto, planta: this.plantaIni};
		this.load({params:{start:0, limit:50}});
	},

	loadValoresIniciales:function()
	{
		Phx.vista.HorasPiloto.superclass.loadValoresIniciales.call(this);
		this.getComponente('id_archivo_horas_piloto').setValue(this.maestro.id_archivo_horas_piloto);
	},
    iniciarEventos:function(){
        this.Cmp.id_funcionario.on('select', (c, r, n) => {
            this.Cmp.ci.reset();
            this.Cmp.ci.setValue(r.data.ci);
            this.Cmp.ci.modificado = true;
        },this);


    },
    PilHorasVuelo: function (){
            var data = this.maestro.id_archivo_horas_piloto;
            Phx.CP.loadingShow();
            Ext.Ajax.request({
                            url:'../../sis_horas_piloto/control/ArchivoHorasPiloto/reportePiHorasVuelo',
                            params:{id_archivo_horas_piloto: data},
                            success: this.successExport,
                            failure: this.conexionFailure,
                            timeout:this.timeout,
                            scope:this
            });
    }
})
</script>
