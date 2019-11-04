<?php
/**
*@package pXP
*@file ACTArchivoHorasPiloto.php
*@author  (breydi.vasquez)
*@date 20-09-2019 13:42:10
*@description Clase que recibe los parametros enviados por la vista para mandar a la capa de Modelo
*/
include_once(dirname(__FILE__).'/../../lib/lib_general/ExcelInput.php');
include_once(dirname(__FILE__).'/../reportes/ReportePagoVariableXLS.php');
include_once(dirname(__FILE__).'/../reportes/ReportePiHorasVueloXLS.php');

class ACTArchivoHorasPiloto extends ACTbase{    
			
	function listarArchivoHorasPiloto(){
		$this->objParam->defecto('ordenacion','id_archivo_horas_piloto');
        $this->objParam->defecto('dir_ordenacion','asc');

        $this->objParam->getParametro('id_gestion') != '' && $this->objParam->addFiltro("arhopi.id_gestion = ".$this->objParam->getParametro('id_gestion'));

		if($this->objParam->getParametro('tipoReporte')=='excel_grid' || $this->objParam->getParametro('tipoReporte')=='pdf_grid'){
			$this->objReporte = new Reporte($this->objParam,$this);
			$this->res = $this->objReporte->generarReporteListado('MODArchivoHorasPiloto','listarArchivoHorasPiloto');
		} else{
			$this->objFunc=$this->create('MODArchivoHorasPiloto');
			
			$this->res=$this->objFunc->listarArchivoHorasPiloto($this->objParam);
		}
		$this->res->imprimirRespuesta($this->res->generarJson());
	}
				
	function insertarArchivoHorasPiloto(){
		$this->objFunc=$this->create('MODArchivoHorasPiloto');	
		if($this->objParam->insertar('id_archivo_horas_piloto')){
			$this->res=$this->objFunc->insertarArchivoHorasPiloto($this->objParam);			
		} else{			
			$this->res=$this->objFunc->modificarArchivoHorasPiloto($this->objParam);
        }
		$this->res->imprimirRespuesta($this->res->generarJson());
    }					
	function eliminarArchivoHorasPiloto(){
		$this->objFunc=$this->create('MODArchivoHorasPiloto');	
		$this->res=$this->objFunc->eliminarArchivoHorasPiloto($this->objParam);
		$this->res->imprimirRespuesta($this->res->generarJson());
    }

    function cargarArchivoHorPilotoExcel(){
        //validar extnsion del archivo
        $id_archivo_horas_piloto = $this->objParam->getParametro('id_archivo_horas_piloto');

        $codigoArchivo = $this->objParam->getParametro('codigo');        
        $arregloFiles = $this->objParam->getArregloFiles();
        $ext = pathinfo($arregloFiles['archivo']['name']);
        $extension = $ext['extension'];
                
        $file_name = md5($id_archivo_horas_piloto . $_SESSION["_SEMILLA"]).".$extension";
        $arregloFiles['archivo']['name'] = $file_name;

        $error = 'no';
        $mensaje_completo = '';
        //validar errores unicos del archivo: existencia, copia y extension
        if(isset($arregloFiles['archivo']) && is_uploaded_file($arregloFiles['archivo']['tmp_name'])){
            //procesa Archivo
            $archivoExcel = new ExcelInput($arregloFiles['archivo']['tmp_name'], $codigoArchivo);
            $archivoExcel->recuperarColumnasExcel();

            $arrayArchivo = $archivoExcel->leerColumnasArchivoExcel();
            
            foreach ($arrayArchivo as $fila) {

                $this->objParam->addParametro('id_archivo_horas_piloto', $id_archivo_horas_piloto);
                $this->objParam->addParametro('gestion', $fila['gestion']);
                $this->objParam->addParametro('periodo', $fila['periodo']);
                $this->objParam->addParametro('ci', $fila['ci']);
                $this->objParam->addParametro('nombre_piloto', $fila['nombre_piloto']);           
                $this->objParam->addParametro('horas_simulador_full', $fila['horas_simulador_full']);
                $this->objParam->addParametro('horas_simulador_fix', $fila['horas_simulador_fix']);    
                $this->objFunc = $this->create('sis_horas_piloto/MODHorasPiloto');
                $this->res = $this->objFunc->cargarArchivoHorPilotoExcel($this->objParam);
                                
                if($this->res->getTipo()=='ERROR'){
                    $error = 'error';
                    $mensaje_completo = $this->res->getMensajeTec();                    
                }
            }

            //upload directory
            //$upload_dir = "/tmp/";
            $upload_dir = "/var/www/html/kerp/sis_horas_piloto/media/files/";
            //create file name
            $file_path = $upload_dir . $arregloFiles['archivo']['name'];

            //move uploaded file to upload dir
             if (!move_uploaded_file($arregloFiles['archivo']['tmp_name'], $file_path)) {
                //error moving upload file
                $mensaje_completo = "Error al guardar el archivo en disco";
                $error = 'error_fatal';
            }
            //save route of excel 
            $this->objParam->addParametro('id_archivo_horas_piloto', $id_archivo_horas_piloto);
            $this->objParam->addParametro('path_excel', $file_path);
            $this->objFunc = $this->create('MODArchivoHorasPiloto');
            $this->res = $this->objFunc->savePathExcel($this->objParam);
            if($this->res->getTipo()=='ERROR'){
                $error = 'error';
                $mensaje_completo = $this->res->getMensajeTec();                    
            }

            // }
        } else {
            $mensaje_completo = "No se subio el archivo";
            $error = 'error_fatal';
        }
        //armar respuesta en error fatal
        if ($error == 'error_fatal') {

            $this->mensajeRes=new Mensaje();
            $this->mensajeRes->setMensaje('ERROR','ACTColumnaCalor.php',$mensaje_completo,
                $mensaje_completo,'control');
            //si no es error fatal proceso el archivo
        } else {
            $lines = file($file_path);

        }
        //armar respuesta en caso de exito o error en algunas tuplas
        if ($error == 'error') {
            $this->mensajeRes=new Mensaje();
            $this->mensajeRes->setMensaje('ERROR','ACTHorasPiloto.php','Ocurrieron los siguientes errores : ' . $mensaje_completo,
                $mensaje_completo,'control');
        } else if ($error == 'no') {
            $this->mensajeRes=new Mensaje();
            $this->mensajeRes->setMensaje('EXITO','ACTHorasPiloto.php','El archivo fue ejecutado con éxito',
                'El archivo fue ejecutado con éxito','control');
        }

        //devolver respuesta
        $this->mensajeRes->imprimirRespuesta($this->mensajeRes->generarJson());        
    }    

    function eliminarArchivoHorPiloto() {
        $this->objFunc=$this->create('MODArchivoHorasPiloto');
        $this->res=$this->objFunc->eliminarArchivoHorPiloto($this->objParam);
        $this->res->imprimirRespuesta($this->res->generarJson());
    }
    function eliminarArchivoHorPilotoExcel()  {

        $dir = $this->objParam->getParametro('ruta_excel');
        $temp_array = explode('/', $dir);
        $upload_folder = implode ('/' , $temp_array);
        if(file_exists($upload_folder)){
            unlink($dir);
        }         
        $this->objParam->addParametro('eliminarExcelPilotos', 'eliminarExcelPilotos');
        $this->objFunc=$this->create('MODArchivoHorasPiloto');
        $this->res=$this->objFunc->eliminarArchivoHorPilotoExcel($this->objParam);
        $this->res->imprimirRespuesta($this->res->generarJson());
    }

    function eliminarDatosCalculados(){
        $this->objParam->addParametro('datosCalculados', 'datosCalculados');
        $this->objFunc=$this->create('MODArchivoHorasPiloto');
        $this->res=$this->objFunc->eliminarDatosCalculados($this->objParam);
        $this->res->imprimirRespuesta($this->res->generarJson());
    }

    function listarPlantillaArchivoExcel(){
        $this->objParam->getParametro('archivo') == 'HORPILOT' && $this->objParam->addFiltro(" arxls.codigo in(''HORPILOT'') ");
        $this->objFunc=$this->create('sis_parametros/MODPlantillaArchivoExcel');
        $this->res=$this->objFunc->listarPlantillaArchivoExcel($this->objParam);
        $this->res->imprimirRespuesta($this->res->generarJson());        
    }    

    function calculoPagoVariable() {        
        $this->objFunc=$this->create('MODHorasPiloto');
        $this->res=$this->objFunc->calculoPagoVariable($this->objParam);
        $this->res->imprimirRespuesta($this->res->generarJson());
    }
        
    function finalizarPagoVariable() {
        $this->objFunc=$this->create('MODArchivoHorasPiloto');
        $this->res=$this->objFunc->finalizarPagoVariable($this->objParam);
        $this->res->imprimirRespuesta($this->res->generarJson());
    }

    function reportePagoVariable() {
        
        $this->objParam->getParametro('id_archivo_horas_piloto') != '' && $this->objParam->addFiltro("arhopi.id_archivo_horas_piloto = ".$this->objParam->getParametro('id_archivo_horas_piloto'));

        $this->objFunc = $this->create('MODArchivoHorasPiloto');
        $this->res = $this->objFunc->reportePagoVariable($this->objParam);
        
        $nombreArchivo = uniqid(md5(session_id()).'[Reporte Pago Variable').'.xls';

        $this->objParam->addParametro('orientacion','L');
        $this->objParam->addParametro('tamano','LETTER');
        $this->objParam->addParametro('nombre_archivo',$nombreArchivo);
        $this->objParam->addParametro('titulo_archivo','Reporte Pago Variable');

        $reporte = new ReportePagoVariableXLS($this->objParam);
        $reporte->setDatos($this->res->datos);
        $reporte->generarReporte();
        $this->mensajeExito=new Mensaje();
        $this->mensajeExito->setMensaje('EXITO','Reporte.php','Reporte generado',
            'Se generó con éxito el reporte: '.$nombreArchivo,'control');
        $this->mensajeExito->setArchivoGenerado($nombreArchivo);
        $this->mensajeExito->imprimirRespuesta($this->mensajeExito->generarJson());	
    }

    function reportePiHorasVuelo(){
        $this->objParam->getParametro('id_archivo_horas_piloto') != '' && $this->objParam->addFiltro("arhopi.id_archivo_horas_piloto = ".$this->objParam->getParametro('id_archivo_horas_piloto'));

        $this->objFunc = $this->create('MODArchivoHorasPiloto');
        $this->res = $this->objFunc->reportePagoVariable($this->objParam);
        
        $nombreArchivo = uniqid(md5(session_id()).'[Reporte Horas Vuelo').'.xls';

        $this->objParam->addParametro('orientacion','L');
        $this->objParam->addParametro('tamano','LETTER');
        $this->objParam->addParametro('nombre_archivo',$nombreArchivo);
        $this->objParam->addParametro('titulo_archivo','Reporte Pago Variable');

        $reporte = new ReportePiHorasVueloXLS($this->objParam);
        $reporte->setDatos($this->res->datos);
        $reporte->generarReporte();
        $this->mensajeExito=new Mensaje();
        $this->mensajeExito->setMensaje('EXITO','Reporte.php','Reporte generado',
            'Se generó con éxito el reporte: '.$nombreArchivo,'control');
        $this->mensajeExito->setArchivoGenerado($nombreArchivo);
        $this->mensajeExito->imprimirRespuesta($this->mensajeExito->generarJson());	
    }    
}

?>