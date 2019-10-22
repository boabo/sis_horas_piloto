<?php
/**
 *@package pXP
 *@file gen-Anexo1.php
 *@author  (admin)
 *@date 26-09-2019 12:54:57
 *@description Archivo con la interfaz de usuario que permite la ejecucion de todas las funcionalidades del sistema
 */

header("content-type: text/javascript; charset=UTF-8");
?>
<script>
    Phx.vista.Anexo1=Ext.extend(Phx.gridInterfaz,{

            constructor:function(config){
                this.maestro=config.maestro;
                //llama al constructor de la clase padre
                Phx.vista.Anexo1.superclass.constructor.call(this,config);
                this.init();
                this.load({params:{start:0, limit:this.tam_pag}})
            },

            Atributos:[
                {
                    //configuracion del componente
                    config:{
                        labelSeparator:'',
                        inputType:'hidden',
                        name: 'id_anexo1'
                    },
                    type:'Field',
                    form:true
                },
                {
                    config: {
                        name: 'id_escala_salarial',
                        fieldLabel: 'Escala Salarial',
                        allowBlank: false,
                        emptyText: 'Escala Salarial...',
                        store: new Ext.data.JsonStore({
                            url: '../../sis_organigrama/control/EscalaSalarial/ListarEscalaSalarial',
                            id: 'id_escala_salarial',
                            root: 'datos',
                            sortInfo: {
                                field: 'nombre',
                                direction: 'ASC'
                            },
                            totalProperty: 'total',
                            fields: ['id_escala_salarial', 'nombre', 'codigo','haber_basico'],
                            remoteSort: true,
                            baseParams: {par_filtro: 'nombre#codigo#haber_basico'}
                        }),
                        valueField: 'id_escala_salarial',
                        displayField: 'nombre',
                        gdisplayField: 'desc_nombre_salarial',
                        tpl : '<tpl for="."><div class="x-combo-list-item"><p>Nombre: {nombre}</p><p>Código: {codigo}</p><p>Haber Basico: {haber_basico}</p></div></tpl>',
                        hiddenName: 'id_escala_salarial',
                        forceSelection: true,
                        typeAhead: false,
                        triggerAction: 'all',
                        lazyRender: true,
                        mode: 'remote',
                        pageSize: 15,
                        queryDelay: 1000,
                        anchor: '70%',
                        gwidth: 300,
                        minChars: 2,
                        resizable:true,
                        renderer : function(value, p, record) {
                            return String.format('{0}', record.data['desc_nombre_salarial']);
                        }
                    },
                    type: 'ComboBox',
                    id_grupo: 0,
                    filters: {pfiltro: 'escsal.nombre',type: 'string'},
                    bottom_filter: true,
                    grid: true,
                    form: true
                },
                {
                    config:{
                        name: 'numero_casos',
                        fieldLabel: 'Numero Casos',
                        allowBlank: true,
                        anchor: '40%',
                        gwidth: 100,
                        maxLength:4
                    },
                    type:'NumberField',
                    filters:{pfiltro:'tipane1.numero_casos',type:'numeric'},
                    id_grupo:1,
                    bottom_filter: true,
                    grid:true,
                    form:true
                },
                {
                    config:{
                        name: 'remuneracion_basica',
                        fieldLabel: 'Remuneracion Basica',
                        allowBlank: true,
                        anchor: '40%',
                        gwidth: 150,
                        maxLength:1179650,
                        galign:'right',
                        renderer:function (value,p,record){
                            return  String.format('{0}', value.toString().replace('.', ',').replace(/(\d)(?=(\d{3})+(?!\d))/g, '$1.'));
                        }
                    },
                    type:'NumberField',
                    filters:{pfiltro:'tipane1.remuneracion_basica',type:'numeric'},
                    id_grupo:1,
                    bottom_filter: true,
                    grid:true,
                    form:true
                },
                {
                    config:{
                        name: 'remuneracion_maxima',
                        fieldLabel: 'Remuneracion Maxima',
                        allowBlank: true,
                        anchor: '40%',
                        gwidth: 150,
                        maxLength:1179650,
                        galign:'right',
                        renderer:function (value,p,record){
                            return  String.format('{0}', value.toString().replace('.', ',').replace(/(\d)(?=(\d{3})+(?!\d))/g, '$1.'));
                        }
                    },
                    type:'NumberField',
                    filters:{pfiltro:'tipane1.remuneracion_maxima',type:'numeric'},
                    id_grupo:1,
                    bottom_filter: true,
                    grid:true,
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
                        anchor : '40%',
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
                    filters:{pfiltro:'tipane1.tipo_flota',type:'string'},
                    id_grupo:1,
                    bottom_filter: true,
                    grid:true,
                    form:true
                },
                {
                    config:{
                        name: 'pic_sic',
                        fieldLabel: 'Pic Sic',
                        allowBlank : false,
                        triggerAction : 'all',
                        lazyRender : true,
                        mode : 'local',
                        store : new Ext.data.ArrayStore({
                            fields : ['codigo', 'nombre'],
                            data : [['PIC', 'Piloto'], ['SIC', 'Copiloto']]
                        }),
                        anchor : '40%',
                        valueField : 'codigo',
                        displayField : 'nombre',
                        gwidth:100,
                        renderer: function(value, p, record){
                            var aux;
                            switch (value) {
                                case 'PIC':
                                    aux = 'Piloto';
                                    break;
                                case 'SIC':
                                    aux = 'Copiloto';
                                    break;
                                default:
                                    aux = 'Otros';
                            }
                            return String.format('{0}', aux);
                        }
                    },
                    type:'ComboBox',
                    filters:{pfiltro:'pic_sic',type:'string'},
                    filters:{ type: 'list',
                        options: ['PIC','SIC']
                    },
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
                    filters:{pfiltro:'tipane1.fecha_reg',type:'date'},
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
                    filters:{pfiltro:'tipane1.estado_reg',type:'string'},
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
                    filters:{pfiltro:'tipane1.id_usuario_ai',type:'numeric'},
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
                    filters:{pfiltro:'tipane1.usuario_ai',type:'string'},
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
                    filters:{pfiltro:'tipane1.fecha_mod',type:'date'},
                    id_grupo:1,
                    grid:true,
                    form:false
                }
            ],
            tam_pag:50,
            title:'Tipo Anexo1',
            ActSave:'../../sis_horas_piloto/control/Anexo1/insertarAnexo1',
            ActDel:'../../sis_horas_piloto/control/Anexo1/eliminarAnexo1',
            ActList:'../../sis_horas_piloto/control/Anexo1/listarAnexo1',
            id_store:'id_anexo1',
            fields: [
                {name:'id_anexo1', type: 'numeric'},
                {name:'estado_reg', type: 'string'},
                {name:'id_escala_salarial', type: 'numeric'},
                {name:'numero_casos', type: 'numeric'},
                {name:'remuneracion_basica', type: 'numeric'},
                {name:'remuneracion_maxima', type: 'numeric'},
                {name:'tipo_flota', type: 'string'},
                {name:'pic_sic', type: 'string'},
                {name:'id_usuario_reg', type: 'numeric'},
                {name:'fecha_reg', type: 'date',dateFormat:'Y-m-d H:i:s.u'},
                {name:'id_usuario_ai', type: 'numeric'},
                {name:'usuario_ai', type: 'string'},
                {name:'id_usuario_mod', type: 'numeric'},
                {name:'fecha_mod', type: 'date',dateFormat:'Y-m-d H:i:s.u'},
                {name:'usr_reg', type: 'string'},
                {name:'usr_mod', type: 'string'},
                {name:'desc_nombre_salarial', type: 'string'},


            ],
            sortInfo:{
                field: 'id_anexo1',
                direction: 'ASC'
            },
            bdel:true,
            bsave:false,
            btest:false
        }
    )
</script>

		