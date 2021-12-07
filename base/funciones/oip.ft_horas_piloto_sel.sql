CREATE OR REPLACE FUNCTION oip.ft_horas_piloto_sel (
  p_administrador integer,
  p_id_usuario integer,
  p_tabla varchar,
  p_transaccion varchar
)
RETURNS varchar AS
$body$
/**************************************************************************
 SISTEMA:		Horas Piloto
 FUNCION: 		oip.ft_horas_piloto_sel
 DESCRIPCION:   Funcion que devuelve conjuntos de registros de las consultas relacionadas con la tabla 'oip.thoras_piloto'
 AUTOR: 		 (breydi.vasquez)
 FECHA:	        20-09-2019 13:43:39
 COMENTARIOS:
***************************************************************************
 HISTORIAL DE MODIFICACIONES:
#ISSUE				FECHA				AUTOR				DESCRIPCION
 #0				20-09-2019 13:43:39								Funcion que devuelve conjuntos de registros de las consultas relacionadas con la tabla 'oip.thoras_piloto'
 #
 ***************************************************************************/

DECLARE

	v_consulta    		varchar;
	v_parametros  		record;
	v_nombre_funcion   	text;
	v_resp				varchar;

BEGIN

	v_nombre_funcion = 'oip.ft_horas_piloto_sel';
    v_parametros = pxp.f_get_record(p_tabla);

	/*********************************
 	#TRANSACCION:  'OIP_HOPILO_SEL'
 	#DESCRIPCION:	Consulta de datos
 	#AUTOR:		breydi.vasquez
 	#FECHA:		20-09-2019 13:43:39
	***********************************/

	if(p_transaccion='OIP_HOPILO_SEL')then

    	begin
    		--Sentencia de la consulta
			v_consulta:='select
						hopilo.id_horas_piloto,
						hopilo.estado_reg,
						ges.gestion,
				        param.f_literal_periodo(per.id_periodo) mes,
						hopilo.ci,
						fun.desc_funcionario1 as nombre_piloto,
                        esc.nombre as escala_salarial,
						hopilo.tipo_flota,
						hopilo.horas_vuelo,
						hopilo.horas_simulador_full,
						hopilo.horas_simulador_fix,
                        hopilo.factor_esfuerzo,
                        hopilo.pago_variable,
                        hopilo.monto_horas_vuelo,
                        hopilo.monto_horas_simulador_full,
                        hopilo.monto_horas_simulador_fix,
						hopilo.estado,
                        hopilo.pic_sic,
                        hopilo.horas_simulador_full_efectivas,
                        hopilo.horas_simulador_fix_efectivas,
						hopilo.id_usuario_reg,
						hopilo.fecha_reg,
						hopilo.id_usuario_ai,
						hopilo.usuario_ai,
						hopilo.id_usuario_mod,
						hopilo.fecha_mod,
						usu1.cuenta as usr_reg,
						usu2.cuenta as usr_mod,
                        hopilo.id_funcionario,
						hopilo.pic_sic_servicio
						from oip.thoras_piloto hopilo
						inner join segu.tusuario usu1 on usu1.id_usuario = hopilo.id_usuario_reg
						left join segu.tusuario usu2 on usu2.id_usuario = hopilo.id_usuario_mod
                        inner join param.tgestion ges on ges.id_gestion = hopilo.gestion
                        inner join param.tperiodo per on per.id_periodo = hopilo.mes
                        inner join orga.vfuncionario fun on fun.id_funcionario = hopilo.id_funcionario
                        inner join orga.tcargo car on car.id_cargo = hopilo.id_cargo
                        inner join orga.ttipo_contrato tc on tc.id_tipo_contrato = car.id_tipo_contrato
                        inner join orga.tescala_salarial esc on esc.id_escala_salarial = car.id_escala_salarial
				        where  ';

			--Definicion de la respuesta
			v_consulta:=v_consulta||v_parametros.filtro;
			v_consulta:=v_consulta||' order by ' ||v_parametros.ordenacion|| ' ' || v_parametros.dir_ordenacion || ' limit ' || v_parametros.cantidad || ' offset ' || v_parametros.puntero;

			--Devuelve la respuesta
			return v_consulta;

		end;

	/*********************************
 	#TRANSACCION:  'OIP_HOPILO_CONT'
 	#DESCRIPCION:	Conteo de registros
 	#AUTOR:		breydi.vasquez
 	#FECHA:		20-09-2019 13:43:39
	***********************************/

	elsif(p_transaccion='OIP_HOPILO_CONT')then

		begin
			--Sentencia de la consulta de conteo de registros
			v_consulta:='select count(id_horas_piloto),
            					sum(pago_variable) as total_pago_variable
					    from oip.thoras_piloto hopilo
					    inner join segu.tusuario usu1 on usu1.id_usuario = hopilo.id_usuario_reg
						left join segu.tusuario usu2 on usu2.id_usuario = hopilo.id_usuario_mod
                        inner join param.tgestion ges on ges.id_gestion = hopilo.gestion
                        inner join param.tperiodo per on per.id_periodo = hopilo.mes
                        inner join orga.vfuncionario fun on fun.id_funcionario = hopilo.id_funcionario
                        inner join orga.tcargo car on car.id_cargo = hopilo.id_cargo
					              inner join orga.ttipo_contrato tc on tc.id_tipo_contrato = car.id_tipo_contrato
                        inner join orga.tescala_salarial esc on esc.id_escala_salarial = car.id_escala_salarial
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

ALTER FUNCTION oip.ft_horas_piloto_sel (p_administrador integer, p_id_usuario integer, p_tabla varchar, p_transaccion varchar)
  OWNER TO postgres;
