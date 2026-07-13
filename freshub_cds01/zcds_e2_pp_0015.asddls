@AbapCatalog.sqlViewName: 'ZCDSV_E2_PP_0015'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: '[PP] 생산오더 대시보드 - 오늘의 생산오더'
@Metadata.ignorePropagatedAnnotations: true
@OData.entitySet.name: 'TodayAufnrSet'
@OData.publish: true
define view zcds_e2_pp_0015 
 as select from zcds_e2_pp_0011 as a 
 left outer join zte2hr0002 as b on a.Pernr = b.pernr
{
  key a.Aufnr,

      a.Plnbez,
      a.Maktx,
      a.Gamng,
      a.Meins,
      a.Gstrp,
      a.Gltrp,

      a.Apstat,
      a.Stat,
      a.MonStatus,
      a.MonStatusTxt,

      a.Pernr,
      b.sname
}
