<?php
/**
 *@package pXP
 *@file gen-ACTTipoSimulador.php
 *@author  (admin)
 *@date 24-09-2019 14:13:43
 *@description Clase que recibe los parametros enviados por la vista para mandar a la capa de Modelo
 */

class ACTTipoSimulador extends ACTbase{

    function listarTipoSimulador(){
        $this->objParam->defecto('ordenacion','id_tipo_simulador');

        $this->objParam->defecto('dir_ordenacion','asc');
        if($this->objParam->getParametro('tipoReporte')=='excel_grid' || $this->objParam->getParametro('tipoReporte')=='pdf_grid'){
            $this->objReporte = new Reporte($this->objParam,$this);
            $this->res = $this->objReporte->generarReporteListado('MODTipoSimulador','listarTipoSimulador');
        } else{
            $this->objFunc=$this->create('MODTipoSimulador');

            $this->res=$this->objFunc->listarTipoSimulador($this->objParam);
        }
        $this->res->imprimirRespuesta($this->res->generarJson());
    }

    function insertarTipoSimulador(){
        $this->objFunc=$this->create('MODTipoSimulador');
        if($this->objParam->insertar('id_tipo_simulador')){
            $this->res=$this->objFunc->insertarTipoSimulador($this->objParam);
        } else{
            $this->res=$this->objFunc->modificarTipoSimulador($this->objParam);
        }
        $this->res->imprimirRespuesta($this->res->generarJson());
    }

    function eliminarTipoSimulador(){
        $this->objFunc=$this->create('MODTipoSimulador');
        $this->res=$this->objFunc->eliminarTipoSimulador($this->objParam);
        $this->res->imprimirRespuesta($this->res->generarJson());
    }

}

?>