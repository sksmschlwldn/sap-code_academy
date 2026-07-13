@AbapCatalog.sqlViewName: 'ZCDSV_E2_PP_0013'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: '[PP] 생산오더 대시보드 - 최근 7일 생산량 추이'
@Metadata.ignorePropagatedAnnotations: true
@OData.entitySet.name: 'AufnrYieldSet'
@OData.publish: true
define view zcds_e2_pp_0013
  as select from zcds_e2_pp_0011
{
  key Gstrp      as ProdDate,

      count(*)   as OrderCnt,
      sum(Gamng) as ProdQty,
      Meins      as Meins
}
group by
  Gstrp,
  Meins
