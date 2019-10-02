/*******************************************I-DAT-BVP-HORAS-PILOTO-0-02/10/2019***********************************************/
----------------------------------
--COPY LINES TO data.sql FILE
---------------------------------

select pxp.f_insert_tgui (' <img width="25px" height="25px" src="../../../lib/imagenes/icono_awesome/pilotos.png" alt="Piloto">OTROS INGRESOS PILOTOS', '', 'OIP', 'si', 1, '', 1, '', '', 'OIP');
select pxp.f_insert_tgui ('Pago Variable a Pilotos', 'Pago Variable a Pilotos', 'PAGVAPI', 'si', 1, 'sis_horas_piloto/vista/archivo_horas_piloto/ArchivoHorasPiloto.php
', 2, '', 'ArchivoHorasPiloto', 'OIP');
select pxp.f_insert_tgui ('Detalle Horas Piloto', 'Detalle Horas Piloto', 'PAGVAPI.1', 'no', 1, 'sis_horas_piloto/vista/horas_piloto/HorasPiloto.php', 3, '', '50%', 'OIP');
select pxp.f_insert_tgui ('Tipo Simulador', 'Tipos de Simulador', 'TIPSIMU', 'si', 0, 'sis_horas_piloto/vista/tipo_simulador/TipoSimulador.php', 2, '', 'TipoSimulador', 'OIP');
select pxp.f_insert_tgui ('Parametros', 'Parametros', 'PARAMOIP', 'si', 1, '', 2, '', '', 'OIP');
select pxp.f_insert_tgui ('Procesos', 'Procesos', 'PROCMOIP', 'si', 2, '', 2, '', '', 'OIP');
select pxp.f_insert_tgui ('Reportes', 'reportes', 'REPOIP', 'si', 3, '', 2, '', '', 'OIP');
select pxp.f_insert_tgui ('Tipo Flota', 'tipo flota', 'TIPFLO', 'si', 1, 'sis_horas_piloto/vista/tipo_flota/TipoFlota.php', 3, '', 'TipoFlota', 'OIP');
select pxp.f_insert_tgui ('Anexo', 'anexo', 'TIPANE', 'si', 3, 'sis_horas_piloto/vista/anexo1/Anexo1.php', 3, '', 'Anexo1', 'OIP');
select pxp.f_insert_tfuncion ('oip.ft_archivo_horas_piloto_ime', 'Funcion para tabla     ', 'OIP');
select pxp.f_insert_tfuncion ('oip.ft_archivo_horas_piloto_sel', 'Funcion para tabla     ', 'OIP');
select pxp.f_insert_tfuncion ('oip.ft_horas_piloto_ime', 'Funcion para tabla     ', 'OIP');
select pxp.f_insert_tfuncion ('oip.ft_horas_piloto_sel', 'Funcion para tabla     ', 'OIP');
select pxp.f_insert_tprocedimiento ('OIP_ARHOPI_INS', 'Insercion de registros', 'si', '', '', 'oip.ft_archivo_horas_piloto_ime');
select pxp.f_insert_tprocedimiento ('OIP_ARHOPI_MOD', 'Modificacion de registros', 'si', '', '', 'oip.ft_archivo_horas_piloto_ime');
select pxp.f_insert_tprocedimiento ('OIP_ARHOPI_ELI', 'Eliminacion de registros', 'si', '', '', 'oip.ft_archivo_horas_piloto_ime');
select pxp.f_insert_tprocedimiento ('OIP_ARHOPI_SEL', 'Consulta de datos', 'si', '', '', 'oip.ft_archivo_horas_piloto_sel');
select pxp.f_insert_tprocedimiento ('OIP_ARHOPI_CONT', 'Conteo de registros', 'si', '', '', 'oip.ft_archivo_horas_piloto_sel');
select pxp.f_insert_tprocedimiento ('OIP_HOPILO_INS', 'Insercion de registros', 'si', '', '', 'oip.ft_horas_piloto_ime');
select pxp.f_insert_tprocedimiento ('OIP_HOPILO_MOD', 'Modificacion de registros', 'si', '', '', 'oip.ft_horas_piloto_ime');
select pxp.f_insert_tprocedimiento ('OIP_HOPILO_ELI', 'Eliminacion de registros', 'si', '', '', 'oip.ft_horas_piloto_ime');
select pxp.f_insert_tprocedimiento ('OIP_HOPILO_SEL', 'Consulta de datos', 'si', '', '', 'oip.ft_horas_piloto_sel');
select pxp.f_insert_tprocedimiento ('OIP_HOPILO_CONT', 'Conteo de registros', 'si', '', '', 'oip.ft_horas_piloto_sel');
----------------------------------
--COPY LINES TO dependencies.sql FILE
---------------------------------
/*******************************************F-DAT-BVP-HORAS-PILOTO-0-02/10/2019***********************************************/
