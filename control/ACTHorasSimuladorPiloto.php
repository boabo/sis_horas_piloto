<?php
/**
*@package pXP
*@file ACTHorasSimuladorPiloto.php
*@author  (breydi.vasquez)
*@date 20-09-2019 13:42:10
*@description Clase que recibe los parametros enviados por la vista para mandar a la capa de Modelo
*/

class ACTHorasSimuladorPiloto extends ACTbase{

    function insertarHorasSimuladorPilotos(){
        
        $this->objFunc=$this->create('MODHorasSimuladorPiloto');                
        $this->res=$this->objFunc->insertarHorasSimuladorPilotos($this->objParam);
        $this->res->imprimirRespuesta($this->res->generarJson());
    }
}

?>