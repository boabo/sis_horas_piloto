<?php
/**
*@package pXP
*@file gen-ACTTipoFlota.php
*@author  (admin)
*@date 26-09-2019 13:05:35
*@description Clase que recibe los parametros enviados por la vista para mandar a la capa de Modelo
*/

class ACTTipoFlota extends ACTbase{    
			
	function listarTipoFlota(){
		$this->objParam->defecto('ordenacion','id_tipo_flota');

		$this->objParam->defecto('dir_ordenacion','asc');
		if($this->objParam->getParametro('tipoReporte')=='excel_grid' || $this->objParam->getParametro('tipoReporte')=='pdf_grid'){
			$this->objReporte = new Reporte($this->objParam,$this);
			$this->res = $this->objReporte->generarReporteListado('MODTipoFlota','listarTipoFlota');
		} else{
			$this->objFunc=$this->create('MODTipoFlota');
			
			$this->res=$this->objFunc->listarTipoFlota($this->objParam);
		}
		$this->res->imprimirRespuesta($this->res->generarJson());
	}
				
	function insertarTipoFlota(){
		$this->objFunc=$this->create('MODTipoFlota');	
		if($this->objParam->insertar('id_tipo_flota')){
			$this->res=$this->objFunc->insertarTipoFlota($this->objParam);			
		} else{			
			$this->res=$this->objFunc->modificarTipoFlota($this->objParam);
		}
		$this->res->imprimirRespuesta($this->res->generarJson());
	}
						
	function eliminarTipoFlota(){
			$this->objFunc=$this->create('MODTipoFlota');	
		$this->res=$this->objFunc->eliminarTipoFlota($this->objParam);
		$this->res->imprimirRespuesta($this->res->generarJson());
	}
			
}

?>