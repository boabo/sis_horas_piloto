CREATE OR REPLACE FUNCTION oip.ft_archivo_horas_piloto_ime (
  p_administrador integer,
  p_id_usuario integer,
  p_tabla varchar,
  p_transaccion varchar
)
RETURNS varchar AS
$body$
/**************************************************************************
 SISTEMA:		Horas Piloto
 FUNCION: 		oip.ft_archivo_horas_piloto_ime
 DESCRIPCION:   Funcion que gestiona las operaciones basicas (inserciones, modificaciones, eliminaciones de la tabla 'oip.tarchivo_horas_piloto'
 AUTOR: 		 (breydi.vasquez)
 FECHA:	        20-09-2019 13:42:10
 COMENTARIOS:	
***************************************************************************
 HISTORIAL DE MODIFICACIONES:
#ISSUE				FECHA				AUTOR				DESCRIPCION
 #0				20-09-2019 13:42:10								Funcion que gestiona las operaciones basicas (inserciones, modificaciones, eliminaciones de la tabla 'oip.tarchivo_horas_piloto'	
 #
 ***************************************************************************/

DECLARE

	v_nro_requerimiento    			integer;
	v_parametros           			record;
	v_id_requerimiento     			integer;
	v_resp		            		varchar;
	v_nombre_funcion        		text;
	v_mensaje_error         		text;
	v_id_archivo_horas_piloto		integer;
    v_rec							record;
    v_id_gestion					integer;
    v_id_periodo					integer;
    v_id_horas_piloto				integer;
    v_registros_json				record;    
    v_json							varchar;
    v_id_funcionario				integer;
    v_tipo_flota					varchar;
    v_horas_vuelo					integer;
    v_cargo							varchar;
    v_values						varchar;
    v_fun_inactivo					varchar;
    v_gestion						integer;
    v_periodo						integer;
    v_count							integer;
	v_gestion_pago					record;		    
	v_rec_esc    	    			record;
	v_real_tipo_flota    		    varchar;    
BEGIN

    v_nombre_funcion = 'oip.ft_archivo_horas_piloto_ime';
    v_parametros = pxp.f_get_record(p_tabla);

	/*********************************    
 	#TRANSACCION:  'OIP_ARHOPI_INS'
 	#DESCRIPCION:	Insercion de registros
 	#AUTOR:		breydi.vasquez	
 	#FECHA:		20-09-2019 13:42:10
	***********************************/

	if(p_transaccion='OIP_ARHOPI_INS')then
					
        begin
                
        	--Sentencia de la insercion
        	insert into oip.tarchivo_horas_piloto(
			estado_reg,
			id_gestion,
			id_periodo,
			nombre,
			estado,
			id_usuario_reg,
			fecha_reg,
			id_usuario_ai,
			usuario_ai,
			id_usuario_mod,
			fecha_mod
          	) values(
			'activo',
			v_parametros.id_gestion,
			v_parametros.id_periodo,
			v_parametros.nombre,
			'registrado',
			p_id_usuario,
			now(),
			v_parametros._id_usuario_ai,
			v_parametros._nombre_usuario_ai,
			null,
			null			
			)RETURNING id_archivo_horas_piloto into v_id_archivo_horas_piloto;
			
			--Definicion de la respuesta
			v_resp = pxp.f_agrega_clave(v_resp,'mensaje','Registro planilla excel almacenado(a) con exito (id_archivo_horas_piloto'||v_id_archivo_horas_piloto||')'); 
            v_resp = pxp.f_agrega_clave(v_resp,'id_archivo_horas_piloto',v_id_archivo_horas_piloto::varchar);

            --Devuelve la respuesta
            return v_resp;

		end;

	/*********************************    
 	#TRANSACCION:  'OIP_ARHOPI_MOD'
 	#DESCRIPCION:	Modificacion de registros
 	#AUTOR:		breydi.vasquez	
 	#FECHA:		20-09-2019 13:42:10
	***********************************/

	elsif(p_transaccion='OIP_ARHOPI_MOD')then

		begin
			--Sentencia de la modificacion
			update oip.tarchivo_horas_piloto set
			id_gestion = v_parametros.id_gestion,
			id_periodo = v_parametros.id_periodo,
			nombre = v_parametros.nombre,
			id_usuario_mod = p_id_usuario,
			fecha_mod = now(),
			id_usuario_ai = v_parametros._id_usuario_ai,
			usuario_ai = v_parametros._nombre_usuario_ai
			where id_archivo_horas_piloto=v_parametros.id_archivo_horas_piloto;
               
			--Definicion de la respuesta
            v_resp = pxp.f_agrega_clave(v_resp,'mensaje','Registro planilla excel modificado(a)'); 
            v_resp = pxp.f_agrega_clave(v_resp,'id_archivo_horas_piloto',v_parametros.id_archivo_horas_piloto::varchar);
               
            --Devuelve la respuesta
            return v_resp;
            
		end;

	/*********************************    
 	#TRANSACCION:  'OIP_ARHOPI_ELI'
 	#DESCRIPCION:	Eliminacion de registros
 	#AUTOR:		breydi.vasquez	
 	#FECHA:		20-09-2019 13:42:10
	***********************************/

	elsif(p_transaccion='OIP_ARHOPI_ELI')then

		begin
			--Sentencia de la eliminacion 

        	if pxp.f_existe_parametro(p_tabla, 'eliminarExcelPilotos') then
             
             --Sentencia de la modificacion
              update oip.thoras_piloto set
              horas_simulador_full = null,
              horas_simulador_fix = null,
              id_usuario_mod = p_id_usuario,
              fecha_mod = now(),
              id_usuario_ai = v_parametros._id_usuario_ai,
              usuario_ai = v_parametros._nombre_usuario_ai
              where id_archivo_horas_piloto = v_parametros.id_archivo_horas_piloto;
              
              update oip.tarchivo_horas_piloto set
              estado = 'registrado',
              archivo = null
              where id_archivo_horas_piloto = v_parametros.id_archivo_horas_piloto;
              
              ---insertar en el log 
              insert into oip.tlog_estado
              (
                estado_reg,
				id_archivo_horas_piloto,
                accion,                
                detalle,
                estado,
                id_usuario_reg,
                fecha_reg,
                id_usuario_ai,
                usuario_ai
                ) values(
                'activo',
                v_parametros.id_archivo_horas_piloto,
                'Eliminacion',
                'SE eliminaron los datos cargados del excel',
                'registrado',
                p_id_usuario,
                now(),
                v_parametros._id_usuario_ai,
                v_parametros._nombre_usuario_ai
	            );
            
              --Definicion de la respuesta
              v_resp = pxp.f_agrega_clave(v_resp,'mensaje','Se elimino correctamente los registros cargados');                             
              
            --- borrar datos de calculo  
        	ELSIF pxp.f_existe_parametro(p_tabla,'datosCalculados')then
            
             --Sentencia de la modificacion
              update oip.thoras_piloto set
              pago_variable = null,
              factor_esfuerzo = null,
              monto_horas_vuelo = null,
              monto_horas_simulador_full = null,
              monto_horas_simulador_fix = null,
              horas_simulador_full_efectivas = null,
              horas_simulador_fix_efectivas = null,
              id_usuario_mod = p_id_usuario,
              fecha_mod = now()
              where id_archivo_horas_piloto = v_parametros.id_archivo_horas_piloto;
              
              update oip.tarchivo_horas_piloto set
              estado = 'archivo_cargado',
              pago_total = null
              where id_archivo_horas_piloto = v_parametros.id_archivo_horas_piloto;
              
              ---insertar en el log 
              insert into oip.tlog_estado
              (
                estado_reg,
				id_archivo_horas_piloto,
                accion,                
                detalle,
                estado,
                id_usuario_reg,
                fecha_reg,
                id_usuario_ai,
                usuario_ai
                ) values(
                'activo',
                v_parametros.id_archivo_horas_piloto,
                'Eliminacion',
                'SE eliminaron los calculos realizados',
                'Archivo Cargado',
                p_id_usuario,
                now(),
                v_parametros._id_usuario_ai,
                v_parametros._nombre_usuario_ai
	            );
            
              --Definicion de la respuesta
              v_resp = pxp.f_agrega_clave(v_resp,'mensaje','Se elimino correctamente los Calculos realizados');                             
                          
            
            else       

              delete from oip.tarchivo_horas_piloto
              where id_archivo_horas_piloto=v_parametros.id_archivo_horas_piloto;
              
              --Definicion de la respuesta
              v_resp = pxp.f_agrega_clave(v_resp,'mensaje','Registro planilla excel eliminado(a)');               
              
            end if;   
            
            v_resp = pxp.f_agrega_clave(v_resp,'id_archivo_horas_piloto',v_parametros.id_archivo_horas_piloto::varchar);
            
            --Devuelve la respuesta
            return v_resp;

		end;  

	/*********************************    
 	#TRANSACCION:  'OIP_FINPAGVAR_MOD'
 	#DESCRIPCION:	Modificacion de registros
 	#AUTOR:		breydi.vasquez	
 	#FECHA:		20-09-2019 13:42:10
	***********************************/

	elsif(p_transaccion='OIP_FINPAGVAR_MOD')then

		begin
			--Sentencia de la modificacion
			update oip.tarchivo_horas_piloto set
            estado = 'finalizado'
			where id_archivo_horas_piloto=v_parametros.id_archivo_horas_piloto;
                          
              
              insert into oip.tlog_estado
              (
                estado_reg,
				id_archivo_horas_piloto,
                accion,                
                detalle,
                estado,
                id_usuario_reg,
                fecha_reg,
                id_usuario_ai,
                usuario_ai
                ) values(
                'activo',
                v_parametros.id_archivo_horas_piloto,
                'Finalizado',
                'SE finalizo proceso de pago variable del mes',
                'finalizado',
                p_id_usuario,
                now(),
                v_parametros._id_usuario_ai,
                v_parametros._nombre_usuario_ai
	            );               
			--Definicion de la respuesta
            v_resp = pxp.f_agrega_clave(v_resp,'mensaje','Se finalizo el item'); 
            v_resp = pxp.f_agrega_clave(v_resp,'id_archivo_horas_piloto',v_parametros.id_archivo_horas_piloto::varchar);
               
            --Devuelve la respuesta
            return v_resp;
            
		end; 
        
	/*********************************    
 	#TRANSACCION:  'OIP_UPPATHEXC_MOD'
 	#DESCRIPCION:	Modificacion de registros
 	#AUTOR:		breydi.vasquez	
 	#FECHA:		20-09-2019 13:42:10
	***********************************/

	elsif(p_transaccion='OIP_UPPATHEXC_MOD')then

		begin

			--Sentencia de la modificacion
			update oip.tarchivo_horas_piloto set
            estado = 'archivo_cargado',
            archivo = v_parametros.path_excel
			where id_archivo_horas_piloto=v_parametros.id_archivo_horas_piloto;            

            ---insert log horas pilotos 
              
              insert into oip.tlog_estado
              (
                estado_reg,
				id_archivo_horas_piloto,
                accion,                
                detalle,
                estado,
                id_usuario_reg,
                fecha_reg,
                id_usuario_ai,
                usuario_ai
                ) values(
                'activo',
                v_parametros.id_archivo_horas_piloto,
                'Carga',
                'Se cargaron los datos del archivo excel',
                'archivo_cargado',
                p_id_usuario,
                now(),
                v_parametros._id_usuario_ai,
                v_parametros._nombre_usuario_ai
	            ); 
                               
			--Definicion de la respuesta
            v_resp = pxp.f_agrega_clave(v_resp,'mensaje','Se subio el archivo'); 
            v_resp = pxp.f_agrega_clave(v_resp,'path_excel',v_parametros.path_excel::varchar);
               
            --Devuelve la respuesta
            return v_resp;
            
		end;         
        
        
	/*********************************    
 	#TRANSACCION:  'OIP_DATAPILO_INS'
 	#DESCRIPCION:	insercion de registros
 	#AUTOR:		breydi.vasquez	
 	#FECHA:		24-09-2019
	***********************************/        
     elsif(p_transaccion = 'OIP_DATAPILO_INS') then
        
        begin         
            
			v_gestion = v_parametros.pilotos:: JSON->>'gestion';
            v_periodo = v_parametros.pilotos:: JSON->>'periodo';            
            
            select ges.id_gestion,
                   per.id_periodo,
                   param.f_literal_periodo(per.id_periodo) as mes
            	into
                   v_rec
            from param.tgestion ges
            inner join param.tperiodo per on per.id_gestion = ges.id_gestion
            where ges.gestion = v_gestion
            and per.periodo = v_periodo;

			select id_periodo, id_archivo_horas_piloto
            	into  v_gestion_pago
            from oip.tarchivo_horas_piloto 
            where id_periodo = v_rec.id_periodo 
            and id_gestion = v_rec.id_gestion; 

            --verifica periodo existe 
            if  v_gestion_pago.id_periodo is not null then
            
             	v_json = v_parametros.pilotos:: JSON->>'pilotos'; -- json con los datos de los pilotos 
      			
                      for v_registros_json in SELECT json_array_elements(v_json :: JSON) loop

                          v_values 		   = v_registros_json.json_array_elements::json;                                                  
                          v_id_funcionario = v_values::json->>'id_funcionario';
                          v_horas_vuelo    = v_values::json->>'horas_vuelo';
                          v_cargo		   = v_values::json->>'cargo';
                          
                          
                          if 	 v_values::json->>'tipo_flota' = 'LARGO' then
                                  v_tipo_flota = 'largo_alcance';
                          elsif  v_values::json->>'tipo_flota' = 'MEDIANO' then
                                  v_tipo_flota = 'mediano_alcance';
                          elsif  v_values::json->>'tipo_flota' = 'CORTO' then
                                  v_tipo_flota = 'corto_alcance';
                          end if; 

                          ---verficacion de funcionario y captura de datos funcionario ----------
                            select
                                   anex.pic_sic,
                                   anex.tipo_flota,
                                   vf.id_funcionario,
                                   vf.desc_funcionario2 as nombre_piloto,
                                   vf.ci,
                                   vf.id_cargo
                                into 
                                   v_rec_esc                   
                            from orga.vfuncionario_cargo_lugar vf
                            left join orga.tcargo car on car.id_cargo = vf.id_cargo
                            left join orga.tescala_salarial esc on esc.id_escala_salarial = car.id_escala_salarial
                            left join orga.tcategoria_salarial cat on cat.id_categoria_salarial = esc.id_categoria_salarial
                            left join oip.tanexo1 anex on anex.id_escala_salarial = esc.id_escala_salarial
                            where vf.id_funcionario = v_id_funcionario           
                                and cat.codigo = 'SUPER';

                      ---control funcionario existe dentro el periodo 
                	  if v_rec_esc.id_funcionario is not null then
                                -- caso de diferencia actualiza el tipo flota del cargo con item del ERP, si no se mantiene
                                if v_rec_esc.tipo_flota <> v_tipo_flota then
                                	v_real_tipo_flota = v_rec_esc.tipo_flota;
                                else 
                                	v_real_tipo_flota = v_tipo_flota;
                                end if; 

                        if exists(select 1 from oip.thoras_piloto where id_archivo_horas_piloto = v_gestion_pago.id_archivo_horas_piloto
                                    and id_funcionario = v_id_funcionario )then
                        
                                update oip.thoras_piloto set
                                horas_vuelo = v_horas_vuelo,
                                pic_sic =  v_cargo,
                                tipo_flota = v_real_tipo_flota
                                where id_archivo_horas_piloto = v_gestion_pago.id_archivo_horas_piloto
                                    and id_funcionario = v_id_funcionario;
                        else
                      
                                --Sentencia de la insercion
                                insert into oip.thoras_piloto(
                                estado_reg,
                                gestion,
                                mes,
                                ci,
                                nombre_piloto,
                                tipo_flota,
                                horas_vuelo,
                                id_archivo_horas_piloto,
                                id_funcionario,
                                estado,
                                pic_sic,
                                id_usuario_reg,
                                fecha_reg,
                                id_usuario_ai,
                                usuario_ai,
                                id_usuario_mod,
                                fecha_mod
                                ) values(
                                'activo',
                                v_rec.id_gestion,
                                v_rec.id_periodo,
                                v_fv_rec_escun.ci,
                                v_rec_esc.nombre_piloto,
                                v_real_tipo_flota,
                                v_horas_vuelo,
                                v_id_archivo_horas_piloto,
                                v_id_funcionario,
                                v_rec_esc.id_cargo,
                                'activo',
                                v_cargo,
                                p_id_usuario,
                                now(),
                                v_parametros._id_usuario_ai,
                                v_parametros._nombre_usuario_ai,
                                null,
                                null													
                                ); 
                          end if;                     
                      end if;
    			        
                   	 end loop;
                    	            
            else 
            
                  --Sentencia de la insercion cabecera
                  insert into oip.tarchivo_horas_piloto(
                  estado_reg,
                  id_gestion,
                  id_periodo,
                  nombre,
                  estado,
                  id_usuario_reg,
                  fecha_reg,
                  id_usuario_ai,
                  usuario_ai,
                  id_usuario_mod,
                  fecha_mod
                  ) values(
                  'activo',
                  v_rec.id_gestion,
                  v_rec.id_periodo,
                  'Calculo Pago Variable Mes '||v_rec.mes||''::varchar,
                  'registrado',
                  p_id_usuario,
                  now(),
                  null,
                  null,
                  null,
                  null			
                  )RETURNING id_archivo_horas_piloto, id_gestion, id_periodo into v_id_archivo_horas_piloto, v_id_gestion, v_id_periodo;
                  

                  v_json = v_parametros.pilotos:: JSON->>'pilotos';
                  
                  --Sentencia de la insercion detalle
                  
                      for v_registros_json in SELECT json_array_elements(v_json :: JSON) loop

                          v_values 		 = v_registros_json.json_array_elements::json;                                                  
                          v_id_funcionario = v_values::json->>'id_funcionario';
                          v_horas_vuelo    = v_values::json->>'horas_vuelo';
                          v_cargo			 = v_values::json->>'cargo';
                          
                          
                          if 	   v_values::json->>'tipo_flota' = 'LARGO' then
                                  v_tipo_flota = 'largo_alcance';
                          elsif  v_values::json->>'tipo_flota' = 'MEDIANO' then
                                  v_tipo_flota = 'mediano_alcance';
                          elsif  v_values::json->>'tipo_flota' = 'CORTO' then
                                  v_tipo_flota = 'corto_alcance';
                          end if;                    
                          
                          ---verficacion de funcionario y captura de datos funcionario ----------
                            select
                                   anex.pic_sic,
                                   anex.tipo_flota,
                                   vf.id_funcionario,
                                   vf.desc_funcionario2 as nombre_piloto,
                                   vf.ci,
                                   vf.id_cargo
                                into 
                                   v_rec_esc                   
                            from orga.vfuncionario_cargo_lugar vf
                            left join orga.tcargo car on car.id_cargo = vf.id_cargo
                            left join orga.tescala_salarial esc on esc.id_escala_salarial = car.id_escala_salarial
                            left join orga.tcategoria_salarial cat on cat.id_categoria_salarial = esc.id_categoria_salarial
                            left join oip.tanexo1 anex on anex.id_escala_salarial = esc.id_escala_salarial
                            where vf.id_funcionario = v_id_funcionario          
                                and cat.codigo = 'SUPER';
                                              
                          
      					  if v_rec_esc.id_funcionario is not null then 
                                -- caso de diferencia actualiza el tipo flota del cargo con item del ERP, si no se mantiene
                                if v_rec_esc.tipo_flota <> v_tipo_flota then
                                	v_real_tipo_flota = v_rec_esc.tipo_flota;
                                else 
                                	v_real_tipo_flota = v_tipo_flota;
                                end if;    

                            --Sentencia de la insercion
                            insert into oip.thoras_piloto(
                            estado_reg,
                            gestion,
                            mes,
                            ci,
                            nombre_piloto,
                            tipo_flota,
                            horas_vuelo,
                            id_archivo_horas_piloto,
                            id_funcionario,
                            id_cargo,
                            estado,
                            pic_sic,
                            id_usuario_reg,
                            fecha_reg,
                            id_usuario_ai,
                            usuario_ai,
                            id_usuario_mod,
                            fecha_mod
                            ) values(
                            'activo',
                            v_rec.id_gestion,
                            v_rec.id_periodo,
                            v_rec_esc.ci,
                            v_rec_esc.nombre_piloto,
                            v_real_tipo_flota,
                            v_horas_vuelo,
                            v_id_archivo_horas_piloto,
                            v_id_funcionario,
                            v_rec_esc.id_cargo,
                            'activo',
                            v_cargo,
                            p_id_usuario,
                            now(),
                            v_parametros._id_usuario_ai,
                            v_parametros._nombre_usuario_ai,
                            null,
                            null													
                            );
							end if;                                                               
                      end loop;                
      				
                      -- update estado registro 
                      update oip.tarchivo_horas_piloto set
                          estado = 'registrado'
                      where id_archivo_horas_piloto = v_id_archivo_horas_piloto;            
            end if;			
			--Definicion de la respuesta
			v_resp = pxp.f_agrega_clave(v_resp,'mensaje','Registro almacenado(a) con exito (id_archivo_horas_piloto'||v_id_archivo_horas_piloto||')'); 
            v_resp = pxp.f_agrega_clave(v_resp,'id_archivo_horas_piloto',v_id_archivo_horas_piloto::varchar);           

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

ALTER FUNCTION oip.ft_archivo_horas_piloto_ime (p_administrador integer, p_id_usuario integer, p_tabla varchar, p_transaccion varchar)
  OWNER TO postgres;