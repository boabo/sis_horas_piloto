<?php
/**
 *@package pXP
 *@file    HorasPilotoExcel.php
 *@author  BVP
 *@date    20-09-2019
 *@description permite subir archivos csv detalle horas trabajadas de los pilotos
 */
header("content-type: text/javascript; charset=UTF-8");
?>
<script>
    Phx.vista.HorasPilotoExcel=Ext.extend(Phx.frmInterfaz,{

            constructor:function(config)
            {
                Phx.vista.HorasPilotoExcel.superclass.constructor.call(this,config);
                this.init();
                this.loadValoresIniciales();
            },
            loadValoresIniciales:function()
            {                                
                Phx.vista.HorasPilotoExcel.superclass.loadValoresIniciales.call(this);                
                this.getComponente('id_archivo_horas_piloto').setValue(this.id_archivo_horas_piloto);
                this.getComponente('id_gestion').setValue(this.id_gestion);
                this.getComponente('id_periodo').setValue(this.id_periodo);
            },

            successSave:function(resp)
            {
                Phx.CP.loadingHide();
                Phx.CP.getPagina(this.idContenedorPadre).reload();
                this.panel.close();
            },


            Atributos:[
                {
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
                        labelSeparator:'',
                        inputType:'hidden',
                        name: 'id_gestion'

                    },
                    type:'Field',
                    form:true
                },
                {
                    config:{
                        labelSeparator:'',
                        inputType:'hidden',
                        name: 'id_periodo'

                    },
                    type:'Field',
                    form:true
                },                                
                {
                    config:{
                        name:'codigo',
                        fieldLabel:'Codigo Archivo',
                        allowBlank:false,
                        emptyText:'Codigo Archivo...',
                        store: new Ext.data.JsonStore({                            
                            url: '../../sis_horas_piloto/control/ArchivoHorasPiloto/listarPlantillaArchivoExcel',                            
                            id: 'id_plantilla_archivo_excel',
                            root: 'datos',
                            sortInfo:{
                                field: 'codigo',
                                direction: 'ASC'
                            },
                            totalProperty: 'total',
                            fields: ['id_plantilla_archivo_excel','nombre','codigo'],
                            //turn on remote sorting
                            remoteSort: true,
                            baseParams:{par_filtro:'codigo', vista:'vista', archivo: 'HORPILOT'}
                        }),
                        valueField: 'codigo',
                        displayField: 'codigo',
                        //tpl:'<tpl for="."><div class="x-combo-list-item"><p><b>Nombre: {nombre}</b></p><p>{codigo}</p></div></tpl>',
                        hiddenName: 'codigo',
                        forceSelection:true,
                        typeAhead: false,
                        triggerAction: 'all',
                        lazyRender:true,
                        mode:'remote',
                        pageSize:10,
                        queryDelay:1000,
                        listWidth:260,
                        resizable:true,
                        anchor:'90%',
                        tpl: new Ext.XTemplate([
                            '<tpl for=".">',
                            '<div class="x-combo-list-item">',
                            '<p><b>Nombre:</b> <span style="color: blue; font-weight: bold;">{nombre}</span></p>',
                            '<p><b>Codigo:</b> <span style="color: green; font-weight: bold;">{codigo}</span></p>',
                            '</div></tpl>'
                        ])
                    },
                    type:'ComboBox',
                    id_grupo:0,
                    grid:true,
                    form:true
                },
                {
                    config:{
                        fieldLabel: "Documento",
                        gwidth: 130,
                        inputType:'file',
                        name: 'archivo',
                        buttonText: '',
                        maxLength:150,
                        anchor:'100%'
                    },
                    type:'Field',
                    form:true
                }
            ],
            title:'Subir Archivo',
            fileUpload:true,
            ActSave:'../../sis_horas_piloto/control/ArchivoHorasPiloto/cargarArchivoHorPilotoExcel'
        }
    )
</script>