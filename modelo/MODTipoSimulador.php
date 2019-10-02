<?php
/**
 *@package pXP
 *@file gen-MODTipoSimulador.php
 *@author  (admin)
 *@date 24-09-2019 14:13:43
 *@description Clase que envia los parametros requeridos a la Base de datos para la ejecucion de las funciones, y que recibe la respuesta del resultado de la ejecucion de las mismas
 */

class MODTipoSimulador extends MODbase{

    function __construct(CTParametro $pParam){
        parent::__construct($pParam);
    }

    function listarTipoSimulador(){
        //Definicion de variables para ejecucion del procedimientp
        $this->procedimiento='oip.ft_tipo_simulador_sel';
        $this->transaccion='OIP_TIPSIMU_SEL';
        $this->tipo_procedimiento='SEL';//tipo de transaccion

        //Definicion de la lista del resultado del query
        $this->captura('id_tipo_simulador','int4');
        $this->captura('estado_reg','varchar');
        $this->captura('tipo_simulador','varchar');
        $this->captura('costo_hora','numeric');
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

    function insertarTipoSimulador(){
        //Definicion de variables para ejecucion del procedimiento
        $this->procedimiento='oip.ft_tipo_simulador_ime';
        $this->transaccion='OIP_TIPSIMU_INS';
        $this->tipo_procedimiento='IME';

        //Define los parametros para la funcion
        $this->setParametro('estado_reg','estado_reg','varchar');
        $this->setParametro('tipo_simulador','tipo_simulador','varchar');
        $this->setParametro('costo_hora','costo_hora','numeric');
        $this->setParametro('maximo_horas','maximo_horas','int4');

        //Ejecuta la instruccion
        $this->armarConsulta();
        $this->ejecutarConsulta();

        //Devuelve la respuesta
        return $this->respuesta;
    }

    function modificarTipoSimulador(){
        //Definicion de variables para ejecucion del procedimiento
        $this->procedimiento='oip.ft_tipo_simulador_ime';
        $this->transaccion='OIP_TIPSIMU_MOD';
        $this->tipo_procedimiento='IME';

        //Define los parametros para la funcion
        $this->setParametro('id_tipo_simulador','id_tipo_simulador','int4');
        $this->setParametro('estado_reg','estado_reg','varchar');
        $this->setParametro('tipo_simulador','tipo_simulador','varchar');
        $this->setParametro('costo_hora','costo_hora','numeric');
        $this->setParametro('maximo_horas','maximo_horas','int4');

        //Ejecuta la instruccion
        $this->armarConsulta();
        $this->ejecutarConsulta();

        //Devuelve la respuesta
        return $this->respuesta;
    }

    function eliminarTipoSimulador(){
        //Definicion de variables para ejecucion del procedimiento
        $this->procedimiento='oip.ft_tipo_simulador_ime';
        $this->transaccion='OIP_TIPSIMU_ELI';
        $this->tipo_procedimiento='IME';

        //Define los parametros para la funcion
        $this->setParametro('id_tipo_simulador','id_tipo_simulador','int4');

        //Ejecuta la instruccion
        $this->armarConsulta();
        $this->ejecutarConsulta();

        //Devuelve la respuesta
        return $this->respuesta;
    }

}
?>