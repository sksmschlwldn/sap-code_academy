@AbapCatalog.sqlViewName: 'ZCDSV_E2_CO_0006'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: '[CO] 간접비 산정'
@Metadata.ignorePropagatedAnnotations: true
define view ZCDS_E2_CO_0006
  with parameters
    p_matnr : zee2_mm_matnr,
    p_gjahr : zee2_co_gjahr,
    p_perio : zee2_co_perio
  as select from zte2pp0005 as b // 라우팅 아이템
    inner join   zte2pp0001 as a on a.arbpl = b.arbpl // 작업
    inner join   zte2co0006 as c on  a.kostl = c.kostl
                                 and c.gjahr = $parameters.p_gjahr
                                 and c.perio = $parameters.p_perio // 원가 전표
                                 and c.wrttp = '01' // 계획
    inner join   zte2pp0008 as d on  d.matnr = $parameters.p_matnr
                                 and b.plnnr = d.plnnr // 자재 - 라우팅
{
  a.arbpl  as Arbpl, // 작업장
//  a.ktext  as Ktext, // 작업장 명
  a.begzt  as Begzt, // 가동 시작시간
  a.endzt  as Endzt, // 가동 종료 시간
  a.kostl  as Kostl, // 코스트센터
  b.plnnr  as Plnnr, // 공정id
  b.vornr  as Vornr, // 작업번호
  b.vgw02  as Vgw02 @<Semantics.quantity.unitOfMeasure: 'Vge02', // 작업 시간
  b.vge02  as Vge02 @<Semantics.unitOfMeasure: true, // 작업시간단위
  b.bmsch  as Bmsch @<Semantics.quantity.unitOfMeasure: 'Meins_quan', // 기준수량
  b.meins  as Meins_quan @<Semantics.unitOfMeasure: true, // 기준수량 단위
  c.belnr  as Belnr, // 전표번호
  c.buzei  as Buzei, // 전표 항목
  c.gjahr  as Gjahr, // 년
  c.perio  as Perio, // 월
  c.wkg00  as Wkg00 @<Semantics.amount.currencyCode: 'Waers', // 1달치금액
  c.waers  as Waers @<Semantics.currencyCode: true, // 통화
  c.ref_bn as Ref_bn // 뭔지

} 
