<?php
/**
*@package pXP
*@file gen-MODLogEstado.php
*@author  (breydi.vasquez)
*@date 26-09-2019 19:30:21
*@description Clase que envia los parametros requeridos a la Base de datos para la ejecucion de las funciones, y que recibe la respuesta del resultado de la ejecucion de las mismas
*/

class MODLogEstado extends MODbase{
	
	function __construct(CTParametro $pParam){
		parent::__construct($pParam);
	}
			
	function listarLogEstado(){
		//Definicion de variables para ejecucion del procedimientp
		$this->procedimiento='oip.ft_log_estado_sel';
		$this->transaccion='OIP_OIPLOG_SEL';
		$this->tipo_procedimiento='SEL';//tipo de transaccion
				
		//Definicion de la lista del resultado del query
		$this->captura('id_log_estado','int4');
		$this->captura('estado_reg','varchar');
		$this->captura('id_archivo_horas_piloto','int4');
		$this->captura('accion','varchar');
		$this->captura('detalle','text');
		$this->captura('estado','varchar');		
		$this->captura('id_usuario_reg','int4');
		$this->captura('fecha_reg','timestamp');
		$this->captura('id_usuario_ai','int4');
		$this->captura('usuario_ai','varchar');
		$this->captura('id_usuario_mod','int4');
		$this->captura('fecha_mod','timestamp');
		$this->captura('usr_reg','varchar');
		$this->captura('usr_mod','varchar');
		
		//Ejecuta la instruccion
        $this->armarConsulta();        
		$this->ejecutarConsulta();
		
		//Devuelve la respuesta
		return $this->respuesta;
	}
			
	function insertarLogEstado(){
		//Definicion de variables para ejecucion del procedimiento
		$this->procedimiento='oip.ft_log_estado_ime';
		$this->transaccion='OIP_OIPLOG_INS';
		$this->tipo_procedimiento='IME';
				
		//Define los parametros para la funcion
		$this->setParametro('estado_reg','estado_reg','varchar');
		$this->setParametro('id_archivo_horas_piloto','id_archivo_horas_piloto','int4');
		$this->setParametro('accion','accion','varchar');
		$this->setParametro('detalle','detalle','text');
		$this->setParametro('estado','estado','varchar');		

		//Ejecuta la instruccion
		$this->armarConsulta();
		$this->ejecutarConsulta();

		//Devuelve la respuesta
		return $this->respuesta;
	}
			
	function modificarLogEstado(){
		//Definicion de variables para ejecucion del procedimiento
		$this->procedimiento='oip.ft_log_estado_ime';
		$this->transaccion='OIP_OIPLOG_MOD';
		$this->tipo_procedimiento='IME';
				
		//Define los parametros para la funcion
		$this->setParametro('id_log_estado','id_log_estado','int4');
		$this->setParametro('estado_reg','estado_reg','varchar');
		$this->setParametro('id_archivo_horas_piloto','id_archivo_horas_piloto','int4');
		$this->setParametro('accion','accion','varchar');
		$this->setParametro('detalle','detalle','text');
		$this->setParametro('estado','estado','varchar');		

		//Ejecuta la instruccion
		$this->armarConsulta();
		$this->ejecutarConsulta();

		//Devuelve la respuesta
		return $this->respuesta;
	}
			
	function eliminarLogEstado(){
		//Definicion de variables para ejecucion del procedimiento
		$this->procedimiento='oip.ft_log_estado_ime';
		$this->transaccion='OIP_OIPLOG_ELI';
		$this->tipo_procedimiento='IME';
				
		//Define los parametros para la funcion
		$this->setParametro('id_log_estado','id_log_estado','int4');

		//Ejecuta la instruccion
		$this->armarConsulta();
		$this->ejecutarConsulta();

		//Devuelve la respuesta
		return $this->respuesta;
	}
			
}
?>