CREATE OR REPLACE FUNCTION oip.ft_anexo1_sel (
  p_administrador integer,
  p_id_usuario integer,
  p_tabla varchar,
  p_transaccion varchar
)
RETURNS varchar AS
$body$
/**************************************************************************
 SISTEMA:		Otros Ingresos Pilotos
 FUNCION: 		oip.ft_anexo1_sel
 DESCRIPCION:   Funcion que devuelve conjuntos de registros de las consultas relacionadas con la tabla 'oip.tanexo1'
 AUTOR: 		 (Alan Felipez)
 FECHA:	        26-09-2019 12:54:57
 COMENTARIOS:
***************************************************************************
 HISTORIAL DE MODIFICACIONES:
#ISSUE				FECHA				AUTOR				DESCRIPCION
 #0				26-09-2019 12:54:57								Funcion que devuelve conjuntos de registros de las consultas relacionadas con la tabla 'oip.tanexo1'
 #
 ***************************************************************************/

DECLARE

	v_consulta    		varchar;
	v_parametros  		record;
	v_nombre_funcion   	text;
	v_resp				varchar;

BEGIN

	v_nombre_funcion = 'oip.ft_anexo1_sel';
    v_parametros = pxp.f_get_record(p_tabla);

	/*********************************
 	#TRANSACCION:  'OIP_TIPANE1_SEL'
 	#DESCRIPCION:	Consulta de datos
 	#AUTOR:		Alan Felipez
 	#FECHA:		26-09-2019 12:54:57
	***********************************/

	if(p_transaccion='OIP_TIPANE1_SEL')then

    	begin
    		--Sentencia de la consulta
			v_consulta:='select
						tipane1.id_anexo1,
						tipane1.estado_reg,
						tipane1.id_escala_salarial,
						tipane1.numero_casos,
						tipane1.remuneracion_basica,
						tipane1.remuneracion_maxima,
						tipane1.tipo_flota,
						tipane1.pic_sic,
						tipane1.id_usuario_reg,
						tipane1.fecha_reg,
						tipane1.id_usuario_ai,
						tipane1.usuario_ai,
						tipane1.id_usuario_mod,
						tipane1.fecha_mod,
						usu1.cuenta as usr_reg,
						usu2.cuenta as usr_mod,
                        escsal.nombre as desc_nombre_salarial
						from oip.tanexo1 tipane1
						inner join segu.tusuario usu1 on usu1.id_usuario = tipane1.id_usuario_reg
						left join segu.tusuario usu2 on usu2.id_usuario = tipane1.id_usuario_mod
                        join orga.tescala_salarial escsal on tipane1.id_escala_salarial = escsal.id_escala_salarial
				        where  ';

			--Definicion de la respuesta
			v_consulta:=v_consulta||v_parametros.filtro;
			v_consulta:=v_consulta||' order by ' ||v_parametros.ordenacion|| ' ' || v_parametros.dir_ordenacion || ' limit ' || v_parametros.cantidad || ' offset ' || v_parametros.puntero;

			--Devuelve la respuesta
			return v_consulta;

		end;

	/*********************************
 	#TRANSACCION:  'OIP_TIPANE1_CONT'
 	#DESCRIPCION:	Conteo de registros
 	#AUTOR:		Alan Felipez
 	#FECHA:		26-09-2019 12:54:57
	***********************************/

	elsif(p_transaccion='OIP_TIPANE1_CONT')then

		begin
			--Sentencia de la consulta de conteo de registros
			v_consulta:='select count(id_anexo1)
					    from oip.tanexo1 tipane1
					    inner join segu.tusuario usu1 on usu1.id_usuario = tipane1.id_usuario_reg
						left join segu.tusuario usu2 on usu2.id_usuario = tipane1.id_usuario_mod
                        join orga.tescala_salarial escsal on tipane1.id_escala_salarial = escsal.id_escala_salarial
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

ALTER FUNCTION oip.ft_anexo1_sel (p_administrador integer, p_id_usuario integer, p_tabla varchar, p_transaccion varchar)
  OWNER TO postgres;