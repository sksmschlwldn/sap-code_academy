@AbapCatalog.sqlViewName: 'ZCDSV_E2_PP_0011'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: '[PP] 생산오더 전체 정보'
@Metadata.ignorePropagatedAnnotations: true
@OData.entitySet.name: 'AufnrAllSet'
@OData.publish: true
define view zcds_e2_pp_0011
  as select from zte2pp0009 as a
    inner join   zte2mm0001 as b on a.plnbez = b.matnr
{
  key a.aufnr  as Aufnr,
      a.auart  as Auart,
      a.plnum  as Plnum,
      a.plpos  as Plpos,
      a.vbeln  as Vbeln,
      a.posnr  as Posnr,
      a.plnbez as Plnbez,
      b.maktx  as Maktx,
      a.charg  as Charg,
      a.stlnr  as Stlnr,
      a.plnnr  as Plnnr,
      a.stat   as Stat,
      a.gamng  as Gamng @<Semantics.quantity.unitOfMeasure: 'Meins',
      a.meins  as Meins @<Semantics.unitOfMeasure: true,
      a.apstat as Apstat,
      a.gstrp  as Gstrp,
      a.gltrp  as Gltrp,
      a.ordat  as Ordat,
      a.pernr  as Pernr,
      case
        when a.apstat = '1' then '01'
        when a.apstat = '2' and a.stat = ' ' then '02'
        when a.apstat = '2' and a.stat = '1' then '03'
        when a.apstat = '2' and a.stat = '2' then '04'
        when a.apstat = '3' then '05'
        when a.apstat = '2' and a.stat = '3' then '06'
        else '99'
      end as MonStatus,

      case
        when a.apstat = '1' then '승인대기'
        when a.apstat = '2' and a.stat = ' ' then '생산대기'
        when a.apstat = '2' and a.stat = '1' then '생산중'
        when a.apstat = '2' and a.stat = '2' then '생산완료'
        when a.apstat = '3' then '반려'
        when a.apstat = '2' and a.stat = '3' then '생산취소'
        else '기타'
      end as MonStatusTxt

}
