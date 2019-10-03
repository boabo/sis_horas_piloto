<?php
/**
 *@package pXP
 *@file gen-TipoSimulador.php
 *@author  (admin)
 *@date 24-09-2019 14:13:43
 *@description Archivo con la interfaz de usuario que permite la ejecucion de todas las funcionalidades del sistema
 */

header("content-type: text/javascript; charset=UTF-8");
?>
<script>
    Phx.vista.TipoSimulador=Ext.extend(Phx.gridInterfaz,{

            constructor:function(config){
                this.maestro=config.maestro;
                //llama al constructor de la clase padre
                Phx.vista.TipoSimulador.superclass.constructor.call(this,config);
                this.init();
                this.load({params:{start:0, limit:this.tam_pag}})
            },

            Atributos:[
                {
                    //configuracion del componente
                    config:{
                        labelSeparator:'',
                        inputType:'hidden',
                        name: 'id_tipo_simulador'
                    },
                    type:'Field',
                    form:true
                },

                {
                    config:{
                        name: 'tipo_simulador',
                        fieldLabel: 'Tipo Simulador',
                        allowBlank: false,
                        anchor: '50%',
                        gwidth: 150,
                        /*maxLength:1310722*/
                    },
                    type:'TextField',
                    filters:{pfiltro:'tipsimu.tipo_simulador',type:'string'},
                    id_grupo:1,
                    bottom_filter: true,
                    grid:true,
                    form:true
                },
                {
                    config:{
                        name: 'costo_hora',
                        fieldLabel: 'Costo Hora',
                        allowBlank: false,
                        anchor: '50%',
                        gwidth: 100,
                        maxLength:1310722,
                        galign:'right',
                        renderer:function (value,p,record){
                            return  String.format('{0}', value.toString().replace('.', ',').replace(/(\d)(?=(\d{3})+(?!\d))/g, '$1.'));
                        }
                    },
                    type:'NumberField',
                    filters:{pfiltro:'tipsimu.costo_hora',type:'numeric'},
                    id_grupo:1,
                    bottom_filter: true,
                    grid:true,
                    form:true
                },
                {
                    config:{
                        name: 'maximo_horas',
                        fieldLabel: 'Maximo Horas',
                        allowBlank: true,
                        anchor: '50%',
                        gwidth: 100,
                        maxLength:4
                    },
                    type:'NumberField',
                    filters:{pfiltro:'tipsimu.maximo_horas',type:'numeric'},
                    id_grupo:1,
                    bottom_filter: true,
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
                    filters:{pfiltro:'tipsimu.fecha_reg',type:'date'},
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
                    filters:{pfiltro:'tipsimu.estado_reg',type:'string'},
                    id_grupo:1,
                    grid:false,
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
                    filters:{pfiltro:'tipsimu.id_usuario_ai',type:'numeric'},
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
                    filters:{pfiltro:'tipsimu.usuario_ai',type:'string'},
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
                    filters:{pfiltro:'tipsimu.fecha_mod',type:'date'},
                    id_grupo:1,
                    grid:true,
                    form:false
                }
            ],
            tam_pag:50,
            title:'Tipo Simulador',
            ActSave:'../../sis_horas_piloto/control/TipoSimulador/insertarTipoSimulador',
            ActDel:'../../sis_horas_piloto/control/TipoSimulador/eliminarTipoSimulador',
            ActList:'../../sis_horas_piloto/control/TipoSimulador/listarTipoSimulador',
            id_store:'id_tipo_simulador',
            fields: [
                {name:'id_tipo_simulador', type: 'numeric'},
                {name:'estado_reg', type: 'string'},
                {name:'tipo_simulador', type: 'string'},
                {name:'costo_hora', type: 'numeric'},
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
                field: 'id_tipo_simulador',
                direction: 'ASC'
            },
            bdel:true,
            bsave:false,
            btest:false
        }
    )
</script>

		