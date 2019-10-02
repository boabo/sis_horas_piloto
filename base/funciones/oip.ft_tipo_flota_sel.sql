CREATE OR REPLACE FUNCTION "oip"."ft_tipo_flota_sel"(	
				p_administrador integer, p_id_usuario integer, p_tabla character varying, p_transaccion character varying)
RETURNS character varying AS
$BODY$
/**************************************************************************
 SISTEMA:		Otros Ingresos Pilotos
 FUNCION: 		oip.ft_tipo_flota_sel
 DESCRIPCION:   Funcion que devuelve conjuntos de registros de las consultas relacionadas con la tabla 'oip.ttipo_flota'
 AUTOR: 		 (admin)
 FECHA:	        26-09-2019 13:05:35
 COMENTARIOS:	
***************************************************************************
 HISTORIAL DE MODIFICACIONES:
#ISSUE				FECHA				AUTOR				DESCRIPCION
 #0				26-09-2019 13:05:35								Funcion que devuelve conjuntos de registros de las consultas relacionadas con la tabla 'oip.ttipo_flota'	
 #
 ***************************************************************************/

DECLARE

	v_consulta    		varchar;
	v_parametros  		record;
	v_nombre_funcion   	text;
	v_resp				varchar;
			    
BEGIN

	v_nombre_funcion = 'oip.ft_tipo_flota_sel';
    v_parametros = pxp.f_get_record(p_tabla);

	/*********************************    
 	#TRANSACCION:  'OIP_TIPFLO_SEL'
 	#DESCRIPCION:	Consulta de datos
 	#AUTOR:		admin	
 	#FECHA:		26-09-2019 13:05:35
	***********************************/

	if(p_transaccion='OIP_TIPFLO_SEL')then
     				
    	begin
    		--Sentencia de la consulta
			v_consulta:='select
						tipflo.id_tipo_flota,
						tipflo.estado_reg,
						tipflo.tipo_flota,
						tipflo.costo_hora_base_pic,
						tipflo.costo_hora_base_sic,
						tipflo.horas_base,
						tipflo.relacion_ciclo_hora,
						tipflo.maximo_horas,
						tipflo.id_usuario_reg,
						tipflo.fecha_reg,
						tipflo.id_usuario_ai,
						tipflo.usuario_ai,
						tipflo.id_usuario_mod,
						tipflo.fecha_mod,
						usu1.cuenta as usr_reg,
						usu2.cuenta as usr_mod	
						from oip.ttipo_flota tipflo
						inner join segu.tusuario usu1 on usu1.id_usuario = tipflo.id_usuario_reg
						left join segu.tusuario usu2 on usu2.id_usuario = tipflo.id_usuario_mod
				        where  ';
			
			--Definicion de la respuesta
			v_consulta:=v_consulta||v_parametros.filtro;
			v_consulta:=v_consulta||' order by ' ||v_parametros.ordenacion|| ' ' || v_parametros.dir_ordenacion || ' limit ' || v_parametros.cantidad || ' offset ' || v_parametros.puntero;

			--Devuelve la respuesta
			return v_consulta;
						
		end;

	/*********************************    
 	#TRANSACCION:  'OIP_TIPFLO_CONT'
 	#DESCRIPCION:	Conteo de registros
 	#AUTOR:		admin	
 	#FECHA:		26-09-2019 13:05:35
	***********************************/

	elsif(p_transaccion='OIP_TIPFLO_CONT')then

		begin
			--Sentencia de la consulta de conteo de registros
			v_consulta:='select count(id_tipo_flota)
					    from oip.ttipo_flota tipflo
					    inner join segu.tusuario usu1 on usu1.id_usuario = tipflo.id_usuario_reg
						left join segu.tusuario usu2 on usu2.id_usuario = tipflo.id_usuario_mod
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
ALTER FUNCTION "oip"."ft_tipo_flota_sel"(integer, integer, character varying, character varying) OWNER TO postgres;
