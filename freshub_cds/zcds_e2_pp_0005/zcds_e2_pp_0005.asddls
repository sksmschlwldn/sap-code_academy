@AbapCatalog.sqlViewName: 'ZCDSV_E2_PP_0005'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: '[PP] 전체 재고 계산 (특정 날짜 이후의 유통기한 계산 포함)'
@Metadata.ignorePropagatedAnnotations: true
define view ZCDS_E2_PP_0005
  with parameters
    p_gstrp : zee2_pp_pm_ordgstrp
  as select from zte2mm0004 as a
    inner join   zte2mm0001 as b on a.matnr = b.matnr
{
  key a.matnr                as Matnr,

      sum(a.labst)           as total_stock @<Semantics.quantity.unitOfMeasure: 'Meins',
      a.meins                as Meins @<Semantics.unitOfMeasure: true,

      b.ntgew * sum(a.labst) as total_weight @<Semantics.quantity.unitOfMeasure: 'Weight_meins',
      b.gewei                as Weight_meins @<Semantics.unitOfMeasure: true

}
where
  a.vfdat >= $parameters.p_gstrp
group by
  a.matnr,
  a.meins,
  b.ntgew,
  b.gewei;
