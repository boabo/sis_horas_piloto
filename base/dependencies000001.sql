/***********************************I-DEP-BVP-HORAS-PILOTO-0-02/10/2019*****************************************/
select pxp.f_insert_testructura_gui ('OIP', 'SISTEMA');
select pxp.f_delete_testructura_gui ('PAGVAPI', 'OIP');
select pxp.f_delete_testructura_gui ('PAGVAPI.1', 'PAGVAPI');
select pxp.f_delete_testructura_gui ('TIPSIMU', 'OIP');
select pxp.f_insert_testructura_gui ('PARAMOIP', 'OIP');
select pxp.f_insert_testructura_gui ('PROCMOIP', 'OIP');
select pxp.f_insert_testructura_gui ('REPOIP', 'OIP');
select pxp.f_delete_testructura_gui ('PAGVAPI.1', 'PARAMOIP');
select pxp.f_insert_testructura_gui ('PAGVAPI.1', 'PAGVAPI');
select pxp.f_insert_testructura_gui ('TIPSIMU', 'PARAMOIP');
select pxp.f_insert_testructura_gui ('PAGVAPI', 'PROCMOIP');
select pxp.f_insert_testructura_gui ('TIPFLO', 'PARAMOIP');
select pxp.f_insert_testructura_gui ('TIPANE', 'PARAMOIP');
select pxp.f_delete_tprocedimiento_gui ('OIP_HOPILO_INS', 'PAGVAPI.1');
select pxp.f_delete_tprocedimiento_gui ('OIP_HOPILO_MOD', 'PAGVAPI.1');
select pxp.f_delete_tprocedimiento_gui ('OIP_HOPILO_ELI', 'PAGVAPI.1');
select pxp.f_delete_tprocedimiento_gui ('OIP_HOPILO_SEL', 'PAGVAPI.1');
select pxp.f_insert_tprocedimiento_gui ('OIP_HOPILO_INS', 'PAGVAPI.1', 'si');
select pxp.f_insert_tprocedimiento_gui ('OIP_HOPILO_MOD', 'PAGVAPI.1', 'si');
select pxp.f_insert_tprocedimiento_gui ('OIP_HOPILO_ELI', 'PAGVAPI.1', 'si');
select pxp.f_insert_tprocedimiento_gui ('OIP_HOPILO_SEL', 'PAGVAPI.1', 'no');
/***********************************F-DEP-BVP-HORAS-PILOTO-0-02/10/2019*****************************************/