@AbapCatalog.sqlViewName: 'ZCDSV_E2_PP_0014'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: '[PP] 생산오더 대시보드 - 제품별 생산 비율'
@Metadata.ignorePropagatedAnnotations: true
@OData.entitySet.name: 'AufnrRatioSet'
@OData.publish: true
define view zcds_e2_pp_0014
  as select from zcds_e2_pp_0011
{
  key Gstrp,
  key Plnbez,
      Maktx,

      count(*)   as OrderCnt,
      sum(Gamng) as ProdQty,
      Meins      as Meins
}
group by
  Gstrp,
  Plnbez,
  Maktx,
  Meins
