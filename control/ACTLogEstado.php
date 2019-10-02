<?php
/**
*@package pXP
*@file gen-ACTLogEstado.php
*@author  (breydi.vasquez)
*@date 26-09-2019 19:30:21
*@description Clase que recibe los parametros enviados por la vista para mandar a la capa de Modelo
*/

class ACTLogEstado extends ACTbase{    
			
	function listarLogEstado(){
		$this->objParam->defecto('ordenacion','id_log_estado');
        $this->objParam->defecto('dir_ordenacion','asc');

        $this->objParam->getParametro('id_archivo_horas_piloto') != '' && $this->objParam->addFiltro("oiplog.id_archivo_horas_piloto = ".$this->objParam->getParametro('id_archivo_horas_piloto'));

		if($this->objParam->getParametro('tipoReporte')=='excel_grid' || $this->objParam->getParametro('tipoReporte')=='pdf_grid'){
			$this->objReporte = new Reporte($this->objParam,$this);
			$this->res = $this->objReporte->generarReporteListado('MODLogEstado','listarLogEstado');
		} else{
			$this->objFunc=$this->create('MODLogEstado');
			
			$this->res=$this->objFunc->listarLogEstado($this->objParam);
		}
		$this->res->imprimirRespuesta($this->res->generarJson());
	}
				
	function insertarLogEstado(){
		$this->objFunc=$this->create('MODLogEstado');	
		if($this->objParam->insertar('id_log_estado')){
			$this->res=$this->objFunc->insertarLogEstado($this->objParam);			
		} else{			
			$this->res=$this->objFunc->modificarLogEstado($this->objParam);
		}
		$this->res->imprimirRespuesta($this->res->generarJson());
	}
						
	function eliminarLogEstado(){
			$this->objFunc=$this->create('MODLogEstado');	
		$this->res=$this->objFunc->eliminarLogEstado($this->objParam);
		$this->res->imprimirRespuesta($this->res->generarJson());
	}
			
}

?>