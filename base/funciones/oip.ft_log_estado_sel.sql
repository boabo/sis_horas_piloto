CREATE OR REPLACE FUNCTION "oip"."ft_log_estado_sel"(	
				p_administrador integer, p_id_usuario integer, p_tabla character varying, p_transaccion character varying)
RETURNS character varying AS
$BODY$
/**************************************************************************
 SISTEMA:		Otros Ingresos Pilotos
 FUNCION: 		oip.ft_log_estado_sel
 DESCRIPCION:   Funcion que devuelve conjuntos de registros de las consultas relacionadas con la tabla 'oip.tlog_estado'
 AUTOR: 		 (breydi.vasquez)
 FECHA:	        26-09-2019 19:30:21
 COMENTARIOS:	
***************************************************************************
 HISTORIAL DE MODIFICACIONES:
#ISSUE				FECHA				AUTOR				DESCRIPCION
 #0				26-09-2019 19:30:21								Funcion que devuelve conjuntos de registros de las consultas relacionadas con la tabla 'oip.tlog_estado'	
 #
 ***************************************************************************/

DECLARE

	v_consulta    		varchar;
	v_parametros  		record;
	v_nombre_funcion   	text;
	v_resp				varchar;
			    
BEGIN

	v_nombre_funcion = 'oip.ft_log_estado_sel';
    v_parametros = pxp.f_get_record(p_tabla);

	/*********************************    
 	#TRANSACCION:  'OIP_OIPLOG_SEL'
 	#DESCRIPCION:	Consulta de datos
 	#AUTOR:		breydi.vasquez	
 	#FECHA:		26-09-2019 19:30:21
	***********************************/

	if(p_transaccion='OIP_OIPLOG_SEL')then
     				
    	begin
    		--Sentencia de la consulta
			v_consulta:='select
						oiplog.id_log_estado,
						oiplog.estado_reg,
						oiplog.id_archivo_horas_piloto,
						oiplog.accion,
						oiplog.detalle,
						oiplog.estado,						
						oiplog.id_usuario_reg,
						oiplog.fecha_reg,
						oiplog.id_usuario_ai,
						oiplog.usuario_ai,
						oiplog.id_usuario_mod,
						oiplog.fecha_mod,
						usu1.cuenta as usr_reg,
						usu2.cuenta as usr_mod	
						from oip.tlog_estado oiplog
						inner join segu.tusuario usu1 on usu1.id_usuario = oiplog.id_usuario_reg
						left join segu.tusuario usu2 on usu2.id_usuario = oiplog.id_usuario_mod
				        where  ';
			
			--Definicion de la respuesta
			v_consulta:=v_consulta||v_parametros.filtro;
			v_consulta:=v_consulta||' order by ' ||v_parametros.ordenacion|| ' ' || v_parametros.dir_ordenacion || ' limit ' || v_parametros.cantidad || ' offset ' || v_parametros.puntero;

			--Devuelve la respuesta
			return v_consulta;
						
		end;

	/*********************************    
 	#TRANSACCION:  'OIP_OIPLOG_CONT'
 	#DESCRIPCION:	Conteo de registros
 	#AUTOR:		breydi.vasquez	
 	#FECHA:		26-09-2019 19:30:21
	***********************************/

	elsif(p_transaccion='OIP_OIPLOG_CONT')then

		begin
			--Sentencia de la consulta de conteo de registros
			v_consulta:='select count(id_log_estado)
					    from oip.tlog_estado oiplog
					    inner join segu.tusuario usu1 on usu1.id_usuario = oiplog.id_usuario_reg
						left join segu.tusuario usu2 on usu2.id_usuario = oiplog.id_usuario_mod
					    where ';
			
			--Definicion de la respuesta		    
			v_consulta:=v_consulta||v_parametros.filtro;

			--Devuelve la respuesta
			return v_consulta;

		end;
					
	else
					     
		raise exception 'Transaccion inexistente';
					         
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
ALTER FUNCTION "oip"."ft_log_estado_sel"(integer, integer, character varying, character varying) OWNER TO postgres;
