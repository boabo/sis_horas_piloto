<?php
/**
*@package pXP
*@file ACTHorasVueloPiloto.php
*@author  (breydi.vasquez)
*@date 20-09-2019 13:42:10
*@description Clase que recibe los parametros enviados por la vista para mandar a la capa de Modelo
*/

class ACTHorasVueloPiloto extends ACTbase{ 

    function insertarHorasVueloPilotos(){

        $this->objFunc=$this->create('MODHorasVueloPiloto');	
        $this->objParam->insertar('id_archivo_horas_piloto');
        $this->res=$this->objFunc->insertarHorasVueloPilotos($this->objParam);
        $this->res->imprimirRespuesta($this->res->generarJson());
    }
}

?>