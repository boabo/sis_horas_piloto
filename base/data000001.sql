/*******************************************I-DAT-BVP-HORAS-PILOTO-0-02/10/2019***********************************************/
----------------------------------
--COPY LINES TO data.sql FILE
---------------------------------

INSERT INTO segu.tsubsistema ("codigo", "nombre", "fecha_reg", "prefijo", "estado_reg", "nombre_carpeta", "id_subsis_orig")
VALUES (E'OIP', E'Otros Ingresos Pilotos', E'2019-10-02', E'OIP', E'activo', E'horas_piloto', NULL);

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

----------------------------------
--COPY LINES TO dependencies.sql FILE
---------------------------------

INSERT INTO oip.ttipo_flota ("id_usuario_reg", "id_usuario_mod", "fecha_reg", "fecha_mod", "estado_reg", "id_usuario_ai", "usuario_ai", "id_tipo_flota", "tipo_flota", "costo_hora_base_pic", "costo_hora_base_sic", "horas_base", "relacion_ciclo_hora", "maximo_horas")
VALUES
  (1, NULL, E'2019-09-19 10:38:02', E'2019-09-19 10:38:02', E'activo', NULL, NULL, 1, E'largo_alcance', '556.8', '278.4', '60', '6.5', 100),
  (1, NULL, E'2019-09-19 10:39:12', E'2019-09-19 10:39:12', E'activo', NULL, NULL, 2, E'mediano_alcance', '278.4', '139.2', '60', '1', 100),
  (1, 1, E'2019-09-19 10:45:28', E'2019-09-30 11:06:36.552', E'activo', NULL, E'NULL', 3, E'corto_alcance', '1208.87', '1104.4', '40', '0.8', 100);

/* Data for the 'oip.ttipo_simulador' table  (Records 1 - 2) */

INSERT INTO oip.ttipo_simulador ("id_usuario_reg", "id_usuario_mod", "fecha_reg", "fecha_mod", "estado_reg", "id_usuario_ai", "usuario_ai", "id_tipo_simulador", "tipo_simulador", "costo_hora", "maximo_horas")
VALUES
  (830, NULL, E'2019-09-19 10:44:28', E'2019-09-19 10:44:28', E'activo', NULL, NULL, 1, E'Full Flight Simulator', '278.4', 20),
  (830, NULL, E'2019-09-19 10:44:53', E'2019-09-19 10:44:53', E'activo', NULL, NULL, 2, E'Fix Based Simulator', '139.2', 20);

/* Data for the 'oip.tanexo1' table  (Records 1 - 10) */
TRUNCATE TABLE oip.tanexo1;
INSERT INTO oip.tanexo1 ("id_usuario_reg", "id_usuario_mod", "fecha_reg", "fecha_mod", "estado_reg", "id_usuario_ai", "usuario_ai", "id_anexo1", "id_escala_salarial", "numero_casos", "remuneracion_basica", "remuneracion_maxima", "tipo_flota", "pic_sic")
VALUES
  (830, NULL, E'2019-09-26 12:13:33', E'2019-09-26 12:13:33', E'activo', NULL, NULL, 2, 158, 1, '22367', '22367', E'largo_alcance', E'PIC'),
  (830, NULL, E'2019-09-26 17:57:29', E'2019-09-26 17:57:29', E'activo', NULL, NULL, 3, 246, 7, '36360', '47545', E'largo_alcance', E'PIC'),
  (830, NULL, E'2019-09-26 17:58:36', E'2019-09-26 17:58:36', E'activo', NULL, NULL, 4, 241, 23, '32825', '44010', E'largo_alcance', E'PIC'),
  (830, NULL, E'2019-09-26 17:59:33', E'2019-09-26 17:59:33', E'activo', NULL, NULL, 5, 159, 15, '32320', '56144', E'mediano_alcance', E'PIC'),
  (830, NULL, E'2019-09-26 18:00:19', E'2019-09-26 18:00:19', E'activo', NULL, NULL, 6, 160, 48, '28534', '52358', E'mediano_alcance', E'PIC'),
  (830, NULL, E'2019-09-26 18:02:37', E'2019-09-26 18:02:37', E'activo', NULL, NULL, 7, 263, 5, '23230', '32142', E'corto_alcance', E'PIC'),
  (830, NULL, E'2019-09-26 18:04:19', E'2019-09-26 18:04:19', E'activo', NULL, NULL, 8, 264, 12, '20907', '29819', E'corto_alcance', E'PIC'),
  (830, NULL, E'2019-09-26 18:05:36', E'2019-09-26 18:05:36', E'activo', NULL, NULL, 9, 261, 18, '18405', '21214', E'largo_alcance', E'SIC'),
  (830, NULL, E'2019-09-26 18:06:21', E'2019-09-26 18:06:21', E'activo', NULL, NULL, 10, 201, 45, '17045', '26173', E'mediano_alcance', E'SIC'),
  (830, NULL, E'2019-09-26 18:07:18', E'2019-09-26 18:07:18', E'activo', NULL, NULL, 11, 250, 16, '10974', '15430', E'corto_alcance', E'SIC');
/*******************************************F-DAT-BVP-HORAS-PILOTO-0-02/10/2019***********************************************/


