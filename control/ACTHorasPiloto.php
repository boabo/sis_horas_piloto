<?php
/**
*@package pXP
*@file gen-ACTHorasPiloto.php
*@author  (breydi.vasquez)
*@date 20-09-2019 13:43:39
*@description Clase que recibe los parametros enviados por la vista para mandar a la capa de Modelo
*/

class ACTHorasPiloto extends ACTbase{    
			
	function listarHorasPiloto(){
		$this->objParam->defecto('ordenacion','id_horas_piloto');        
        $this->objParam->defecto('dir_ordenacion','asc');
        
        $this->objParam->getParametro('id_archivo_horas_piloto') != '' && $this->objParam->addFiltro("hopilo.id_archivo_horas_piloto = ".$this->objParam->getParametro('id_archivo_horas_piloto'));

		if($this->objParam->getParametro('tipoReporte')=='excel_grid' || $this->objParam->getParametro('tipoReporte')=='pdf_grid'){
			$this->objReporte = new Reporte($this->objParam,$this);
			$this->res = $this->objReporte->generarReporteListado('MODHorasPiloto','listarHorasPiloto');
		} else{
			$this->objFunc=$this->create('MODHorasPiloto');
            if ($this->objParam->getParametro('id_archivo_horas_piloto') != '') {
                $this->res=$this->objFunc->listarHorasPiloto($this->objParam);                
                $temp = Array();
                $temp['total_pago_variable'] = $this->res->extraData['total_pago_variable'];
                $temp['tipo_reg'] = 'summary';                
                $this->res->total++;
                $this->res->addLastRecDatos($temp);            
            }else{			
            $this->res=$this->objFunc->listarHorasPiloto($this->objParam);
            }
		}
		$this->res->imprimirRespuesta($this->res->generarJson());
	}
				
	function insertarHorasPiloto(){
		$this->objFunc=$this->create('MODHorasPiloto');	
		if($this->objParam->insertar('id_horas_piloto')){
			$this->res=$this->objFunc->insertarHorasPiloto($this->objParam);			
		} else{			
			$this->res=$this->objFunc->modificarHorasPiloto($this->objParam);
		}
		$this->res->imprimirRespuesta($this->res->generarJson());
	}
						
	function eliminarHorasPiloto(){
		$this->objFunc=$this->create('MODHorasPiloto');	
		$this->res=$this->objFunc->eliminarHorasPiloto($this->objParam);
		$this->res->imprimirRespuesta($this->res->generarJson());
    }     			
}

?>