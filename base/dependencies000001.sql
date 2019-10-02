/***********************************I-DEP-BVP-HORAS-PILOTO-0-02/10/2019*****************************************/
select pxp.f_insert_testructura_gui ('OIP', 'SISTEMA');
select pxp.f_insert_testructura_gui ('PARAMOIP', 'OIP');
select pxp.f_insert_testructura_gui ('PROCMOIP', 'OIP');
select pxp.f_insert_testructura_gui ('REPOIP', 'OIP');
select pxp.f_delete_testructura_gui ('PAGVAPI.1', 'PARAMOIP');
select pxp.f_insert_testructura_gui ('PAGVAPI.1', 'PAGVAPI');
select pxp.f_insert_testructura_gui ('TIPSIMU', 'PARAMOIP');
select pxp.f_insert_testructura_gui ('PAGVAPI', 'PROCMOIP');
select pxp.f_insert_testructura_gui ('TIPFLO', 'PARAMOIP');
select pxp.f_insert_testructura_gui ('TIPANE', 'PARAMOIP');
/***********************************F-DEP-BVP-HORAS-PILOTO-0-02/10/2019*****************************************/