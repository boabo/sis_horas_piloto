<?php
/**
 *@package pXP
 *@file gen-ACTAnexo1.php
 *@author  (admin)
 *@date 26-09-2019 12:54:57
 *@description Clase que recibe los parametros enviados por la vista para mandar a la capa de Modelo
 */

class ACTAnexo1 extends ACTbase
{

    function listarAnexo1()
    {
        $this->objParam->defecto('ordenacion', 'id_anexo1');

        $this->objParam->defecto('dir_ordenacion', 'asc');
        if ($this->objParam->getParametro('tipoReporte') == 'excel_grid' || $this->objParam->getParametro('tipoReporte') == 'pdf_grid') {
            $this->objReporte = new Reporte($this->objParam, $this);
            $this->res = $this->objReporte->generarReporteListado('MODAnexo1', 'listarAnexo1');
        } else {
            $this->objFunc = $this->create('MODAnexo1');

            $this->res = $this->objFunc->listarAnexo1($this->objParam);
        }
        $this->res->imprimirRespuesta($this->res->generarJson());
    }

    function insertarAnexo1()
    {
        $this->objFunc = $this->create('MODAnexo1');
        if ($this->objParam->insertar('id_anexo1')) {
            $this->res = $this->objFunc->insertarAnexo1($this->objParam);
        } else {
            $this->res = $this->objFunc->modificarAnexo1($this->objParam);
        }
        $this->res->imprimirRespuesta($this->res->generarJson());
    }

    function eliminarAnexo1()
    {
        $this->objFunc = $this->create('MODAnexo1');
        $this->res = $this->objFunc->eliminarAnexo1($this->objParam);
        $this->res->imprimirRespuesta($this->res->generarJson());
    }
}

?>