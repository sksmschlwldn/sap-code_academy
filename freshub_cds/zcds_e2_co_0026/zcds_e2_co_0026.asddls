@AbapCatalog.sqlViewName: 'ZCDSV_E2_CO_0026'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: '[CO] 월별 재료비 합 -  전체'
@Metadata.ignorePropagatedAnnotations: true
define view ZCDS_E2_CO_0026 with parameters
    p_matnr : zee2_mm_matnr,
    p_gjahr : zee2_co_gjahr,
    p_perio : zee2_co_perio
  as select from zte2co0007 as a
    inner join ZCDS_E2_CO_0025 as b
      on a.aufnr = b.Aufnr
{
  key b.Matnr        as Matnr,
      b.Maktx        as Maktx,
      b.Dislf        as Dislf @<Semantics.quantity.unitOfMeasure: 'Meins',
      b.Gewei        as Gewei  @<Semantics.unitOfMeasure: true,
      b.Ntgew        as Ntgew @<Semantics.quantity.unitOfMeasure: 'Gewei',
      
      sum( b.Bdmng ) as Bdmng @<Semantics.quantity.unitOfMeasure: 'Meins',
      b.Meins        as Meins @<Semantics.unitOfMeasure: true,

      sum( b.Dmatl ) as Dmatl @<Semantics.amount.currencyCode: 'Waers',
      b.Waers        as Waers @<Semantics.currencyCode: true
}
where a.matnr = $parameters.p_matnr
  and a.gjahr = $parameters.p_gjahr
  and a.perio = $parameters.p_perio
group by
  b.Matnr,
  b.Maktx,
  b.Meins,
  b.Waers,
  b.Dislf,
  b.Gewei,
  b.Ntgew
