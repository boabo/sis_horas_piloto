CREATE OR REPLACE FUNCTION "oip"."ft_log_estado_ime" (	
				p_administrador integer, p_id_usuario integer, p_tabla character varying, p_transaccion character varying)
RETURNS character varying AS
$BODY$

/**************************************************************************
 SISTEMA:		Otros Ingresos Pilotos
 FUNCION: 		oip.ft_log_estado_ime
 DESCRIPCION:   Funcion que gestiona las operaciones basicas (inserciones, modificaciones, eliminaciones de la tabla 'oip.tlog_estado'
 AUTOR: 		 (breydi.vasquez)
 FECHA:	        26-09-2019 19:30:21
 COMENTARIOS:	
***************************************************************************
 HISTORIAL DE MODIFICACIONES:
#ISSUE				FECHA				AUTOR				DESCRIPCION
 #0				26-09-2019 19:30:21								Funcion que gestiona las operaciones basicas (inserciones, modificaciones, eliminaciones de la tabla 'oip.tlog_estado'	
 #
 ***************************************************************************/

DECLARE

	v_nro_requerimiento    	integer;
	v_parametros           	record;
	v_id_requerimiento     	integer;
	v_resp		            varchar;
	v_nombre_funcion        text;
	v_mensaje_error         text;
	v_id_log_estado	integer;
			    
BEGIN

    v_nombre_funcion = 'oip.ft_log_estado_ime';
    v_parametros = pxp.f_get_record(p_tabla);

	/*********************************    
 	#TRANSACCION:  'OIP_OIPLOG_INS'
 	#DESCRIPCION:	Insercion de registros
 	#AUTOR:		breydi.vasquez	
 	#FECHA:		26-09-2019 19:30:21
	***********************************/

	if(p_transaccion='OIP_OIPLOG_INS')then
					
        begin
        	--Sentencia de la insercion
        	insert into oip.tlog_estado(
			estado_reg,
			id_archivo_horas_piloto,
			accion,			
			estado,
			nro_modificacion,
			id_usuario_reg,
			fecha_reg,
			id_usuario_ai,
			usuario_ai,
			id_usuario_mod,
			fecha_mod
          	) values(
			'activo',
			v_parametros.id_archivo_horas_piloto,
			v_parametros.accion,			
			v_parametros.estado,
			v_parametros.nro_modificacion,
			p_id_usuario,
			now(),
			v_parametros._id_usuario_ai,
			v_parametros._nombre_usuario_ai,
			null,
			null
							
			
			
			)RETURNING id_log_estado into v_id_log_estado;
			
			--Definicion de la respuesta
			v_resp = pxp.f_agrega_clave(v_resp,'mensaje','Logs estados almacenado(a) con exito (id_log_estado'||v_id_log_estado||')'); 
            v_resp = pxp.f_agrega_clave(v_resp,'id_log_estado',v_id_log_estado::varchar);

            --Devuelve la respuesta
            return v_resp;

		end;

	/*********************************    
 	#TRANSACCION:  'OIP_OIPLOG_MOD'
 	#DESCRIPCION:	Modificacion de registros
 	#AUTOR:		breydi.vasquez	
 	#FECHA:		26-09-2019 19:30:21
	***********************************/

	elsif(p_transaccion='OIP_OIPLOG_MOD')then

		begin
			--Sentencia de la modificacion
			update oip.tlog_estado set
			id_archivo_horas_piloto = v_parametros.id_archivo_horas_piloto,
			accion = v_parametros.accion,
			columnas_afectadas = v_parametros.columnas_afectadas,
			estado = v_parametros.estado,
			nro_modificacion = v_parametros.nro_modificacion,
			id_usuario_mod = p_id_usuario,
			fecha_mod = now(),
			id_usuario_ai = v_parametros._id_usuario_ai,
			usuario_ai = v_parametros._nombre_usuario_ai
			where id_log_estado=v_parametros.id_log_estado;
               
			--Definicion de la respuesta
            v_resp = pxp.f_agrega_clave(v_resp,'mensaje','Logs estados modificado(a)'); 
            v_resp = pxp.f_agrega_clave(v_resp,'id_log_estado',v_parametros.id_log_estado::varchar);
               
            --Devuelve la respuesta
            return v_resp;
            
		end;

	/*********************************    
 	#TRANSACCION:  'OIP_OIPLOG_ELI'
 	#DESCRIPCION:	Eliminacion de registros
 	#AUTOR:		breydi.vasquez	
 	#FECHA:		26-09-2019 19:30:21
	***********************************/

	elsif(p_transaccion='OIP_OIPLOG_ELI')then

		begin
			--Sentencia de la eliminacion
			delete from oip.tlog_estado
            where id_log_estado=v_parametros.id_log_estado;
               
            --Definicion de la respuesta
            v_resp = pxp.f_agrega_clave(v_resp,'mensaje','Logs estados eliminado(a)'); 
            v_resp = pxp.f_agrega_clave(v_resp,'id_log_estado',v_parametros.id_log_estado::varchar);
              
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
$BODY$
LANGUAGE 'plpgsql' VOLATILE
COST 100;
ALTER FUNCTION "oip"."ft_log_estado_ime"(integer, integer, character varying, character varying) OWNER TO postgres;
