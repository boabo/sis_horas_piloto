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
  (1, 1, E'2019-09-19 10:45:28', E'2019-09-30 11:06:36.552', E'activo', NULL, E'NULL', 3, E'corto_alcance', '208.8', '104.4', '40', '0.8', 100);

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


/*******************************************I-DAT-BVP-HORAS-PILOTO-0-01/11/2019***********************************************/

INSERT INTO oip.tacumulado_copiloto_corto_alcance ("id_usuario_reg", "id_usuario_mod", "fecha_reg", "fecha_mod", "estado_reg", "id_usuario_ai", "usuario_ai", "id_piloto_corto_alcance", "horas_vuelo", "costo_hora", "acumulado", "salario_acumulado")
VALUES 
  (830, NULL, E'2019-10-31 12:13:40', E'2019-10-31 12:13:40', E'activo', NULL, NULL, 1, 41, '87', '87', '11061'),
  (830, NULL, E'2019-10-31 12:13:40', E'2019-10-31 12:13:40', E'activo', NULL, NULL, 2, 42, '89.12', '178.24', '11152.24'),
  (830, NULL, E'2019-10-31 12:13:40', E'2019-10-31 12:13:40', E'activo', NULL, NULL, 3, 43, '91.24', '273.73', '11247.73'),
  (830, NULL, E'2019-10-31 12:13:40', E'2019-10-31 12:13:40', E'activo', NULL, NULL, 4, 44, '93.37', '373.46', '11347.46'),
  (830, NULL, E'2019-10-31 12:13:40', E'2019-10-31 12:13:40', E'activo', NULL, NULL, 5, 45, '95.49', '477.44', '11451.44'),
  (830, NULL, E'2019-10-31 12:13:40', E'2019-10-31 12:13:40', E'activo', NULL, NULL, 6, 46, '97.61', '585.66', '11559.66'),
  (830, NULL, E'2019-10-31 12:13:40', E'2019-10-31 12:13:40', E'activo', NULL, NULL, 7, 47, '99.73', '698.12', '11672.12'),
  (830, NULL, E'2019-10-31 12:13:40', E'2019-10-31 12:13:40', E'activo', NULL, NULL, 8, 48, '101.85', '814.83', '11788.83'),
  (830, NULL, E'2019-10-31 12:13:40', E'2019-10-31 12:13:40', E'activo', NULL, NULL, 9, 49, '103.98', '935.78', '11909.78'),
  (830, NULL, E'2019-10-31 12:13:40', E'2019-10-31 12:13:40', E'activo', NULL, NULL, 10, 50, '106.1', '1060.98', '12034.98'),
  (830, NULL, E'2019-10-31 12:13:40', E'2019-10-31 12:13:40', E'activo', NULL, NULL, 11, 51, '108.22', '1190.41', '12164.41'),
  (830, NULL, E'2019-10-31 12:13:40', E'2019-10-31 12:13:40', E'activo', NULL, NULL, 12, 52, '110.34', '1324.1', '12298.1'),
  (830, NULL, E'2019-10-31 12:13:40', E'2019-10-31 12:13:40', E'activo', NULL, NULL, 13, 53, '112.46', '1462.02', '12436.02'),
  (830, NULL, E'2019-10-31 12:13:40', E'2019-10-31 12:13:40', E'activo', NULL, NULL, 14, 54, '114.59', '1604.2', '12578.2'),
  (830, NULL, E'2019-10-31 12:13:40', E'2019-10-31 12:13:40', E'activo', NULL, NULL, 15, 55, '116.71', '1750.61', '12724.61'),
  (830, NULL, E'2019-10-31 12:13:40', E'2019-10-31 12:13:40', E'activo', NULL, NULL, 16, 56, '118.83', '1901.27', '12875.27'),
  (830, NULL, E'2019-10-31 12:13:40', E'2019-10-31 12:13:40', E'activo', NULL, NULL, 17, 57, '120.95', '2056.17', '13030.17'),
  (830, NULL, E'2019-10-31 12:13:40', E'2019-10-31 12:13:40', E'activo', NULL, NULL, 18, 58, '123.07', '2215.32', '13189.32'),
  (830, NULL, E'2019-10-31 12:13:40', E'2019-10-31 12:13:40', E'activo', NULL, NULL, 19, 59, '125.2', '2378.71', '13352.71'),
  (830, NULL, E'2019-10-31 12:13:40', E'2019-10-31 12:13:40', E'activo', NULL, NULL, 20, 60, '127.32', '2546.34', '13520.34'),
  (830, NULL, E'2019-10-31 12:13:40', E'2019-10-31 12:13:40', E'activo', NULL, NULL, 21, 61, '129.44', '2718.22', '13692.22'),
  (830, NULL, E'2019-10-31 12:13:40', E'2019-10-31 12:13:40', E'activo', NULL, NULL, 22, 62, '131.56', '2894.34', '13868.34'),
  (830, NULL, E'2019-10-31 12:13:40', E'2019-10-31 12:13:40', E'activo', NULL, NULL, 23, 63, '133.68', '3074.71', '14048.71'),
  (830, NULL, E'2019-10-31 12:13:40', E'2019-10-31 12:13:40', E'activo', NULL, NULL, 24, 64, '135.8', '3259.32', '14233.32'),
  (830, NULL, E'2019-10-31 12:13:40', E'2019-10-31 12:13:40', E'activo', NULL, NULL, 25, 65, '137.93', '3448.17', '14422.17'),
  (830, NULL, E'2019-10-31 12:13:40', E'2019-10-31 12:13:40', E'activo', NULL, NULL, 26, 66, '140.05', '3641.27', '14615.27'),
  (830, NULL, E'2019-10-31 12:13:40', E'2019-10-31 12:13:40', E'activo', NULL, NULL, 27, 67, '142.17', '3838.61', '14812.61'),
  (830, NULL, E'2019-10-31 12:13:40', E'2019-10-31 12:13:40', E'activo', NULL, NULL, 28, 68, '144.29', '4040.2', '15014.2'),
  (830, NULL, E'2019-10-31 12:13:40', E'2019-10-31 12:13:40', E'activo', NULL, NULL, 29, 69, '146.41', '4246.02', '15220.02'),
  (830, NULL, E'2019-10-31 12:13:40', E'2019-10-31 12:13:40', E'activo', NULL, NULL, 30, 70, '148.54', '4456.1', '15430.1');

  /* Data for the 'oip.tacumulado_piloto_corto_alcance' table  (Records 1 - 30) */

INSERT INTO oip.tacumulado_piloto_corto_alcance ("id_usuario_reg", "id_usuario_mod", "fecha_reg", "fecha_mod", "estado_reg", "id_usuario_ai", "usuario_ai", "id_piloto_corto_alcance", "horas_vuelo", "costo_hora", "acumulado", "salario_acumulado")
VALUES 
  (830, NULL, E'2019-10-31 12:13:40', E'2019-10-31 12:13:40', E'activo', NULL, NULL, 1, 41, '174', '174', '21.081'),
  (830, NULL, E'2019-10-31 12:13:40', E'2019-10-31 12:13:40', E'activo', NULL, NULL, 2, 42, '178.24', '356.49', '21263.49'),
  (830, NULL, E'2019-10-31 12:13:40', E'2019-10-31 12:13:40', E'activo', NULL, NULL, 3, 43, '182.49', '547.46', '21454.46'),
  (830, NULL, E'2019-10-31 12:13:40', E'2019-10-31 12:13:40', E'activo', NULL, NULL, 4, 44, '186.73', '746.93', '21653.93'),
  (830, NULL, E'2019-10-31 12:13:40', E'2019-10-31 12:13:40', E'activo', NULL, NULL, 5, 45, '190.98', '954.88', '21861.88'),
  (830, NULL, E'2019-10-31 12:13:40', E'2019-10-31 12:13:40', E'activo', NULL, NULL, 6, 46, '195.22', '1171.32', '22078.32'),
  (830, NULL, E'2019-10-31 12:13:40', E'2019-10-31 12:13:40', E'activo', NULL, NULL, 7, 47, '199.46', '1396.24', '22303.24'),
  (830, NULL, E'2019-10-31 12:13:40', E'2019-10-31 12:13:40', E'activo', NULL, NULL, 8, 48, '203.71', '1629.66', '22536.66'),
  (830, NULL, E'2019-10-31 12:13:40', E'2019-10-31 12:13:40', E'activo', NULL, NULL, 9, 49, '207.95', '1871.56', '22778.56'),
  (830, NULL, E'2019-10-31 12:13:40', E'2019-10-31 12:13:40', E'activo', NULL, NULL, 10, 50, '212.2', '2121.95', '23028.95'),
  (830, NULL, E'2019-10-31 12:13:40', E'2019-10-31 12:13:40', E'activo', NULL, NULL, 11, 51, '216.44', '2380.83', '23287.83'),
  (830, NULL, E'2019-10-31 12:13:40', E'2019-10-31 12:13:40', E'activo', NULL, NULL, 12, 52, '220.68', '2648.2', '23555.2'),
  (830, NULL, E'2019-10-31 12:13:40', E'2019-10-31 12:13:40', E'activo', NULL, NULL, 13, 53, '224.93', '2924.05', '23831.05'),
  (830, NULL, E'2019-10-31 12:13:40', E'2019-10-31 12:13:40', E'activo', NULL, NULL, 14, 54, '229.17', '3208.39', '24115.39'),
  (830, NULL, E'2019-10-31 12:13:40', E'2019-10-31 12:13:40', E'activo', NULL, NULL, 15, 55, '233.41', '3501.22', '24408.22'),
  (830, NULL, E'2019-10-31 12:13:40', E'2019-10-31 12:13:40', E'activo', NULL, NULL, 16, 56, '237.66', '3802.54', '24709.54'),
  (830, NULL, E'2019-10-31 12:13:40', E'2019-10-31 12:13:40', E'activo', NULL, NULL, 17, 57, '241.9', '4112.34', '25019.34'),
  (830, NULL, E'2019-10-31 12:13:40', E'2019-10-31 12:13:40', E'activo', NULL, NULL, 18, 58, '246.15', '4430.63', '25337.63'),
  (830, NULL, E'2019-10-31 12:13:40', E'2019-10-31 12:13:40', E'activo', NULL, NULL, 19, 59, '250.39', '4757.41', '25664.41'),
  (830, NULL, E'2019-10-31 12:13:40', E'2019-10-31 12:13:40', E'activo', NULL, NULL, 20, 60, '254.63', '5092.68', '25999.68'),
  (830, NULL, E'2019-10-31 12:13:40', E'2019-10-31 12:13:40', E'activo', NULL, NULL, 21, 61, '258.88', '5436.44', '26343.44'),
  (830, NULL, E'2019-10-31 12:13:40', E'2019-10-31 12:13:40', E'activo', NULL, NULL, 22, 62, '263.12', '5788.68', '26695.68'),
  (830, NULL, E'2019-10-31 12:13:40', E'2019-10-31 12:13:40', E'activo', NULL, NULL, 23, 63, '267.37', '6149.41', '27056.41'),
  (830, NULL, E'2019-10-31 12:13:40', E'2019-10-31 12:13:40', E'activo', NULL, NULL, 24, 64, '271.61', '6518.63', '27425.63'),
  (830, NULL, E'2019-10-31 12:13:40', E'2019-10-31 12:13:40', E'activo', NULL, NULL, 25, 65, '275.85', '6896.34', '27803.34'),
  (830, NULL, E'2019-10-31 12:13:40', E'2019-10-31 12:13:40', E'activo', NULL, NULL, 26, 66, '280.1', '7282.54', '28189.54'),
  (830, NULL, E'2019-10-31 12:13:40', E'2019-10-31 12:13:40', E'activo', NULL, NULL, 27, 67, '284.34', '7677.22', '28584.22'),
  (830, NULL, E'2019-10-31 12:13:40', E'2019-10-31 12:13:40', E'activo', NULL, NULL, 28, 68, '288.59', '8080.39', '28987.39'),
  (830, NULL, E'2019-10-31 12:13:40', E'2019-10-31 12:13:40', E'activo', NULL, NULL, 29, 69, '292.83', '8492.05', '29399.05'),
  (830, NULL, E'2019-10-31 12:13:40', E'2019-10-31 12:13:40', E'activo', NULL, NULL, 30, 70, '297.07', '8912.2', '29819.2');
/*******************************************F-DAT-BVP-HORAS-PILOTO-0-01/11/2019***********************************************/