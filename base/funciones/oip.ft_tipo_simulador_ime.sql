CREATE OR REPLACE FUNCTION oip.ft_tipo_simulador_ime (
  p_administrador integer,
  p_id_usuario integer,
  p_tabla varchar,
  p_transaccion varchar
)
RETURNS varchar AS
$body$
/**************************************************************************
 SISTEMA:		Horas Piloto
 FUNCION: 		oip.ft_tipo_simulador_ime
 DESCRIPCION:   Funcion que gestiona las operaciones basicas (inserciones, modificaciones, eliminaciones de la tabla 'oip.ttipo_simulador'
 AUTOR: 		 (admin)
 FECHA:	        24-09-2019 14:13:43
 COMENTARIOS:
***************************************************************************
 HISTORIAL DE MODIFICACIONES:
#ISSUE				FECHA				AUTOR				DESCRIPCION
 #0				24-09-2019 14:13:43								Funcion que gestiona las operaciones basicas (inserciones, modificaciones, eliminaciones de la tabla 'oip.ttipo_simulador'
 #
 ***************************************************************************/

DECLARE

	v_nro_requerimiento    	integer;
	v_parametros           	record;
	v_id_requerimiento     	integer;
	v_resp		            varchar;
	v_nombre_funcion        text;
	v_mensaje_error         text;
	v_id_tipo_simulador	integer;

BEGIN

    v_nombre_funcion = 'oip.ft_tipo_simulador_ime';
    v_parametros = pxp.f_get_record(p_tabla);

	/*********************************
 	#TRANSACCION:  'OIP_TIPSIMU_INS'
 	#DESCRIPCION:	Insercion de registros
 	#AUTOR:		admin
 	#FECHA:		24-09-2019 14:13:43
	***********************************/

	if(p_transaccion='OIP_TIPSIMU_INS')then

        begin
        	--Sentencia de la insercion
        	insert into oip.ttipo_simulador(
			estado_reg,
			tipo_simulador,
			costo_hora,
			maximo_horas,
			id_usuario_reg,
			fecha_reg,
			id_usuario_ai,
			usuario_ai,
			id_usuario_mod,
			fecha_mod
          	) values(
			'activo',
			v_parametros.tipo_simulador,
			v_parametros.costo_hora,
			v_parametros.maximo_horas,
			p_id_usuario,
			now(),
			v_parametros._id_usuario_ai,
			v_parametros._nombre_usuario_ai,
			null,
			null



			)RETURNING id_tipo_simulador into v_id_tipo_simulador;

			--Definicion de la respuesta
			v_resp = pxp.f_agrega_clave(v_resp,'mensaje','Tipo Simulador almacenado(a) con exito (id_tipo_simulador'||v_id_tipo_simulador||')');
            v_resp = pxp.f_agrega_clave(v_resp,'id_tipo_simulador',v_id_tipo_simulador::varchar);

            --Devuelve la respuesta
            return v_resp;

		end;

	/*********************************
 	#TRANSACCION:  'OIP_TIPSIMU_MOD'
 	#DESCRIPCION:	Modificacion de registros
 	#AUTOR:		admin
 	#FECHA:		24-09-2019 14:13:43
	***********************************/

	elsif(p_transaccion='OIP_TIPSIMU_MOD')then

		begin
			--Sentencia de la modificacion
			update oip.ttipo_simulador set
			tipo_simulador = v_parametros.tipo_simulador,
			costo_hora = v_parametros.costo_hora,
			maximo_horas = v_parametros.maximo_horas,
			id_usuario_mod = p_id_usuario,
			fecha_mod = now(),
			id_usuario_ai = v_parametros._id_usuario_ai,
			usuario_ai = v_parametros._nombre_usuario_ai
			where id_tipo_simulador=v_parametros.id_tipo_simulador;

			--Definicion de la respuesta
            v_resp = pxp.f_agrega_clave(v_resp,'mensaje','Tipo Simulador modificado(a)');
            v_resp = pxp.f_agrega_clave(v_resp,'id_tipo_simulador',v_parametros.id_tipo_simulador::varchar);

            --Devuelve la respuesta
            return v_resp;

		end;

	/*********************************
 	#TRANSACCION:  'OIP_TIPSIMU_ELI'
 	#DESCRIPCION:	Eliminacion de registros
 	#AUTOR:		admin
 	#FECHA:		24-09-2019 14:13:43
	***********************************/

	elsif(p_transaccion='OIP_TIPSIMU_ELI')then

		begin
			--Sentencia de la eliminacion
			delete from oip.ttipo_simulador
            where id_tipo_simulador=v_parametros.id_tipo_simulador;

            --Definicion de la respuesta
            v_resp = pxp.f_agrega_clave(v_resp,'mensaje','Tipo Simulador eliminado(a)');
            v_resp = pxp.f_agrega_clave(v_resp,'id_tipo_simulador',v_parametros.id_tipo_simulador::varchar);

            --Devuelve la respuesta
            return v_resp;

		end;

	else

    	raise exception 'Transaccion inexistente: %',p_transaccion;

	end if;

EXCEPTION

	WHEN OTHERS THEN
		v_resp='';
		v_resp = pxp.f_agrega_clave(v_resp,'mensaje',SQLERRM);
		v_resp = pxp.f_agrega_clave(v_resp,'codigo_error',SQLSTATE);
		v_resp = pxp.f_agrega_clave(v_resp,'procedimientos',v_nombre_funcion);
		raise exception '%',v_resp;

END;
$body$
LANGUAGE 'plpgsql'
VOLATILE
CALLED ON NULL INPUT
SECURITY INVOKER
COST 100;

ALTER FUNCTION oip.ft_tipo_simulador_ime (p_administrador integer, p_id_usuario integer, p_tabla varchar, p_transaccion varchar)
  OWNER TO postgres;