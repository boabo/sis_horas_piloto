CREATE OR REPLACE FUNCTION oip.ft_tipo_simulador_sel (
  p_administrador integer,
  p_id_usuario integer,
  p_tabla varchar,
  p_transaccion varchar
)
RETURNS varchar AS
$body$
/**************************************************************************
 SISTEMA:		Horas Piloto
 FUNCION: 		oip.ft_tipo_simulador_sel
 DESCRIPCION:   Funcion que devuelve conjuntos de registros de las consultas relacionadas con la tabla 'oip.ttipo_simulador'
 AUTOR: 		 (Alan Felipez)
 FECHA:	        24-09-2019 14:13:43
 COMENTARIOS:
***************************************************************************
 HISTORIAL DE MODIFICACIONES:
#ISSUE				FECHA				AUTOR				DESCRIPCION
 #0				24-09-2019 14:13:43								Funcion que devuelve conjuntos de registros de las consultas relacionadas con la tabla 'oip.ttipo_simulador'
 #
 ***************************************************************************/

DECLARE

	v_consulta    		varchar;
	v_parametros  		record;
	v_nombre_funcion   	text;
	v_resp				varchar;

BEGIN

	v_nombre_funcion = 'oip.ft_tipo_simulador_sel';
    v_parametros = pxp.f_get_record(p_tabla);

	/*********************************
 	#TRANSACCION:  'OIP_TIPSIMU_SEL'
 	#DESCRIPCION:	Consulta de datos
 	#AUTOR:		Alan Felipez
 	#FECHA:		24-09-2019 14:13:43
	***********************************/

	if(p_transaccion='OIP_TIPSIMU_SEL')then

    	begin
    		--Sentencia de la consulta
			v_consulta:='select
						tipsimu.id_tipo_simulador,
						tipsimu.estado_reg,
						tipsimu.tipo_simulador,
						tipsimu.costo_hora,
						tipsimu.maximo_horas,
						tipsimu.id_usuario_reg,
						tipsimu.fecha_reg,
						tipsimu.id_usuario_ai,
						tipsimu.usuario_ai,
						tipsimu.id_usuario_mod,
						tipsimu.fecha_mod,
						usu1.cuenta as usr_reg,
						usu2.cuenta as usr_mod
						from oip.ttipo_simulador tipsimu
						inner join segu.tusuario usu1 on usu1.id_usuario = tipsimu.id_usuario_reg
						left join segu.tusuario usu2 on usu2.id_usuario = tipsimu.id_usuario_mod
				        where  ';

			--Definicion de la respuesta
			v_consulta:=v_consulta||v_parametros.filtro;
			v_consulta:=v_consulta||' order by ' ||v_parametros.ordenacion|| ' ' || v_parametros.dir_ordenacion || ' limit ' || v_parametros.cantidad || ' offset ' || v_parametros.puntero;

			--Devuelve la respuesta
			return v_consulta;

		end;

	/*********************************
 	#TRANSACCION:  'OIP_TIPSIMU_CONT'
 	#DESCRIPCION:	Conteo de registros
 	#AUTOR:		Alan Felipez
 	#FECHA:		24-09-2019 14:13:43
	***********************************/

	elsif(p_transaccion='OIP_TIPSIMU_CONT')then

		begin
			--Sentencia de la consulta de conteo de registros
			v_consulta:='select count(id_tipo_simulador)
					    from oip.ttipo_simulador tipsimu
					    inner join segu.tusuario usu1 on usu1.id_usuario = tipsimu.id_usuario_reg
						left join segu.tusuario usu2 on usu2.id_usuario = tipsimu.id_usuario_mod
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
$body$
LANGUAGE 'plpgsql'
VOLATILE
CALLED ON NULL INPUT
SECURITY INVOKER
COST 100;

ALTER FUNCTION oip.ft_tipo_simulador_sel (p_administrador integer, p_id_usuario integer, p_tabla varchar, p_transaccion varchar)
  OWNER TO postgres;