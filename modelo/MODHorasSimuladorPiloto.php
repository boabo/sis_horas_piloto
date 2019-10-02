<?php
/**
*@package pXP
*@file MODHorasSimuladorPiloto.php
*@author  (breydi.vasquez)
*@date 20-09-2019 13:42:10
*@description Clase que envia los parametros requeridos a la Base de datos para la ejecucion de las funciones, y que recibe la respuesta del resultado de la ejecucion de las mismas
*/

class MODHorasSimuladorPiloto extends MODbase{
	
	function __construct(CTParametro $pParam){
		parent::__construct($pParam);
	}
			
    function insertarHorasSimuladorPilotos(){
		//Definicion de variables para ejecucion del procedimiento
		$this->procedimiento='oip.ft_horas_piloto_ime';
		$this->transaccion='OIP_UPSIMPILO_MOD';
		$this->tipo_procedimiento='IME';						
        //var_dump($this);exit;
        $this->setParametro('horas_simulador', 'horas_simulador', 'jsonb');        
		//Ejecuta la instruccion
        $this->armarConsulta();        
		$this->ejecutarConsulta();

		//Devuelve la respuesta
		return $this->respuesta;        
    }
}
?>