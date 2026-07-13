@AbapCatalog.sqlViewName: 'ZCDSV_E2_PP_0009'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: '[PP] 생산품 자재-자재명'
@Metadata.ignorePropagatedAnnotations: true
@OData.entitySet.name: 'PlnbezSet'
@OData.publish: true
define view zcds_e2_pp_0009 as select from zte2mm0001
{
   key matnr as Matnr,
    maktx as Maktx
} where mtart = 'FERT';
