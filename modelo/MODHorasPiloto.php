<?php
/**
*@package pXP
*@file gen-MODHorasPiloto.php
*@author  (breydi.vasquez)
*@date 20-09-2019 13:43:39
*@description Clase que envia los parametros requeridos a la Base de datos para la ejecucion de las funciones, y que recibe la respuesta del resultado de la ejecucion de las mismas
*/

class MODHorasPiloto extends MODbase{
	
	function __construct(CTParametro $pParam){
		parent::__construct($pParam);
	}
			
	function listarHorasPiloto(){
		//Definicion de variables para ejecucion del procedimientp
		$this->procedimiento='oip.ft_horas_piloto_sel';
		$this->transaccion='OIP_HOPILO_SEL';
		$this->tipo_procedimiento='SEL';//tipo de transaccion
                
        $this->capturaCount('total_pago_variable','numeric');
		//Definicion de la lista del resultado del query
		$this->captura('id_horas_piloto','int4');
		$this->captura('estado_reg','varchar');
		$this->captura('gestion','int4');
		$this->captura('mes','varchar');
		$this->captura('ci','varchar');
        $this->captura('nombre_piloto','text');
        $this->captura('escala_salarial', 'varchar');
		$this->captura('tipo_flota','varchar');
		$this->captura('horas_vuelo','int4');
		$this->captura('horas_simulador_full','int4');
        $this->captura('horas_simulador_fix','int4');
        $this->captura('factor_esfuerzo','numeric');
        $this->captura('pago_variable','numeric');
        $this->captura('monto_horas_vuelo','numeric');
        $this->captura('monto_horas_simulador_full','numeric');
        $this->captura('monto_horas_simulador_fix','numeric');
        $this->captura('estado','varchar');
        $this->captura('pic_sic','varchar');
        $this->captura('horas_simulador_full_efectivas','integer'); 
        $this->captura('horas_simulador_fix_efectivas','integer');       
		$this->captura('id_usuario_reg','int4');
		$this->captura('fecha_reg','timestamp');
		$this->captura('id_usuario_ai','int4');
		$this->captura('usuario_ai','varchar');
		$this->captura('id_usuario_mod','int4');
		$this->captura('fecha_mod','timestamp');
		$this->captura('usr_reg','varchar');
		$this->captura('usr_mod','varchar');
		$this->captura('id_funcionario','int4');
		//Ejecuta la instruccion
		$this->armarConsulta();
		$this->ejecutarConsulta();
		
		//Devuelve la respuesta
		return $this->respuesta;
	}
			
	function insertarHorasPiloto(){
		//Definicion de variables para ejecucion del procedimiento
		$this->procedimiento='oip.ft_horas_piloto_ime';
		$this->transaccion='OIP_HOPILO_INS';
		$this->tipo_procedimiento='IME';
				
		//Define los parametros para la funcion
		$this->setParametro('estado_reg','estado_reg','varchar');
		$this->setParametro('gestion','gestion','int4');
		$this->setParametro('mes','mes','int4');
		$this->setParametro('ci','ci','varchar');
		$this->setParametro('nombre_piloto','nombre_piloto','varchar');
		$this->setParametro('tipo_flota','tipo_flota','varchar');
		$this->setParametro('horas_vuelo','horas_vuelo','int4');
		$this->setParametro('horas_simulador_full','horas_simulador_full','int4');
		$this->setParametro('horas_simulador_fix','horas_simulador_fix','int4');
		$this->setParametro('estado','estado','varchar');

		//Ejecuta la instruccion
		$this->armarConsulta();
		$this->ejecutarConsulta();

		//Devuelve la respuesta
		return $this->respuesta;
	}
			
	function modificarHorasPiloto(){
		//Definicion de variables para ejecucion del procedimiento
		$this->procedimiento='oip.ft_horas_piloto_ime';
		$this->transaccion='OIP_HOPILO_MOD';
		$this->tipo_procedimiento='IME';
				
		//Define los parametros para la funcion
		$this->setParametro('id_horas_piloto','id_horas_piloto','int4');
		$this->setParametro('estado_reg','estado_reg','varchar');
		$this->setParametro('gestion','gestion','int4');
		$this->setParametro('mes','mes','int4');
		$this->setParametro('ci','ci','varchar');
		$this->setParametro('id_funcionario','id_funcionario','int4');
		$this->setParametro('tipo_flota','tipo_flota','varchar');
		$this->setParametro('horas_vuelo','horas_vuelo','int4');
		$this->setParametro('horas_simulador_full','horas_simulador_full','int4');
		$this->setParametro('horas_simulador_fix','horas_simulador_fix','int4');
		$this->setParametro('estado','estado','varchar');

		//Ejecuta la instruccion
		$this->armarConsulta();
		$this->ejecutarConsulta();

		//Devuelve la respuesta
		return $this->respuesta;
	}
			
	function eliminarHorasPiloto(){
		//Definicion de variables para ejecucion del procedimiento
		$this->procedimiento='oip.ft_horas_piloto_ime';
		$this->transaccion='OIP_HOPILO_ELI';
		$this->tipo_procedimiento='IME';
				
		//Define los parametros para la funcion
		$this->setParametro('id_horas_piloto','id_horas_piloto','int4');

		//Ejecuta la instruccion
		$this->armarConsulta();
		$this->ejecutarConsulta();

		//Devuelve la respuesta
		return $this->respuesta;
	}

    function cargarArchivoHorPilotoExcel(){
		//Definicion de variables para ejecucion del procedimiento
		$this->procedimiento='oip.ft_horas_piloto_ime';
        //$this->transaccion='OIP_HOPILO_INS';OIP_UPHOPILO_MOD
        $this->transaccion='OIP_UPHOPILO_MOD';
		$this->tipo_procedimiento='IME';

		//Define los parametros para la funcion
        $this->setParametro('id_archivo_horas_piloto','id_archivo_horas_piloto','int4');
        $this->setParametro('gestion', 'gestion', 'int4');
        $this->setParametro('periodo', 'periodo', 'int4');
        $this->setParametro('ci', 'ci', 'varchar');
        $this->setParametro('nombre_piloto', 'nombre_piloto', 'varchar');        
        $this->setParametro('horas_simulador_full', 'horas_simulador_full', 'int4');
        $this->setParametro('horas_simulador_fix', 'horas_simulador_fix', 'int4');        
		//Ejecuta la instruccion
		$this->armarConsulta();
		$this->ejecutarConsulta();

		//Devuelve la respuesta
		return $this->respuesta;
    }
    function calculoPagoVariable(){        
        //Definicion de variables para ejecucion del procedimiento
        $this->procedimiento='oip.ft_horas_piloto_ime';
        $this->transaccion='OIP_CALPAGVAR_IME';
        $this->tipo_procedimiento='IME';

        //Define los parametros para la funcion
        $this->setParametro('id_archivo_horas_piloto','id_archivo_horas_piloto','int4');        
        //Ejecuta la instruccion
        $this->armarConsulta();
        $this->ejecutarConsulta();

        //Devuelve la respuesta
        return $this->respuesta;            
    }         
}
?>