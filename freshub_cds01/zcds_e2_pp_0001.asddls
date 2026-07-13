@AbapCatalog.sqlViewName: 'ZCDSV_E2_PP_0001'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: '[PP] 전체 재고 계산 cds view'
@Metadata.ignorePropagatedAnnotations: true
define view ZCDS_E2_PP_0001 as select from zte2mm0004 as a
inner join zte2mm0001 as b
on a.matnr = b.matnr
{

    key a.matnr as Matnr,
    
    sum(a.labst) as total_stock @<Semantics.quantity.unitOfMeasure: 'Meins',
    a.meins as Meins @<Semantics.unitOfMeasure: true ,
    
    b.ntgew * sum(a.labst) as total_weight @<Semantics.quantity.unitOfMeasure: 'Weight_meins',
    b.gewei as Weight_meins @<Semantics.unitOfMeasure: true 
    
} group by a.matnr, a.meins, b.ntgew, b.gewei;
 