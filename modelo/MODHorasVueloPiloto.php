<?php
/**
*@package pXP
*@file MODHorasVueloPiloto.php
*@author  (breydi.vasquez)
*@date 20-09-2019 13:42:10
*@description Clase que envia los parametros requeridos a la Base de datos para la ejecucion de las funciones, y que recibe la respuesta del resultado de la ejecucion de las mismas
*/

class MODHorasVueloPiloto extends MODbase{
	
	function __construct(CTParametro $pParam){
		parent::__construct($pParam);
    }
    
    function insertarHorasVueloPilotos(){
		//Definicion de variables para ejecucion del procedimiento
		$this->procedimiento='oip.ft_archivo_horas_piloto_ime';
		$this->transaccion='OIP_DATAPILO_INS';
        $this->tipo_procedimiento='IME';    
            
        $this->setParametro('pilotos','pilotos','jsonb');
		//Ejecuta la instruccion
        $this->armarConsulta();        
		$this->ejecutarConsulta();

		//Devuelve la respuesta
		return $this->respuesta;        
    }
}
?>