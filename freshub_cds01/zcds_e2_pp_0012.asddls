@AbapCatalog.sqlViewName: 'ZCDSV_E2_PP_0012'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: '[PP] 생산오더 대시보드 - KPI 정보'
@Metadata.ignorePropagatedAnnotations: true
@OData.entitySet.name: 'KpiSet'
@OData.publish: true
define view zcds_e2_pp_0012
  as select from zcds_e2_pp_0011
{
  key Gstrp,
  key MonStatus,
      MonStatusTxt,

      count(*)   as OrderCnt,
      sum(Gamng) as PlanQty,
      Meins
}
group by
  Gstrp,
  MonStatus,
  MonStatusTxt,
  Meins
