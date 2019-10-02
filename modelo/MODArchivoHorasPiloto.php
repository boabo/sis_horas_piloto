<?php
/**
*@package pXP
*@file MODArchivoHorasPiloto.php
*@author  (breydi.vasquez)
*@date 20-09-2019 13:42:10
*@description Clase que envia los parametros requeridos a la Base de datos para la ejecucion de las funciones, y que recibe la respuesta del resultado de la ejecucion de las mismas
*/

class MODArchivoHorasPiloto extends MODbase{
	
	function __construct(CTParametro $pParam){
		parent::__construct($pParam);
	}
			
	function listarArchivoHorasPiloto(){
		//Definicion de variables para ejecucion del procedimientp
		$this->procedimiento='oip.ft_archivo_horas_piloto_sel';
		$this->transaccion='OIP_ARHOPI_SEL';
		$this->tipo_procedimiento='SEL';//tipo de transaccion
				
		//Definicion de la lista del resultado del query
		$this->captura('id_archivo_horas_piloto','int4');
		$this->captura('estado_reg','varchar');
		$this->captura('id_gestion','int4');
		$this->captura('id_periodo','int4');		
		$this->captura('nombre','varchar');
        $this->captura('estado','varchar');
		$this->captura('gestion','integer');
        $this->captura('literal','varchar');
        $this->captura('archivo','varchar');
        $this->captura('pago_total','numeric');
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
			
	function insertarArchivoHorasPiloto(){
		//Definicion de variables para ejecucion del procedimiento
		$this->procedimiento='oip.ft_archivo_horas_piloto_ime';
		$this->transaccion='OIP_ARHOPI_INS';
		$this->tipo_procedimiento='IME';
				
		//Define los parametros para la funcion
		$this->setParametro('estado_reg','estado_reg','varchar');
		$this->setParametro('id_gestion','id_gestion','int4');
		$this->setParametro('id_periodo','id_periodo','int4');		
		$this->setParametro('nombre','nombre','varchar');		

		//Ejecuta la instruccion
        $this->armarConsulta();        
		$this->ejecutarConsulta();

		//Devuelve la respuesta
		return $this->respuesta;
	}
			
	function modificarArchivoHorasPiloto(){
		//Definicion de variables para ejecucion del procedimiento
		$this->procedimiento='oip.ft_archivo_horas_piloto_ime';
		$this->transaccion='OIP_ARHOPI_MOD';
		$this->tipo_procedimiento='IME';
				
		//Define los parametros para la funcion
		$this->setParametro('id_archivo_horas_piloto','id_archivo_horas_piloto','int4');
		$this->setParametro('estado_reg','estado_reg','varchar');
		$this->setParametro('id_gestion','id_gestion','int4');
		$this->setParametro('id_periodo','id_periodo','int4');		
		$this->setParametro('nombre','nombre','varchar');		

		//Ejecuta la instruccion
		$this->armarConsulta();
		$this->ejecutarConsulta();

		//Devuelve la respuesta
		return $this->respuesta;
	}
			
	function eliminarArchivoHorasPiloto(){
		//Definicion de variables para ejecucion del procedimiento
		$this->procedimiento='oip.ft_archivo_horas_piloto_ime';
		$this->transaccion='OIP_ARHOPI_ELI';
		$this->tipo_procedimiento='IME';
				
		//Define los parametros para la funcion
		$this->setParametro('id_archivo_horas_piloto','id_archivo_horas_piloto','int4');

		//Ejecuta la instruccion
		$this->armarConsulta();
		$this->ejecutarConsulta();

		//Devuelve la respuesta
		return $this->respuesta;
	}
      
    function eliminarArchivoHorPilotoExcel(){
		//Definicion de variables para ejecucion del procedimiento
		$this->procedimiento='oip.ft_archivo_horas_piloto_ime';
		$this->transaccion='OIP_ARHOPI_ELI';
		$this->tipo_procedimiento='IME';

		//Define los parametros para la funcion
		$this->setParametro('id_archivo_horas_piloto','id_archivo_horas_piloto','int4');
        $this->setParametro('eliminarExcelPilotos','eliminarExcelPilotos','varchar');
		//Ejecuta la instruccion
		$this->armarConsulta();
		$this->ejecutarConsulta();

		//Devuelve la respuesta
		return $this->respuesta;        
    }

    function eliminarDatosCalculados(){
		//Definicion de variables para ejecucion del procedimiento
		$this->procedimiento='oip.ft_archivo_horas_piloto_ime';
		$this->transaccion='OIP_ARHOPI_ELI';
		$this->tipo_procedimiento='IME';

		//Define los parametros para la funcion
		$this->setParametro('id_archivo_horas_piloto','id_archivo_horas_piloto','int4');
        $this->setParametro('datosCalculados','datosCalculados','varchar');
		//Ejecuta la instruccion
		$this->armarConsulta();
		$this->ejecutarConsulta();

		//Devuelve la respuesta
		return $this->respuesta;        
    }

    function finalizarPagoVariable(){
		//Definicion de variables para ejecucion del procedimiento
		$this->procedimiento='oip.ft_archivo_horas_piloto_ime';
		$this->transaccion='OIP_FINPAGVAR_MOD';
		$this->tipo_procedimiento='IME';

		//Define los parametros para la funcion
		$this->setParametro('id_archivo_horas_piloto','id_archivo_horas_piloto','int4');        
		//Ejecuta la instruccion
		$this->armarConsulta();
		$this->ejecutarConsulta();

		//Devuelve la respuesta
		return $this->respuesta;        
    }
    function insertarDataPilotos(){
		//Definicion de variables para ejecucion del procedimiento
		$this->procedimiento='oip.ft_archivo_horas_piloto_ime';
		$this->transaccion='OIP_DATAPILO_INS';
		$this->tipo_procedimiento='IME';						
        
        $this->setParametro('pilotos','pilotos','text');
		//Ejecuta la instruccion
        $this->armarConsulta();        
		$this->ejecutarConsulta();

		//Devuelve la respuesta
		return $this->respuesta;        
    }
    function savePathExcel(){

		//Definicion de variables para ejecucion del procedimiento
		$this->procedimiento='oip.ft_archivo_horas_piloto_ime';
		$this->transaccion='OIP_UPPATHEXC_MOD';
		$this->tipo_procedimiento='IME';						
        
        $this->setParametro('id_archivo_horas_piloto','id_archivo_horas_piloto','integer');
        $this->setParametro('path_excel','path_excel','varchar');
		//Ejecuta la instruccion
        $this->armarConsulta();        
		$this->ejecutarConsulta();

		//Devuelve la respuesta
        return $this->respuesta;        
    }
    function reportePagoVariable(){
		//Definicion de variables para ejecucion del procedimiento
		$this->procedimiento='oip.ft_archivo_horas_piloto_sel';
		$this->transaccion='OIP_REPPILO_SEL';
		$this->tipo_procedimiento='SEL';						
        $this->setCount(false);

        $this->setParametro('id_archivo_horas_piloto','id_archivo_horas_piloto','integer');
        
        //captura de datos
        $this->captura('nombre', 'varchar');
        $this->captura('gestion', 'int4');
        $this->captura('periodo', 'varchar');
        $this->captura('pago_total', 'numeric');
        $this->captura('nombre_piloto', 'varchar');
        $this->captura('escala_salarial', 'varchar');
        $this->captura('ci', 'varchar');
        $this->captura('pic_sic', 'varchar');
        $this->captura('horas_vuelo','int4');
        $this->captura('horas_simulador_full', 'int4');
        $this->captura('horas_simulador_fix', 'int4');
        $this->captura('horas_simulador_full_efectivas', 'int4');
        $this->captura('horas_simulador_fix_efectivas', 'int4');
        $this->captura('pago_variable', 'numeric');
        $this->captura('factor_esfuerzo', 'numeric');
        $this->captura('monto_horas_vuelo', 'numeric');
        $this->captura('monto_horas_simulador_full', 'numeric');
        $this->captura('monto_horas_simulador_fix', 'numeric');

		//Ejecuta la instruccion
        $this->armarConsulta();
        //echo($this->consulta);exit;        
		$this->ejecutarConsulta();

		//Devuelve la respuesta
        return $this->respuesta;          
    }
}
?>