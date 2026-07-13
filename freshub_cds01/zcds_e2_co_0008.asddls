@AbapCatalog.sqlViewName: 'ZCDSV_E2_CO_0008'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: '[CO] 오더별 재료비 계산 - 배치합'
@Metadata.ignorePropagatedAnnotations: true
define view ZCDS_E2_CO_0008
  with parameters
    p_aufnr : zee2_pp_aufnr
  as select from ZCDS_E2_CO_0007(
                 p_aufnr : $parameters.p_aufnr
                 )
{
  key Aufnr,
  key Matnr,
      sum( Bdmng ) as Bdmng @<Semantics.quantity.unitOfMeasure: 'Meins',
      Meins        as Meins @<Semantics.unitOfMeasure: true,

      sum( Dmbtr ) as Dmatl @<Semantics.amount.currencyCode: 'Waers',
      Waers        as Waers @<Semantics.currencyCode: true
}
group by
  Aufnr,
  Matnr,
  Meins,
  Waers;
