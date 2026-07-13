@AbapCatalog.sqlViewName: 'ZCDSV_E2_MM_0009'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: '[MM] 공급업체별 단가 평균'
@Metadata.ignorePropagatedAnnotations: true
define view ZCDS_E2_MM_0009 with parameters 
    p_vbegd : zee2_mm_vbegd,
    p_vendd : zee2_mm_vendd
as select from zte2mm0006
{   
   key matnr                         as Matnr,

      sum( netpr )                  as TotalNetpr,
      count( distinct partner )     as PartnerCnt,

      waers                         as Waers
}
where vbegd = $parameters.p_vbegd
  and vendd = $parameters.p_vendd
group by
      matnr,
      waers;
