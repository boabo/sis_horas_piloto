CREATE OR REPLACE FUNCTION oip.f_horas_simulador (
  p_horas_full integer,
  p_horas_fix integer,
  p_max_horas integer,
  p_horas_adicionales integer,
  out p_resp_full integer,
  out p_resp_fix integer
)
RETURNS record AS
$body$

	/*********************************   
 	#DESCRIPCION:	Control de horas simulador efectivas 
 	#AUTOR:		breydi.vasquez	
 	#FECHA:		20-09-2019
	***********************************/

DECLARE
	v_resp 		integer;
    v_fix		integer;
    v_incre		integer;
BEGIN

    if p_horas_adicionales > 0 then 
        if p_horas_full + p_horas_fix > p_max_horas then
            -- si full es mayor a maximo horas
            if p_horas_full >= p_max_horas then 
                p_resp_full = p_max_horas;
                p_resp_fix = 0;
            else             
                -- si full es mayor a fix 
                if p_horas_full > p_horas_fix then
                    v_incre = p_max_horas - p_horas_full;
                    p_horas_fix = v_incre;
                    p_horas_full = p_horas_full;
                else
                    v_fix = p_horas_fix;
                    while (v_fix + p_horas_full > p_max_horas) loop
                            v_fix  =  v_fix - 1;
                    end loop;                
                    p_resp_full =  p_horas_full;
                    p_resp_fix  = v_fix;
               end if;
            end if;                
            
        else
         
        p_resp_full = p_horas_full;
        p_resp_fix  = p_horas_fix;
        
        end if; 
        
    else
        p_resp_full = 0;
        p_resp_fix  = 0;    
    
    end if;              
    
	return;
END;
$body$
LANGUAGE 'plpgsql'
VOLATILE
CALLED ON NULL INPUT
SECURITY INVOKER
COST 100;

ALTER FUNCTION oip.f_horas_simulador (p_horas_full integer, p_horas_fix integer, p_max_horas integer, p_horas_adicionales integer, out p_resp_full integer, out p_resp_fix integer)
  OWNER TO postgres;