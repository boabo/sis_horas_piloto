<?php
$ruta_archivo = $_GET['ruta'];
$extension    = $_GET['ext'];
header('Content-Description: File Transfer');
header('Content-Type: application/octet-stream');
header('Content-Disposition: attachment; filename="ArchivoExcelCargado.' . $extension);
header('Content-Transfer-Encoding: binary');
header('Connection: Keep-Alive');
header('Expires: 0');
header('Cache-Control: must-revalidate, post-check=0, pre-check=0');
header('Pragma: public');
readfile($ruta_archivo);
?>