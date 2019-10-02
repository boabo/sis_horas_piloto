CREATE OR REPLACE FUNCTION oip.ft_archivo_horas_piloto_sel (
  p_administrador integer,
  p_id_usuario integer,
  p_tabla varchar,
  p_transaccion varchar
)
RETURNS varchar AS
$body$
/**************************************************************************
 SISTEMA:		Horas Piloto
 FUNCION: 		oip.ft_archivo_horas_piloto_sel
 DESCRIPCION:   Funcion que devuelve conjuntos de registros de las consultas relacionadas con la tabla 'oip.tarchivo_horas_piloto'
 AUTOR: 		 (breydi.vasquez)
 FECHA:	        20-09-2019 13:42:10
 COMENTARIOS:	
***************************************************************************
 HISTORIAL DE MODIFICACIONES:
#ISSUE				FECHA				AUTOR				DESCRIPCION
 #0				20-09-2019 13:42:10								Funcion que devuelve conjuntos de registros de las consultas relacionadas con la tabla 'oip.tarchivo_horas_piloto'	
 #
 ***************************************************************************/

DECLARE

	v_consulta    		varchar;
	v_parametros  		record;
	v_nombre_funcion   	text;
	v_resp				varchar;
			    
BEGIN

	v_nombre_funcion = 'oip.ft_archivo_horas_piloto_sel';
    v_parametros = pxp.f_get_record(p_tabla);

	/*********************************    
 	#TRANSACCION:  'OIP_ARHOPI_SEL'
 	#DESCRIPCION:	Consulta de datos
 	#AUTOR:		breydi.vasquez	
 	#FECHA:		20-09-2019 13:42:10
	***********************************/

	if(p_transaccion='OIP_ARHOPI_SEL')then
     				
    	begin
    		--Sentencia de la consulta
			v_consulta:='select
						arhopi.id_archivo_horas_piloto,
						arhopi.estado_reg,
						arhopi.id_gestion,
						arhopi.id_periodo,
						arhopi.nombre,
						arhopi.estado,
                        ges.gestion,
                        param.f_literal_periodo(per.id_periodo)  as literal,
                        arhopi.archivo,
                        arhopi.pago_total,
						arhopi.id_usuario_reg,
						arhopi.fecha_reg,
						arhopi.id_usuario_ai,
						arhopi.usuario_ai,
						arhopi.id_usuario_mod,
						arhopi.fecha_mod,
						usu1.cuenta as usr_reg,
						usu2.cuenta as usr_mod	
						from oip.tarchivo_horas_piloto arhopi
						inner join segu.tusuario usu1 on usu1.id_usuario = arhopi.id_usuario_reg
						left join segu.tusuario usu2 on usu2.id_usuario = arhopi.id_usuario_mod
                        inner join param.tgestion ges on ges.id_gestion = arhopi.id_gestion
                        inner join param.tperiodo per on per.id_periodo  = arhopi.id_periodo
				        where  ';
			
			--Definicion de la respuesta
			v_consulta:=v_consulta||v_parametros.filtro;
			v_consulta:=v_consulta||' order by ' ||v_parametros.ordenacion|| ' ' || v_parametros.dir_ordenacion || ' limit ' || v_parametros.cantidad || ' offset ' || v_parametros.puntero;

			--Devuelve la respuesta
			return v_consulta;
						
		end;

	/*********************************    
 	#TRANSACCION:  'OIP_ARHOPI_CONT'
 	#DESCRIPCION:	Conteo de registros
 	#AUTOR:		breydi.vasquez	
 	#FECHA:		20-09-2019 13:42:10
	***********************************/

	elsif(p_transaccion='OIP_ARHOPI_CONT')then

		begin
			--Sentencia de la consulta de conteo de registros
			v_consulta:='select count(id_archivo_horas_piloto)
					    from oip.tarchivo_horas_piloto arhopi
					    inner join segu.tusuario usu1 on usu1.id_usuario = arhopi.id_usuario_reg
						left join segu.tusuario usu2 on usu2.id_usuario = arhopi.id_usuario_mod
                        inner join param.tgestion ges on ges.id_gestion = arhopi.id_gestion
                        inner join param.tperiodo per on per.id_periodo  = arhopi.id_periodo                        
					    where ';
			
			--Definicion de la respuesta		    
			v_consulta:=v_consulta||v_parametros.filtro;

			--Devuelve la respuesta
			return v_consulta;

		end;
        
	/*********************************    
 	#TRANSACCION:  'OIP_REPPILO_SEL'
 	#DESCRIPCION:	Reporte Pago Variable
 	#AUTOR:		breydi.vasquez	
 	#FECHA:		
	***********************************/

	elsif(p_transaccion='OIP_REPPILO_SEL')then

		begin

			--Sentencia de la consulta de conteo de registros
			v_consulta:='select
                          arhopi.nombre,
                          ges.gestion,
                          upper(param.f_literal_periodo(arhopi.id_periodo))::varchar as periodo,
                          arhopi.pago_total,
                          hopi.nombre_piloto,
                          esc.nombre as escala_salarial,
                          hopi.ci,
                          case when hopi.pic_sic = ''PIC'' then
                          	''PILOTO''::varchar
                          else ''COPILOTO''::varchar end as pic_sic,
                          hopi.horas_vuelo,
                          hopi.horas_simulador_full,
                          hopi.horas_simulador_fix,
                          hopi.horas_simulador_full_efectivas,
                          hopi.horas_simulador_fix_efectivas,
                          hopi.pago_variable,
                          hopi.factor_esfuerzo,
                          hopi.monto_horas_vuelo,
                          hopi.monto_horas_simulador_full,
                          hopi.monto_horas_simulador_fix
                    from oip.tarchivo_horas_piloto arhopi
                    inner join oip.thoras_piloto hopi on hopi.id_archivo_horas_piloto = arhopi.id_archivo_horas_piloto
                    inner join param.tgestion ges on ges.id_gestion = arhopi.id_gestion
                    inner join orga.tcargo car on car.id_cargo = hopi.id_cargo
                    inner join orga.tescala_salarial esc on esc.tescala_salarial = car.tescala_salarial
                    where cat.codigo = ''SUPER'' and ';
			
			--Definicion de la respuesta		    
			v_consulta:=v_consulta||v_parametros.filtro;
            v_consulta:=v_consulta||' order by hopi.nombre_piloto asc';
			raise notice '%',v_consulta;
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

ALTER FUNCTION oip.ft_archivo_horas_piloto_sel (p_administrador integer, p_id_usuario integer, p_tabla varchar, p_transaccion varchar)
  OWNER TO postgres;