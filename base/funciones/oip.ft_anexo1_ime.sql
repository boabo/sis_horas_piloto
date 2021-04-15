CREATE OR REPLACE FUNCTION oip.ft_anexo1_ime (
  p_administrador integer,
  p_id_usuario integer,
  p_tabla varchar,
  p_transaccion varchar
)
RETURNS varchar AS
$body$
/**************************************************************************
 SISTEMA:		Otros Ingresos Pilotos
 FUNCION: 		oip.ft_anexo1_ime
 DESCRIPCION:   Funcion que gestiona las operaciones basicas (inserciones, modificaciones, eliminaciones de la tabla 'oip.tanexo1'
 AUTOR: 		 (Alan Felipez)
 FECHA:	        26-09-2019 12:54:57
 COMENTARIOS:
***************************************************************************
 HISTORIAL DE MODIFICACIONES:
#ISSUE				FECHA				AUTOR				DESCRIPCION
 #0				26-09-2019 12:54:57								Funcion que gestiona las operaciones basicas (inserciones, modificaciones, eliminaciones de la tabla 'oip.tanexo1'
 #
 ***************************************************************************/

DECLARE

	v_nro_requerimiento    	integer;
	v_parametros           	record;
	v_id_requerimiento     	integer;
	v_resp		            varchar;
	v_nombre_funcion        text;
	v_mensaje_error         text;
	v_id_anexo1	integer;

BEGIN

    v_nombre_funcion = 'oip.ft_anexo1_ime';
    v_parametros = pxp.f_get_record(p_tabla);

	/*********************************
 	#TRANSACCION:  'OIP_TIPANE1_INS'
 	#DESCRIPCION:	Insercion de registros
 	#AUTOR:		admin
 	#FECHA:		26-09-2019 12:54:57
	***********************************/

	if(p_transaccion='OIP_TIPANE1_INS')then

        begin
        	--Sentencia de la insercion
        	insert into oip.tanexo1(
			estado_reg,
			id_escala_salarial,
			numero_casos,
			remuneracion_basica,
			remuneracion_maxima,
			tipo_flota,
			pic_sic,
			id_usuario_reg,
			fecha_reg,
			id_usuario_ai,
			usuario_ai,
			id_usuario_mod,
			fecha_mod,
      fecha_ini
          	) values(
			'activo',
			v_parametros.id_escala_salarial,
			v_parametros.numero_casos,
			v_parametros.remuneracion_basica,
			v_parametros.remuneracion_maxima,
			v_parametros.tipo_flota,
			v_parametros.pic_sic,
			p_id_usuario,
			now(),
			v_parametros._id_usuario_ai,
			v_parametros._nombre_usuario_ai,
			null,
			null,
      v_parametros.fecha_ini


			)RETURNING id_anexo1 into v_id_anexo1;

			--Definicion de la respuesta
			v_resp = pxp.f_agrega_clave(v_resp,'mensaje','Tipo Anexo1 almacenado(a) con exito (id_anexo1'||v_id_anexo1||')');
            v_resp = pxp.f_agrega_clave(v_resp,'id_anexo1',v_id_anexo1::varchar);

            --Devuelve la respuesta
            return v_resp;

		end;

	/*********************************
 	#TRANSACCION:  'OIP_TIPANE1_MOD'
 	#DESCRIPCION:	Modificacion de registros
 	#AUTOR:		Alan Felipez
 	#FECHA:		26-09-2019 12:54:57
	***********************************/

	elsif(p_transaccion='OIP_TIPANE1_MOD')then

		begin
			--Sentencia de la modificacion
			update oip.tanexo1 set
			id_escala_salarial = v_parametros.id_escala_salarial,
			numero_casos = v_parametros.numero_casos,
			remuneracion_basica = v_parametros.remuneracion_basica,
			remuneracion_maxima = v_parametros.remuneracion_maxima,
			tipo_flota = v_parametros.tipo_flota,
			pic_sic = v_parametros.pic_sic,
			id_usuario_mod = p_id_usuario,
			fecha_mod = now(),
			id_usuario_ai = v_parametros._id_usuario_ai,
			usuario_ai = v_parametros._nombre_usuario_ai,
      fecha_ini = v_parametros.fecha_ini,
      fecha_fin = v_parametros.fecha_fin
			where id_anexo1=v_parametros.id_anexo1;

			--Definicion de la respuesta
            v_resp = pxp.f_agrega_clave(v_resp,'mensaje','Tipo Anexo1 modificado(a)');
            v_resp = pxp.f_agrega_clave(v_resp,'id_anexo1',v_parametros.id_anexo1::varchar);

            --Devuelve la respuesta
            return v_resp;

		end;

	/*********************************
 	#TRANSACCION:  'OIP_TIPANE1_ELI'
 	#DESCRIPCION:	Eliminacion de registros
 	#AUTOR:		Alan Felipez
 	#FECHA:		26-09-2019 12:54:57
	***********************************/

	elsif(p_transaccion='OIP_TIPANE1_ELI')then

		begin
			--Sentencia de la eliminacion
			delete from oip.tanexo1
            where id_anexo1=v_parametros.id_anexo1;

            --Definicion de la respuesta
            v_resp = pxp.f_agrega_clave(v_resp,'mensaje','Tipo Anexo1 eliminado(a)');
            v_resp = pxp.f_agrega_clave(v_resp,'id_anexo1',v_parametros.id_anexo1::varchar);

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

ALTER FUNCTION oip.ft_anexo1_ime (p_administrador integer, p_id_usuario integer, p_tabla varchar, p_transaccion varchar)
  OWNER TO postgres;
