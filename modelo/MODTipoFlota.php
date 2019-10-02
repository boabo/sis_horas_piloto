<?php
/**
*@package pXP
*@file gen-MODTipoFlota.php
*@author  (admin)
*@date 26-09-2019 13:05:35
*@description Clase que envia los parametros requeridos a la Base de datos para la ejecucion de las funciones, y que recibe la respuesta del resultado de la ejecucion de las mismas
*/

class MODTipoFlota extends MODbase{
	
	function __construct(CTParametro $pParam){
		parent::__construct($pParam);
	}
			
	function listarTipoFlota(){
		//Definicion de variables para ejecucion del procedimientp
		$this->procedimiento='oip.ft_tipo_flota_sel';
		$this->transaccion='OIP_TIPFLO_SEL';
		$this->tipo_procedimiento='SEL';//tipo de transaccion
				
		//Definicion de la lista del resultado del query
		$this->captura('id_tipo_flota','int4');
		$this->captura('estado_reg','varchar');
		$this->captura('tipo_flota','varchar');
		$this->captura('costo_hora_base_pic','numeric');
		$this->captura('costo_hora_base_sic','numeric');
		$this->captura('horas_base','numeric');
		$this->captura('relacion_ciclo_hora','numeric');
		$this->captura('maximo_horas','int4');
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
			
	function insertarTipoFlota(){
		//Definicion de variables para ejecucion del procedimiento
		$this->procedimiento='oip.ft_tipo_flota_ime';
		$this->transaccion='OIP_TIPFLO_INS';
		$this->tipo_procedimiento='IME';
				
		//Define los parametros para la funcion
		$this->setParametro('estado_reg','estado_reg','varchar');
		$this->setParametro('tipo_flota','tipo_flota','varchar');
		$this->setParametro('costo_hora_base_pic','costo_hora_base_pic','numeric');
		$this->setParametro('costo_hora_base_sic','costo_hora_base_sic','numeric');
		$this->setParametro('horas_base','horas_base','numeric');
		$this->setParametro('relacion_ciclo_hora','relacion_ciclo_hora','numeric');
		$this->setParametro('maximo_horas','maximo_horas','int4');

		//Ejecuta la instruccion
		$this->armarConsulta();
		$this->ejecutarConsulta();

		//Devuelve la respuesta
		return $this->respuesta;
	}
			
	function modificarTipoFlota(){
		//Definicion de variables para ejecucion del procedimiento
		$this->procedimiento='oip.ft_tipo_flota_ime';
		$this->transaccion='OIP_TIPFLO_MOD';
		$this->tipo_procedimiento='IME';
				
		//Define los parametros para la funcion
		$this->setParametro('id_tipo_flota','id_tipo_flota','int4');
		$this->setParametro('estado_reg','estado_reg','varchar');
		$this->setParametro('tipo_flota','tipo_flota','varchar');
		$this->setParametro('costo_hora_base_pic','costo_hora_base_pic','numeric');
		$this->setParametro('costo_hora_base_sic','costo_hora_base_sic','numeric');
		$this->setParametro('horas_base','horas_base','numeric');
		$this->setParametro('relacion_ciclo_hora','relacion_ciclo_hora','numeric');
		$this->setParametro('maximo_horas','maximo_horas','int4');

		//Ejecuta la instruccion
		$this->armarConsulta();
		$this->ejecutarConsulta();

		//Devuelve la respuesta
		return $this->respuesta;
	}
			
	function eliminarTipoFlota(){
		//Definicion de variables para ejecucion del procedimiento
		$this->procedimiento='oip.ft_tipo_flota_ime';
		$this->transaccion='OIP_TIPFLO_ELI';
		$this->tipo_procedimiento='IME';
				
		//Define los parametros para la funcion
		$this->setParametro('id_tipo_flota','id_tipo_flota','int4');

		//Ejecuta la instruccion
		$this->armarConsulta();
		$this->ejecutarConsulta();

		//Devuelve la respuesta
		return $this->respuesta;
	}
			
}
?>