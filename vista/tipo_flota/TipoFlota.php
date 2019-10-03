<?php
/**
*@package pXP
*@file gen-TipoFlota.php
*@author  (admin)
*@date 26-09-2019 13:05:35
*@description Archivo con la interfaz de usuario que permite la ejecucion de todas las funcionalidades del sistema
*/

header("content-type: text/javascript; charset=UTF-8");
?>
<script>
Phx.vista.TipoFlota=Ext.extend(Phx.gridInterfaz,{

	constructor:function(config){
		this.maestro=config.maestro;
    	//llama al constructor de la clase padre
		Phx.vista.TipoFlota.superclass.constructor.call(this,config);
		this.init();
		this.load({params:{start:0, limit:this.tam_pag}})
	},
			
	Atributos:[
		{
			//configuracion del componente
			config:{
					labelSeparator:'',
					inputType:'hidden',
					name: 'id_tipo_flota'
			},
			type:'Field',
			form:true 
		},
		{
			config:{
				name: 'tipo_flota',
				fieldLabel: 'Tipo Flota',
                allowBlank : false,
                triggerAction : 'all',
                lazyRender : true,
                mode : 'local',
                store : new Ext.data.ArrayStore({
                    fields : ['codigo', 'nombre'],
                    data : [['largo_alcance', 'Largo Alcance'], ['mediano_alcance', 'Mediano Alcance'], ['corto_alcance', 'Corto Alcance']]
                }),
                anchor : '50%',
                valueField : 'codigo',
                displayField : 'nombre',
                gwidth:100,
                renderer: function(value, p, record){
                    var aux;
                    switch (value) {
                        case 'corto_alcance':
                            aux = 'Corto Alcance';
                            break;
                        case 'mediano_alcance':
                            aux = 'Mediano Alcance';
                            break;
                        case 'largo_alcance':
                            aux = 'Largo Alcance';
                            break;
                        default:
                            aux = 'Otros';
                    }
                    return String.format('{0}', aux);
                }
			},
				type:'ComboBox',
				filters:{pfiltro:'tipflo.tipo_flota',type:'string'},
				id_grupo:1,
                bottom_filter: true,
				grid:true,
				form:true
		},
		{
			config:{
				name: 'costo_hora_base_pic',
				fieldLabel: 'Costo Hora Base PIC',
				allowBlank: false,
				anchor: '40%',
				gwidth: 140,
				maxLength:1310722,
                galign:'right',
                renderer:function (value,p,record){
				    return  String.format('{0}', value.toString().replace('.', ',').replace(/(\d)(?=(\d{3})+(?!\d))/g, '$1.'));
                }
			},
				type:'NumberField',
				filters:{pfiltro:'tipflo.costo_hora_base_pic',type:'numeric'},
				id_grupo:1,
                bottom_filter: true,
				grid:true,
				form:true
		},
		{
			config:{
				name: 'costo_hora_base_sic',
				fieldLabel: 'Costo Hora Base SIC',
				allowBlank: false,
				anchor: '40%',
				gwidth: 140,
				maxLength:1310722,
                galign:'right',
                renderer:function (value,p,record){
                    return  String.format('{0}', value.toString().replace('.', ',').replace(/(\d)(?=(\d{3})+(?!\d))/g, '$1.'));
                }
			},
				type:'NumberField',
				filters:{pfiltro:'tipflo.costo_hora_base_sic',type:'numeric'},
				id_grupo:1,
                bottom_filter: true,
				grid:true,
				form:true
		},
		{
			config:{
				name: 'horas_base',
				fieldLabel: 'Horas Base',
				allowBlank: true,
				anchor: '40%',
				gwidth: 100,
				maxLength:4,
                renderer:function (value,p,record){
                    return  String.format('{0}', Math.trunc(value));
                }
			},
				type:'NumberField',
				filters:{pfiltro:'tipflo.horas_base',type:'numeric'},
				id_grupo:1,
                bottom_filter: true,
				grid:true,
				form:true
		},
		{
			config:{
				name: 'relacion_ciclo_hora',
				fieldLabel: 'Relacion Ciclo Hora',
				allowBlank: false,
				anchor: '40%',
				gwidth: 100,
				maxLength:1310722
			},
				type:'NumberField',
				filters:{pfiltro:'tipflo.relacion_ciclo_hora',type:'numeric'},
				id_grupo:1,
				grid:true,
				form:true
		},
		{
			config:{
				name: 'maximo_horas',
				fieldLabel: 'Maximo Horas',
				allowBlank: true,
				anchor: '40%',
				gwidth: 100,
				maxLength:4
			},
				type:'NumberField',
				filters:{pfiltro:'tipflo.maximo_horas',type:'numeric'},
				id_grupo:1,
				grid:true,
				form:true
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
				filters:{pfiltro:'tipflo.fecha_reg',type:'date'},
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
            filters:{pfiltro:'tipflo.estado_reg',type:'string'},
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
				filters:{pfiltro:'tipflo.id_usuario_ai',type:'numeric'},
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
				filters:{pfiltro:'tipflo.usuario_ai',type:'string'},
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
				filters:{pfiltro:'tipflo.fecha_mod',type:'date'},
				id_grupo:1,
				grid:true,
				form:false
		}
	],
	tam_pag:50,	
	title:'Tipo Flota',
	ActSave:'../../sis_horas_piloto/control/TipoFlota/insertarTipoFlota',
	ActDel:'../../sis_horas_piloto/control/TipoFlota/eliminarTipoFlota',
	ActList:'../../sis_horas_piloto/control/TipoFlota/listarTipoFlota',
	id_store:'id_tipo_flota',
	fields: [
		{name:'id_tipo_flota', type: 'numeric'},
		{name:'estado_reg', type: 'string'},
		{name:'tipo_flota', type: 'string'},
		{name:'costo_hora_base_pic', type: 'numeric'},
		{name:'costo_hora_base_sic', type: 'numeric'},
		{name:'horas_base', type: 'numeric'},
		{name:'relacion_ciclo_hora', type: 'numeric'},
		{name:'maximo_horas', type: 'numeric'},
		{name:'id_usuario_reg', type: 'numeric'},
		{name:'fecha_reg', type: 'date',dateFormat:'Y-m-d H:i:s.u'},
		{name:'id_usuario_ai', type: 'numeric'},
		{name:'usuario_ai', type: 'string'},
		{name:'id_usuario_mod', type: 'numeric'},
		{name:'fecha_mod', type: 'date',dateFormat:'Y-m-d H:i:s.u'},
		{name:'usr_reg', type: 'string'},
		{name:'usr_mod', type: 'string'},
		
	],
	sortInfo:{
		field: 'id_tipo_flota',
		direction: 'ASC'
	},
	bdel:true,
	bsave:false,
    btest:false
	}
)
</script>
		
		