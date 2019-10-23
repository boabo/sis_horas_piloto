CREATE OR REPLACE FUNCTION oip.ft_horas_piloto_ime (
  p_administrador integer,
  p_id_usuario integer,
  p_tabla varchar,
  p_transaccion varchar
)
RETURNS varchar AS
$body$
/*************************************************************************
 SISTEMA:		Horas Piloto
 FUNCION: 		oip.ft_horas_piloto_ime
 DESCRIPCION:   Funcion que gestiona las operaciones basicas (inserciones, modificaciones, eliminaciones de la tabla 'oip.thoras_piloto'
 AUTOR: 		 (breydi.vasquez)
 FECHA:	        20-09-2019 13:43:39
 COMENTARIOS:	
***************************************************************************
 HISTORIAL DE MODIFICACIONES:
#ISSUE				FECHA				AUTOR				DESCRIPCION
 #0				20-09-2019 13:43:39								Funcion que gestiona las operaciones basicas (inserciones, modificaciones, eliminaciones de la tabla 'oip.thoras_piloto'	
 #
 ***************************************************************************/

DECLARE

	v_nro_requerimiento    		integer;
	v_parametros           		record;
	v_id_requerimiento     		integer;
	v_resp		            	varchar;
	v_nombre_funcion        	text;
	v_mensaje_error         	text;
	v_id_horas_piloto			integer;
    v_id_funcionario			integer;
    v_rec						record;
    v_factor_esfuerzo			numeric;
    v_costo_sim_full			numeric;
    v_costo_sim_fix				numeric;
    v_max_horas_tipo_simu		integer;
    v_horas_simulador			record;
    v_horas_adicionales			integer;
    v_pago_variable				numeric;
    v_gestion					integer;
    v_periodo					integer;
    v_count						integer; 
    v_pago_total				numeric;
    v_json						varchar;
    v_registros_json			record; 
    v_values					varchar;
    v_rec_esc					record;
    v_gestion_pago				record;
    v_fun						record;
    v_id_archivo_horas_piloto 	integer;
    v_horas_simu_full			integer;
    v_horas_simu_fix			integer;
    V_A							numeric;
    V_B							numeric;
    V_C							numeric;    
			    
BEGIN

    v_nombre_funcion = 'oip.ft_horas_piloto_ime';
    v_parametros = pxp.f_get_record(p_tabla);

	/*********************************    
 	#TRANSACCION:  'OIP_HOPILO_INS'
 	#DESCRIPCION:	Insercion de registros
 	#AUTOR:		breydi.vasquez	
 	#FECHA:		20-09-2019 13:43:39
	***********************************/

	if(p_transaccion='OIP_HOPILO_INS')then
					
        begin
        
            
            select fun.id_funcionario 
            	into
	               v_id_funcionario
            from orga.vfuncionario fun
            where fun.ci = v_parametros.ci;

		 if v_id_funcionario is null then 
         	raise exception 'La persona % no es funcionario de la empresa Boa.',v_parametros.nombre_piloto; 
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
			horas_simulador_full,
			horas_simulador_fix,
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
			v_parametros.id_gestion,
			v_parametros.id_periodo,
			v_parametros.ci,
			v_parametros.nombre_piloto,
			v_parametros.tipo_flota,
			v_parametros.horas_vuelo,
			v_parametros.horas_simulador_full,
			v_parametros.horas_simulador_fix,
            v_parametros.id_archivo_horas_piloto,
            v_id_funcionario,
			'activo',
            v_parametros.cargo,
			p_id_usuario,
			now(),
			v_parametros._id_usuario_ai,
			v_parametros._nombre_usuario_ai,
			null,
			null													
			)RETURNING id_horas_piloto into v_id_horas_piloto;			
	            
			--Definicion de la respuesta
			v_resp = pxp.f_agrega_clave(v_resp,'mensaje','Detalle Calculo sueldo piloto almacenado(a) con exito (id_horas_piloto'||v_id_horas_piloto||')'); 
            v_resp = pxp.f_agrega_clave(v_resp,'id_horas_piloto',v_id_horas_piloto::varchar);

            --Devuelve la respuesta
            return v_resp;

		end;

	/*********************************    
 	#TRANSACCION:  'OIP_HOPILO_MOD'
 	#DESCRIPCION:	Modificacion de registros
 	#AUTOR:		breydi.vasquez	
 	#FECHA:		20-09-2019 13:43:39
	***********************************/

	elsif(p_transaccion='OIP_HOPILO_MOD')then

		begin
        
			--Sentencia de la modificacion
			update oip.thoras_piloto set
			ci = v_parametros.ci,
			id_funcionario = v_parametros.id_funcionario,
			tipo_flota = v_parametros.tipo_flota,
			horas_vuelo = v_parametros.horas_vuelo,
			horas_simulador_full = v_parametros.horas_simulador_full,
			horas_simulador_fix = v_parametros.horas_simulador_fix,
			id_usuario_mod = p_id_usuario,
			fecha_mod = now(),
			id_usuario_ai = v_parametros._id_usuario_ai,
			usuario_ai = v_parametros._nombre_usuario_ai
			where id_horas_piloto=v_parametros.id_horas_piloto;
               
			--Definicion de la respuesta
            v_resp = pxp.f_agrega_clave(v_resp,'mensaje','Detalle Calculo sueldo piloto modificado(a)'); 
            v_resp = pxp.f_agrega_clave(v_resp,'id_horas_piloto',v_parametros.id_horas_piloto::varchar);
               
            --Devuelve la respuesta
            return v_resp;
            
		end;

	/*********************************    
 	#TRANSACCION:  'OIP_HOPILO_ELI'
 	#DESCRIPCION:	Eliminacion de registros
 	#AUTOR:		breydi.vasquez	
 	#FECHA:		20-09-2019 13:43:39
	***********************************/

	elsif(p_transaccion='OIP_HOPILO_ELI')then

		begin
			--Sentencia de la eliminacion
			delete from oip.thoras_piloto
            where id_horas_piloto=v_parametros.id_horas_piloto;
               
            --Definicion de la respuesta
            v_resp = pxp.f_agrega_clave(v_resp,'mensaje','Detalle Calculo sueldo piloto eliminado(a)'); 
            v_resp = pxp.f_agrega_clave(v_resp,'id_horas_piloto',v_parametros.id_horas_piloto::varchar);
              
            --Devuelve la respuesta
            return v_resp;

		end;
        
	/*********************************    
 	#TRANSACCION:  'OIP_UPHOPILO_MOD'
 	#DESCRIPCION:	Actualizacion de registros Con el archivo excel
 	#AUTOR:		breydi.vasquez	
 	#FECHA:		20-09-2019 
	***********************************/

	elsif(p_transaccion='OIP_UPHOPILO_MOD')then

		begin

            --- captura del funcionario a actualizar
            select
                   anex.pic_sic,
                   anex.tipo_flota,
                   vf.id_funcionario,
                   vf.desc_funcionario2 as nombre_piloto,
                   vf.ci,
                   vf.id_cargo
                into 
                   v_fun                   
            from orga.vfuncionario_cargo_lugar vf
            left join orga.tcargo car on car.id_cargo = vf.id_cargo
            left join orga.tescala_salarial esc on esc.id_escala_salarial = car.id_escala_salarial
            left join orga.tcategoria_salarial cat on cat.id_categoria_salarial = esc.id_categoria_salarial
            left join oip.tanexo1 anex on anex.id_escala_salarial = esc.id_escala_salarial
            where vf.ci = v_parametros.ci
                and cat.codigo = 'SUPER';
            
            -- captura de ids gestion, periodo
            select ges.id_gestion,
                   per.id_periodo
            	into
                   v_gestion, v_periodo
            from param.tgestion ges
            inner join param.tperiodo per on per.id_gestion = ges.id_gestion
            where ges.gestion = v_parametros.gestion
            and per.periodo = v_parametros.periodo;                  
            
            if v_fun.id_funcionario is not null then 
            
                -- control si no existe el funcionario dentro el periodo de pago 
                if  v_fun.id_funcionario not in (select id_funcionario from oip.thoras_piloto 
                                             where ci = v_parametros.ci 
                                             and id_archivo_horas_piloto = v_parametros.id_archivo_horas_piloto) then  
                         
                          --Sentencia de la insercion
                          insert into oip.thoras_piloto(
                          estado_reg,
                          gestion,
                          mes,
                          ci,
                          nombre_piloto,
                          id_archivo_horas_piloto,
                          id_funcionario,
                          id_cargo,
                          tipo_flota,
                          pic_sic,
                          estado,
                          id_usuario_reg,
                          fecha_reg,
                          id_usuario_ai,
                          usuario_ai,
                          id_usuario_mod,
                          fecha_mod
                          ) values(
                          'activo',
                          v_gestion,
                          v_periodo,
                          v_parametros.ci,
                          v_parametros.nombre_piloto,
                          v_parametros.id_archivo_horas_piloto,
                          v_fun.id_funcionario,
                          v_fun.id_cargo,
                          v_fun.tipo_flota,
                          v_fun.pic_sic,
                          'activo',
                          p_id_usuario,
                          now(),
                          v_parametros._id_usuario_ai,
                          v_parametros._nombre_usuario_ai,
                          null,
                          null													
                          );
                          
                else
                
                        --Sentencia de la modificacion
                        update oip.thoras_piloto set                                                                                                
                        horas_simulador_full = v_parametros.horas_simulador_full,
                        horas_simulador_fix = v_parametros.horas_simulador_fix,
                        id_usuario_mod = p_id_usuario,
                        fecha_mod = now(),
                        id_usuario_ai = v_parametros._id_usuario_ai,
                        usuario_ai = v_parametros._nombre_usuario_ai
                        where ci = v_parametros.ci and id_archivo_horas_piloto = v_parametros.id_archivo_horas_piloto;

                end if; 
            
       	end if;
                     
			--Definicion de la respuesta
            v_resp = pxp.f_agrega_clave(v_resp,'mensaje','Detalle Calculo sueldo piloto archivo cargado(a)'); 
            v_resp = pxp.f_agrega_clave(v_resp,'modificado nombre_piloto',v_parametros.nombre_piloto::varchar);
               
            --Devuelve la respuesta
            return v_resp;
            
		end;        
         
	/*********************************    
 	#TRANSACCION:  'OIP_CALPAGVAR_IME'
 	#DESCRIPCION:	Medicion y Calculo del pago Variable
 	#AUTOR:		breydi.vasquez	
 	#FECHA:		20-09-2019
	***********************************/

	elsif(p_transaccion='OIP_CALPAGVAR_IME')then

		begin
            
		
		--simulador Full costo hora
		select costo_hora, maximo_horas 
        	into 
            v_costo_sim_full, v_max_horas_tipo_simu
        from oip.ttipo_simulador
        where tipo_simulador = 'Full Flight Simulator';
        
        --simulador Fix costo hora
        select costo_hora into v_costo_sim_fix
        from oip.ttipo_simulador
        where tipo_simulador = 'Fix Based Simulator';
        

        for v_rec in select
        				   horpi.id_horas_piloto,	
                           horpi.horas_vuelo,
                           horpi.nombre_piloto, 
                           horpi.tipo_flota,
                           horpi.horas_simulador_full as ful,
                           horpi.horas_simulador_fix as fix,
                           case when horpi.pic_sic = 'PIC' then 
                               tflo.costo_hora_base_pic
                           else
                               tflo.costo_hora_base_sic
                           end as costo_horas_base,
                           tflo.costo_hora_base_pic,
                           tflo.costo_hora_base_sic,
                           tflo.relacion_ciclo_hora,
                           tflo.horas_base,
                           tflo.maximo_horas,
                           horpi.id_funcionario,
                           horpi.pic_sic            
                        from oip.thoras_piloto horpi
                        inner join oip.ttipo_flota tflo on tflo.tipo_flota = horpi.tipo_flota
                        where horpi.id_archivo_horas_piloto = v_parametros.id_archivo_horas_piloto
        loop
        	
			---validaciones inicio----------
            select esc.haber_basico,
                   anex.remuneracion_basica,
                   anex.remuneracion_maxima,
                   anex.pic_sic,
                   anex.tipo_flota,
                   car.codigo as nro_item,
                   vf.desc_funcionario2,
                   esc.nombre
            	into 
                   v_rec_esc                   
            from orga.vfuncionario_cargo_lugar vf
            left join orga.tcargo car on car.id_cargo = vf.id_cargo
            left join orga.tescala_salarial esc on esc.id_escala_salarial = car.id_escala_salarial
            left join orga.tcategoria_salarial cat on cat.id_categoria_salarial = esc.id_categoria_salarial
            left join oip.tanexo1 anex on anex.id_escala_salarial = esc.id_escala_salarial
            where vf.id_funcionario = v_rec.id_funcionario	            
                and cat.codigo = 'SUPER';


            IF (v_rec_esc.haber_basico is null or v_rec_esc.remuneracion_basica is null ) then 
            	raise exception 'El funcionario % no cuenta con un haber basico ',coalesce(v_rec_esc.desc_funcionario2,v_rec.nombre_piloto);
            end if;
            
            if v_rec_esc.pic_sic <> v_rec.pic_sic then
            	raise exception 'Existe diferencia de cargo para el funcionario %,Dentro la escala salarial tiene cargo: %',v_rec_esc.desc_funcionario2, v_rec_esc.nombre;
            end if;
            
            if v_rec_esc.tipo_flota <> v_rec.tipo_flota then 
            	raise exception 'Existe diferencia de tipo flota para el funcionario %',v_rec_esc.desc_funcionario2;
            end if;
            
            -- control haber basico diferencias 
            if v_rec_esc.haber_basico <> v_rec_esc.remuneracion_basica then
	            raise exception 'Existe diferencia haber basico: escala salarial: %  y anexo1: %',v_rec_esc.haber_basico, v_rec_esc.remuneracion_basica;
            end if;
                    	        
        
        ---validaciones fin-------
        
        	-- Horas Vuelo
                                       
            if v_rec.horas_vuelo <= v_rec.horas_base then 
            	v_horas_adicionales = 0;
            else 
                if (( v_rec.horas_vuelo - v_rec.horas_base) >= v_rec.maximo_horas ) then 
                        v_horas_adicionales = v_rec.maximo_horas;
                else 
                        v_horas_adicionales = v_rec.horas_vuelo - v_rec.horas_base;
                end if;
            end if;                    
                            
            --- Calculo Factor Esfuerzo
            v_factor_esfuerzo = (( v_rec.horas_base + v_horas_adicionales ) / ( v_rec.horas_base + 1 )) * ( 1 / v_rec.relacion_ciclo_hora );                        
                    
                    
            -- Horas Simulador  
            v_horas_simulador = oip.f_horas_simulador(v_rec.ful, v_rec.fix, v_max_horas_tipo_simu, v_horas_adicionales);


            -- Calculo Pago Variable
            V_A = v_rec.costo_horas_base * v_factor_esfuerzo * v_horas_adicionales; 
            
            -- Calculo costo horas simulador full        
            V_B = v_costo_sim_full * v_horas_simulador.p_resp_full;
            
            -- Calculo costo horas simulador fix
            V_C = v_costo_sim_fix * v_horas_simulador.p_resp_fix;
            
            -- Formula Pago Variable        
            v_pago_variable = ( v_A + ( coalesce( V_B, 0 ) +  coalesce( V_C, 0 ) ));
                    

            
            if ( (v_rec_esc.haber_basico + v_pago_variable) between v_rec_esc.remuneracion_basica and v_rec_esc.remuneracion_maxima ) then 
                ------- Actualizacion de datos
                update oip.thoras_piloto set 
                factor_esfuerzo = v_factor_esfuerzo,
                pago_variable   = v_pago_variable,
                monto_horas_vuelo = V_A,
                monto_horas_simulador_full = coalesce(V_B, 0),
                monto_horas_simulador_fix = coalesce(V_C, 0),
                horas_simulador_full_efectivas = coalesce(v_horas_simulador.p_resp_full, 0),
                horas_simulador_fix_efectivas = coalesce(v_horas_simulador.p_resp_fix, 0)
                where id_horas_piloto = v_rec.id_horas_piloto; 
			else 
            	raise exception 'La maxima remuneracion para el funcionario % es de: %, y su haber basico mas su pago variable 
                		superan la remuneracion maxima de % ', v_rec.nombre_piloto, (v_rec_esc.haber_basico + v_pago_variable),  v_rec_esc.remuneracion_maxima;                
			end if;       
                                                            
 
                       
        end loop; 
            
        	--suma total pago variable 
        	select sum(pago_variable) into v_pago_total
            from oip.thoras_piloto 
            where id_archivo_horas_piloto = v_parametros.id_archivo_horas_piloto;
            
        	--cambio de estado  y actualizacion de pago total 
        	update oip.tarchivo_horas_piloto set
            estado = 'calculado',
            pago_total = v_pago_total
            where id_archivo_horas_piloto = v_parametros.id_archivo_horas_piloto;
            
			--registro en la table log
              
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
                'Calculo',
                'Se realizo el calculo del pago variable',
                'calculado',
                p_id_usuario,
                now(),
                v_parametros._id_usuario_ai,
                v_parametros._nombre_usuario_ai
	            );            
           
            --Definicion de la respuesta
            v_resp = pxp.f_agrega_clave(v_resp,'mensaje','Calculo sueldo piloto registrados(a)'); 
            v_resp = pxp.f_agrega_clave(v_resp,'id_archivo_horas_piloto',v_parametros.id_archivo_horas_piloto::varchar);
              
            --Devuelve la respuesta
            return v_resp;

		end;

	/*********************************    
 	#TRANSACCION:  'OIP_UPSIMPILO_MOD'
 	#DESCRIPCION:	servicio para insercion o acualizacion de registros
 	#AUTOR:		breydi.vasquez	
 	#FECHA:		24-09-2019
	***********************************/        
     elsif(p_transaccion = 'OIP_UPSIMPILO_MOD') then
        
        begin                     			                              

			v_gestion = v_parametros.horas_simulador::JSON->>'gestion';
            v_periodo = v_parametros.horas_simulador::JSON->>'periodo';
            
            -- captura de ids gestion, periodo
            select ges.id_gestion,
                   per.id_periodo
            	into
                   v_gestion, v_periodo
            from param.tgestion ges
            inner join param.tperiodo per on per.id_gestion = ges.id_gestion
            where ges.gestion = v_gestion
            and per.periodo = v_periodo;
            
            select arhopi.id_periodo, arhopi.id_archivo_horas_piloto
            	into v_gestion_pago
            from oip.tarchivo_horas_piloto arhopi
            where arhopi.id_gestion = v_gestion
            and arhopi.id_periodo = v_periodo;

            
		    v_json = v_parametros.horas_simulador:: JSON->>'piloto';
             
          
			if v_gestion_pago.id_periodo is not null then 
            		
	            for v_registros_json in SELECT json_array_elements(v_json :: JSON) loop

             		v_values = v_registros_json.json_array_elements::json;
                    
                    --- captura del funcionario a actualizar
                        select
                                anex.pic_sic,
                                anex.tipo_flota,
                                vf.id_funcionario,
                                vf.desc_funcionario2 as nombre_piloto,
                                vf.ci,
                                vf.id_cargo
                            into 
                                v_fun                   
                        from orga.vfuncionario_cargo_lugar vf
                        left join orga.tcargo car on car.id_cargo = vf.id_cargo
                        left join orga.tescala_salarial esc on esc.id_escala_salarial = car.id_escala_salarial
                        left join orga.tcategoria_salarial cat on cat.id_categoria_salarial = esc.id_categoria_salarial
                        left join oip.tanexo1 anex on anex.id_escala_salarial = esc.id_escala_salarial
                        where vf.id_funcionario = v_values::json->>'id_funcionario'           
                            and cat.codigo = 'SUPER';
                    
                    if v_fun.id_funcionario is not null then 
                    
                      ---controlar funcionario existe                
                        if exists(select 1 from oip.thoras_piloto where id_archivo_horas_piloto = v_gestion_pago.id_archivo_horas_piloto
                      			and id_funcionario = v_fun.id_funcionario )then 
                                
                            --Sentencia de la modificacion
                            update oip.thoras_piloto set
                            horas_simulador_full = v_values::json->>'horas_simulador_full',
                            horas_simulador_fix  =  v_values::json->>'horas_simulador_fix',
                            id_usuario_mod = p_id_usuario,
                            fecha_mod = now()
                            where ci = v_values::json->>'ci' 
                                and id_funcionario = v_values::json->>'id_funcionario'
                                and id_archivo_horas_piloto = v_gestion_pago.id_archivo_horas_piloto;
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
                            id_cargo,
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
                            v_fun.ci,
                            v_fun.nombre_piloto,
                            v_fun.tipo_flota,
                            0,
                            v_gestion_pago.id_archivo_horas_piloto,
                            v_fun.id_funcionario,
                            'activo',
                            v_fun.pic_sic,
                            v_fun.id_cargo,
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
                  
                  update oip.tarchivo_horas_piloto set
                  estado = 'archivo_cargado'
                  where id_archivo_horas_piloto = v_gestion_pago.id_archivo_horas_piloto; 
                  v_resp = pxp.f_agrega_clave(v_resp,'mensaje','Actualizacion de datos con exito.');                                           
                  
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
                  v_gestion,
                  v_periodo,
                  'Calculo Pago Variable Mes '||param.f_literal_periodo(v_periodo)||''::varchar,
                  'registrado',
                  p_id_usuario,
                  now(),
                  null,
                  null,
                  null,
                  null			
                  )RETURNING id_archivo_horas_piloto into v_id_archivo_horas_piloto;
                              
                  
                  -- insercion de datos  al detalle                   
	            for v_registros_json in SELECT json_array_elements(v_json :: JSON) loop

             		v_values = v_registros_json.json_array_elements::json;                  
                          v_values 		 	= v_registros_json.json_array_elements::json;                                                  
                          v_id_funcionario	= v_values::json->>'id_funcionario';
                          v_horas_simu_full = v_values::json->>'horas_simulador_full';
                          v_horas_simu_fix  = v_values::json->>'horas_simulador_fix';                                              

                          -- datos funcionario 
                          select
                                 anex.pic_sic,
                                 anex.tipo_flota,
                                 vf.id_funcionario,
                                 vf.desc_funcionario2 as nombre_piloto,
                                 vf.ci,
                                 vf.id_cargo
                              into 
                                 v_fun                   
                          from orga.vfuncionario_cargo_lugar vf
                          left join orga.tcargo car on car.id_cargo = vf.id_cargo
                          left join orga.tescala_salarial esc on esc.id_escala_salarial = car.id_escala_salarial
                          left join orga.tcategoria_salarial cat on cat.id_categoria_salarial = esc.id_categoria_salarial
                          left join oip.tanexo1 anex on anex.id_escala_salarial = esc.id_escala_salarial
                          where vf.id_funcionario = v_id_funcionario
                              and cat.codigo = 'SUPER';
                                              

      					if v_fun.id_funcionario is not null then 
                                
                            --Sentencia de la insercion
                            insert into oip.thoras_piloto(
                            estado_reg,
                            gestion,
                            mes,
                            ci,
                            nombre_piloto,
                            tipo_flota,
                            pic_sic,
                            horas_vuelo,
                            id_archivo_horas_piloto,
                            id_funcionario,
                            id_cargo,
                            estado,
                            horas_simulador_full,
                            horas_simulador_fix,
                            id_usuario_reg,
                            fecha_reg,
                            id_usuario_ai,
                            usuario_ai,
                            id_usuario_mod,
                            fecha_mod
                            ) values(
                            'activo',
                            v_gestion,
                            v_periodo,
                            v_fun.ci,
                            v_fun.nombre_piloto,
                            v_fun.tipo_flota,
                            v_fun.pic_sic,
                            0,
                            v_id_archivo_horas_piloto,
                            v_id_funcionario,
                            v_fun.id_cargo,
                            'activo',
                            v_horas_simu_full,
                            v_horas_simu_fix,
                            p_id_usuario,
                            now(),
                            v_parametros._id_usuario_ai,
                            v_parametros._nombre_usuario_ai,
                            null,
                            null													
                            );
                        end if;
                    end loop;
                    
                  update oip.tarchivo_horas_piloto set
                  estado = 'registrado'
                  where id_archivo_horas_piloto = v_id_archivo_horas_piloto; 
                --Definicion de la respuesta
                v_resp = pxp.f_agrega_clave(v_resp,'mensaje','Insercion de cabecera y detalle pago variable con exito.');                                                   
             end if;
             

                  
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

ALTER FUNCTION oip.ft_horas_piloto_ime (p_administrador integer, p_id_usuario integer, p_tabla varchar, p_transaccion varchar)
  OWNER TO postgres;