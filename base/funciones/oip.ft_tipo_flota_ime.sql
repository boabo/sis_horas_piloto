CREATE OR REPLACE FUNCTION "oip"."ft_tipo_flota_ime" (	
				p_administrador integer, p_id_usuario integer, p_tabla character varying, p_transaccion character varying)
RETURNS character varying AS
$BODY$

/**************************************************************************
 SISTEMA:		Otros Ingresos Pilotos
 FUNCION: 		oip.ft_tipo_flota_ime
 DESCRIPCION:   Funcion que gestiona las operaciones basicas (inserciones, modificaciones, eliminaciones de la tabla 'oip.ttipo_flota'
 AUTOR: 		 (admin)
 FECHA:	        26-09-2019 13:05:35
 COMENTARIOS:	
***************************************************************************
 HISTORIAL DE MODIFICACIONES:
#ISSUE				FECHA				AUTOR				DESCRIPCION
 #0				26-09-2019 13:05:35								Funcion que gestiona las operaciones basicas (inserciones, modificaciones, eliminaciones de la tabla 'oip.ttipo_flota'	
 #
 ***************************************************************************/

DECLARE

	v_nro_requerimiento    	integer;
	v_parametros           	record;
	v_id_requerimiento     	integer;
	v_resp		            varchar;
	v_nombre_funcion        text;
	v_mensaje_error         text;
	v_id_tipo_flota	integer;
			    
BEGIN

    v_nombre_funcion = 'oip.ft_tipo_flota_ime';
    v_parametros = pxp.f_get_record(p_tabla);

	/*********************************    
 	#TRANSACCION:  'OIP_TIPFLO_INS'
 	#DESCRIPCION:	Insercion de registros
 	#AUTOR:		admin	
 	#FECHA:		26-09-2019 13:05:35
	***********************************/

	if(p_transaccion='OIP_TIPFLO_INS')then
					
        begin
        	--Sentencia de la insercion
        	insert into oip.ttipo_flota(
			estado_reg,
			tipo_flota,
			costo_hora_base_pic,
			costo_hora_base_sic,
			horas_base,
			relacion_ciclo_hora,
			maximo_horas,
			id_usuario_reg,
			fecha_reg,
			id_usuario_ai,
			usuario_ai,
			id_usuario_mod,
			fecha_mod
          	) values(
			'activo',
			v_parametros.tipo_flota,
			v_parametros.costo_hora_base_pic,
			v_parametros.costo_hora_base_sic,
			v_parametros.horas_base,
			v_parametros.relacion_ciclo_hora,
			v_parametros.maximo_horas,
			p_id_usuario,
			now(),
			v_parametros._id_usuario_ai,
			v_parametros._nombre_usuario_ai,
			null,
			null
							
			
			
			)RETURNING id_tipo_flota into v_id_tipo_flota;
			
			--Definicion de la respuesta
			v_resp = pxp.f_agrega_clave(v_resp,'mensaje','Tipo Flota almacenado(a) con exito (id_tipo_flota'||v_id_tipo_flota||')'); 
            v_resp = pxp.f_agrega_clave(v_resp,'id_tipo_flota',v_id_tipo_flota::varchar);

            --Devuelve la respuesta
            return v_resp;

		end;

	/*********************************    
 	#TRANSACCION:  'OIP_TIPFLO_MOD'
 	#DESCRIPCION:	Modificacion de registros
 	#AUTOR:		admin	
 	#FECHA:		26-09-2019 13:05:35
	***********************************/

	elsif(p_transaccion='OIP_TIPFLO_MOD')then

		begin
			--Sentencia de la modificacion
			update oip.ttipo_flota set
			tipo_flota = v_parametros.tipo_flota,
			costo_hora_base_pic = v_parametros.costo_hora_base_pic,
			costo_hora_base_sic = v_parametros.costo_hora_base_sic,
			horas_base = v_parametros.horas_base,
			relacion_ciclo_hora = v_parametros.relacion_ciclo_hora,
			maximo_horas = v_parametros.maximo_horas,
			id_usuario_mod = p_id_usuario,
			fecha_mod = now(),
			id_usuario_ai = v_parametros._id_usuario_ai,
			usuario_ai = v_parametros._nombre_usuario_ai
			where id_tipo_flota=v_parametros.id_tipo_flota;
               
			--Definicion de la respuesta
            v_resp = pxp.f_agrega_clave(v_resp,'mensaje','Tipo Flota modificado(a)'); 
            v_resp = pxp.f_agrega_clave(v_resp,'id_tipo_flota',v_parametros.id_tipo_flota::varchar);
               
            --Devuelve la respuesta
            return v_resp;
            
		end;

	/*********************************    
 	#TRANSACCION:  'OIP_TIPFLO_ELI'
 	#DESCRIPCION:	Eliminacion de registros
 	#AUTOR:		admin	
 	#FECHA:		26-09-2019 13:05:35
	***********************************/

	elsif(p_transaccion='OIP_TIPFLO_ELI')then

		begin
			--Sentencia de la eliminacion
			delete from oip.ttipo_flota
            where id_tipo_flota=v_parametros.id_tipo_flota;
               
            --Definicion de la respuesta
            v_resp = pxp.f_agrega_clave(v_resp,'mensaje','Tipo Flota eliminado(a)'); 
            v_resp = pxp.f_agrega_clave(v_resp,'id_tipo_flota',v_parametros.id_tipo_flota::varchar);
              
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
ALTER FUNCTION "oip"."ft_tipo_flota_ime"(integer, integer, character varying, character varying) OWNER TO postgres;
