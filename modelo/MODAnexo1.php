<?php
/**
 *@package pXP
 *@file gen-MODAnexo1.php
 *@author  (admin)
 *@date 26-09-2019 12:54:57
 *@description Clase que envia los parametros requeridos a la Base de datos para la ejecucion de las funciones, y que recibe la respuesta del resultado de la ejecucion de las mismas
 */

class MODAnexo1 extends MODbase{

    function __construct(CTParametro $pParam){
        parent::__construct($pParam);
    }

    function listarAnexo1(){
        //Definicion de variables para ejecucion del procedimientp
        $this->procedimiento='oip.ft_anexo1_sel';
        $this->transaccion='OIP_TIPANE1_SEL';
        $this->tipo_procedimiento='SEL';//tipo de transaccion

        //Definicion de la lista del resultado del query
        $this->captura('id_anexo1','int4');
        $this->captura('estado_reg','varchar');
        $this->captura('id_escala_salarial','int4');
        $this->captura('numero_casos','int4');
        $this->captura('remuneracion_basica','numeric');
        $this->captura('remuneracion_maxima','numeric');
        $this->captura('tipo_flota','varchar');
        $this->captura('pic_sic','varchar');
        $this->captura('id_usuario_reg','int4');
        $this->captura('fecha_reg','timestamp');
        $this->captura('id_usuario_ai','int4');
        $this->captura('usuario_ai','varchar');
        $this->captura('id_usuario_mod','int4');
        $this->captura('fecha_mod','timestamp');
        $this->captura('usr_reg','varchar');
        $this->captura('usr_mod','varchar');
        $this->captura('desc_nombre_salarial','varchar');
        $this->captura('fecha_ini','date');
        $this->captura('fecha_fin','date');
        //Ejecuta la instruccion
        $this->armarConsulta();
        // echo $this->consulta;exit;
        $this->ejecutarConsulta();

        //Devuelve la respuesta
        return $this->respuesta;
    }

    function insertarAnexo1(){
        //Definicion de variables para ejecucion del procedimiento
        $this->procedimiento='oip.ft_anexo1_ime';
        $this->transaccion='OIP_TIPANE1_INS';
        $this->tipo_procedimiento='IME';

        //Define los parametros para la funcion
        $this->setParametro('estado_reg','estado_reg','varchar');
        $this->setParametro('id_escala_salarial','id_escala_salarial','int4');
        $this->setParametro('numero_casos','numero_casos','int4');
        $this->setParametro('remuneracion_basica','remuneracion_basica','numeric');
        $this->setParametro('remuneracion_maxima','remuneracion_maxima','numeric');
        $this->setParametro('tipo_flota','tipo_flota','varchar');
        $this->setParametro('pic_sic','pic_sic','varchar');
        $this->setParametro('fecha_ini','fecha_ini','date');
        $this->setParametro('fecha_fin','fecha_fin','date');
        //Ejecuta la instruccion
        $this->armarConsulta();
        $this->ejecutarConsulta();

        //Devuelve la respuesta
        return $this->respuesta;
    }

    function modificarAnexo1(){
        //Definicion de variables para ejecucion del procedimiento
        $this->procedimiento='oip.ft_anexo1_ime';
        $this->transaccion='OIP_TIPANE1_MOD';
        $this->tipo_procedimiento='IME';

        //Define los parametros para la funcion
        $this->setParametro('id_anexo1','id_anexo1','int4');
        $this->setParametro('estado_reg','estado_reg','varchar');
        $this->setParametro('id_escala_salarial','id_escala_salarial','int4');
        $this->setParametro('numero_casos','numero_casos','int4');
        $this->setParametro('remuneracion_basica','remuneracion_basica','numeric');
        $this->setParametro('remuneracion_maxima','remuneracion_maxima','numeric');
        $this->setParametro('tipo_flota','tipo_flota','varchar');
        $this->setParametro('pic_sic','pic_sic','varchar');
        $this->setParametro('fecha_ini','fecha_ini','date');
        $this->setParametro('fecha_fin','fecha_fin','date');
        //Ejecuta la instruccion
        $this->armarConsulta();
        $this->ejecutarConsulta();

        //Devuelve la respuesta
        return $this->respuesta;
    }

    function eliminarAnexo1(){
        //Definicion de variables para ejecucion del procedimiento
        $this->procedimiento='oip.ft_anexo1_ime';
        $this->transaccion='OIP_TIPANE1_ELI';
        $this->tipo_procedimiento='IME';

        //Define los parametros para la funcion
        $this->setParametro('id_anexo1','id_anexo1','int4');

        //Ejecuta la instruccion
        $this->armarConsulta();
        $this->ejecutarConsulta();

        //Devuelve la respuesta
        return $this->respuesta;
    }

}
?>
