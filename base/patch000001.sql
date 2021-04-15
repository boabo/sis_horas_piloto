/***********************************I-SCP-BVP-HORAS-PILOTO-0-02/10/2019****************************************/
CREATE TABLE oip.tanexo1 (
  id_anexo1 SERIAL,
  id_escala_salarial INTEGER NOT NULL,
  numero_casos INTEGER,
  remuneracion_basica NUMERIC(20,2),
  remuneracion_maxima NUMERIC(20,2),
  tipo_flota VARCHAR(100),
  pic_sic VARCHAR(100),
  CONSTRAINT tanexo1_pkey PRIMARY KEY(id_anexo1),
  CONSTRAINT tanexo1_fk FOREIGN KEY (id_escala_salarial)
    REFERENCES orga.tescala_salarial(id_escala_salarial)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION
    NOT DEFERRABLE
) INHERITS (pxp.tbase)
WITH (oids = false);

ALTER TABLE oip.tanexo1
  OWNER TO postgres;


CREATE TABLE oip.tarchivo_horas_piloto (
  id_archivo_horas_piloto SERIAL,
  id_gestion INTEGER NOT NULL,
  id_periodo INTEGER NOT NULL,
  nombre VARCHAR(200) NOT NULL,
  estado VARCHAR(50) NOT NULL,
  cerrado VARCHAR(2),
  archivo VARCHAR,
  pago_total NUMERIC(20,2),
  CONSTRAINT tarchivo_horas_piloto_id_periodo_key UNIQUE(id_periodo),
  CONSTRAINT tarchivo_horas_piloto_pkey PRIMARY KEY(id_archivo_horas_piloto),
  CONSTRAINT tarchivo_horas_piloto_fk FOREIGN KEY (id_gestion)
    REFERENCES param.tgestion(id_gestion)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION
    NOT DEFERRABLE,
  CONSTRAINT tarchivo_horas_piloto_fk1 FOREIGN KEY (id_periodo)
    REFERENCES param.tperiodo(id_periodo)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION
    NOT DEFERRABLE
) INHERITS (pxp.tbase)
WITH (oids = false);

ALTER TABLE oip.tarchivo_horas_piloto
  ALTER COLUMN id_archivo_horas_piloto SET STATISTICS 0;

ALTER TABLE oip.tarchivo_horas_piloto
  ALTER COLUMN id_gestion SET STATISTICS 0;

ALTER TABLE oip.tarchivo_horas_piloto
  ALTER COLUMN id_periodo SET STATISTICS 0;

ALTER TABLE oip.tarchivo_horas_piloto
  ALTER COLUMN nombre SET STATISTICS 0;

ALTER TABLE oip.tarchivo_horas_piloto
  ALTER COLUMN estado SET STATISTICS 0;

ALTER TABLE oip.tarchivo_horas_piloto
  OWNER TO postgres;


  CREATE TABLE oip.thoras_piloto (
  id_horas_piloto SERIAL,
  gestion INTEGER NOT NULL,
  mes INTEGER NOT NULL,
  ci VARCHAR(20),
  nombre_piloto VARCHAR(500),
  tipo_flota VARCHAR(100) NOT NULL,
  horas_vuelo INTEGER,
  horas_simulador_full INTEGER,
  horas_simulador_fix INTEGER,
  estado VARCHAR(50) DEFAULT 'borrador'::character varying NOT NULL,
  id_archivo_horas_piloto INTEGER NOT NULL,
  id_funcionario INTEGER NOT NULL,
  pic_sic VARCHAR(100) NOT NULL,
  factor_esfuerzo NUMERIC(20,2),
  pago_variable NUMERIC(20,2),
  monto_horas_vuelo NUMERIC(20,2),
  monto_horas_simulador_full NUMERIC(20,2),
  monto_horas_simulador_fix NUMERIC(20,2),
  horas_simulador_full_efectivas INTEGER,
  horas_simulador_fix_efectivas INTEGER,
  id_cargo INTEGER,
  CONSTRAINT thoras_piloto_pkey PRIMARY KEY(id_horas_piloto),
  CONSTRAINT thoras_piloto_fk FOREIGN KEY (id_archivo_horas_piloto)
    REFERENCES oip.tarchivo_horas_piloto(id_archivo_horas_piloto)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION
    NOT DEFERRABLE,
  CONSTRAINT thoras_piloto_fk1 FOREIGN KEY (id_funcionario)
    REFERENCES orga.tfuncionario(id_funcionario)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION
    NOT DEFERRABLE,
  CONSTRAINT thoras_piloto_fk2 FOREIGN KEY (id_cargo)
    REFERENCES orga.tcargo(id_cargo)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION
    NOT DEFERRABLE
) INHERITS (pxp.tbase)
WITH (oids = false);

ALTER TABLE oip.thoras_piloto
  ALTER COLUMN id_horas_piloto SET STATISTICS 0;

ALTER TABLE oip.thoras_piloto
  ALTER COLUMN gestion SET STATISTICS 0;

ALTER TABLE oip.thoras_piloto
  ALTER COLUMN mes SET STATISTICS 0;

ALTER TABLE oip.thoras_piloto
  ALTER COLUMN ci SET STATISTICS 0;

ALTER TABLE oip.thoras_piloto
  OWNER TO postgres;


  CREATE TABLE oip.tlog_estado (
  id_log_estado SERIAL,
  id_archivo_horas_piloto INTEGER NOT NULL,
  accion VARCHAR(50),
  detalle TEXT,
  estado VARCHAR(50),
  CONSTRAINT tlog_estado_pkey PRIMARY KEY(id_log_estado)
) INHERITS (pxp.tbase)
WITH (oids = false);

ALTER TABLE oip.tlog_estado
  OWNER TO postgres;


CREATE TABLE oip.ttipo_flota (
  id_tipo_flota SERIAL,
  tipo_flota VARCHAR(100) NOT NULL,
  costo_hora_base_pic NUMERIC(20,2) NOT NULL,
  costo_hora_base_sic NUMERIC(20,2) NOT NULL,
  horas_base NUMERIC(20,2) NOT NULL,
  relacion_ciclo_hora NUMERIC(20,2) NOT NULL,
  maximo_horas INTEGER,
  CONSTRAINT ttipo_flota_pkey PRIMARY KEY(id_tipo_flota)
) INHERITS (pxp.tbase)
WITH (oids = false);

ALTER TABLE oip.ttipo_flota
  ALTER COLUMN id_tipo_flota SET STATISTICS 0;

ALTER TABLE oip.ttipo_flota
  ALTER COLUMN tipo_flota SET STATISTICS 0;

ALTER TABLE oip.ttipo_flota
  ALTER COLUMN costo_hora_base_pic SET STATISTICS 0;

ALTER TABLE oip.ttipo_flota
  ALTER COLUMN costo_hora_base_sic SET STATISTICS 0;

ALTER TABLE oip.ttipo_flota
  ALTER COLUMN horas_base SET STATISTICS 0;

ALTER TABLE oip.ttipo_flota
  ALTER COLUMN relacion_ciclo_hora SET STATISTICS 0;

ALTER TABLE oip.ttipo_flota
  OWNER TO postgres;

CREATE TABLE oip.ttipo_simulador (
  id_tipo_simulador SERIAL,
  tipo_simulador VARCHAR(100) NOT NULL,
  costo_hora NUMERIC(20,2) NOT NULL,
  maximo_horas INTEGER,
  CONSTRAINT ttipo_simulador_pkey PRIMARY KEY(id_tipo_simulador)
) INHERITS (pxp.tbase)
WITH (oids = false);

ALTER TABLE oip.ttipo_simulador
  ALTER COLUMN id_tipo_simulador SET STATISTICS 0;

ALTER TABLE oip.ttipo_simulador
  ALTER COLUMN tipo_simulador SET STATISTICS 0;

ALTER TABLE oip.ttipo_simulador
  ALTER COLUMN costo_hora SET STATISTICS 0;

ALTER TABLE oip.ttipo_simulador
  OWNER TO postgres;

/***********************************F-SCP-BVP-HORAS-PILOTO-0-02/10/2019****************************************/
/***********************************I-SCP-BVP-HORAS-PILOTO-0-21/10/2019****************************************/
ALTER TABLE oip.thoras_piloto
  ALTER COLUMN pago_variable TYPE NUMERIC(20,10);

ALTER TABLE oip.thoras_piloto
  ALTER COLUMN monto_horas_vuelo TYPE NUMERIC(20,10);

ALTER TABLE oip.thoras_piloto
  ALTER COLUMN monto_horas_simulador_full TYPE NUMERIC(20,10);

ALTER TABLE oip.thoras_piloto
  ALTER COLUMN monto_horas_simulador_fix TYPE NUMERIC(20,10);
/***********************************F-SCP-BVP-HORAS-PILOTO-0-21/10/2019****************************************/

/***********************************I-SCP-BVP-HORAS-PILOTO-0-01/11/2019****************************************/
CREATE TABLE oip.tacumulado_copiloto_corto_alcance (
  id_piloto_corto_alcance SERIAL,
  horas_vuelo INTEGER NOT NULL,
  costo_hora NUMERIC(20,10),
  acumulado NUMERIC(20,10),
  salario_acumulado NUMERIC(20,10),
  CONSTRAINT tacumulado_copiloto_corto_alcance_pkey PRIMARY KEY(id_piloto_corto_alcance)
) INHERITS (pxp.tbase)
WITH (oids = false);

ALTER TABLE oip.tacumulado_copiloto_corto_alcance
  OWNER TO postgres;

CREATE TABLE oip.tacumulado_piloto_corto_alcance (
  id_piloto_corto_alcance SERIAL,
  horas_vuelo INTEGER NOT NULL,
  costo_hora NUMERIC(20,10),
  acumulado NUMERIC(20,10),
  salario_acumulado NUMERIC(20,10),
  CONSTRAINT tacumulado_piloto_corto_pkey PRIMARY KEY(id_piloto_corto_alcance)
) INHERITS (pxp.tbase)
WITH (oids = false);

ALTER TABLE oip.tacumulado_piloto_corto_alcance
  OWNER TO postgres;

/***********************************F-SCP-BVP-HORAS-PILOTO-0-01/11/2019****************************************/
/***********************************I-SCP-BVP-HORAS-PILOTO-0-15/04/2021****************************************/

ALTER TABLE oip.tanexo1
  ADD COLUMN fecha_ini DATE;

ALTER TABLE oip.tanexo1
  ADD COLUMN fecha_fin DATE;
/***********************************F-SCP-BVP-HORAS-PILOTO-0-15/04/2021****************************************/
