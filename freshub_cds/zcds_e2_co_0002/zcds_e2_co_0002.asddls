@AbapCatalog.sqlViewName: 'ZCDSV_E2_CO_0002'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: '[CO] 노무비 산정'
@Metadata.ignorePropagatedAnnotations: true
define view ZCDS_E2_CO_0002
  with parameters
    p_matnr : zee2_mm_matnr,
    p_gjahr : zee2_co_gjahr,
    p_perio : zee2_co_perio
  as select from    zte2pp0004 as a // 라우팅 헤더
    inner join      zte2pp0005 as b  on a.plnnr = b.plnnr // 라우팅 아이템
    inner join      zte2pp0001 as c  on c.arbpl = b.arbpl // 작업장
    inner join      zte2co0002 as d  on c.kostl = d.kostl // 코스트센터
    inner join      zte2pp0008 as e  on e.plnnr = b.plnnr // 라우팅 - 자재
    left outer join zte2co0004 as p1 on  p1.kostl = c.kostl
                                     and p1.lstar = b.lstar
                                     and p1.gjahr = $parameters.p_gjahr
                                     and p1.perio = $parameters.p_perio
                                     and p1.versn = '001'
                                     and p1.lstar = 'LABR'
    left outer join zte2co0004 as p2 on  p2.kostl = c.kostl
                                     and p2.lstar = b.lstar2
                                     and p2.gjahr = $parameters.p_gjahr
                                     and p2.perio = $parameters.p_perio
                                     and p2.versn = '001'
                                     and p2.lstar = 'LABR'
    left outer join zte2co0004 as p3 on  p3.kostl = c.kostl
                                     and p3.lstar = b.lstar3
                                     and p3.gjahr = $parameters.p_gjahr
                                     and p3.perio = $parameters.p_perio
                                     and p3.versn = '001'
                                     and p3.lstar = 'LABR'



{
      // 자재
  // key e.matnr        as Matnr,
  // key e.werks        as Werks,

      // 라우팅
  key a.plnnr        as Plnnr,
  key b.vornr        as Vornr,

      // 작업장
      b.arbpl        as Arbpl,
      c.kostl        as Kostl,
      c.ktext        as ArbplTxt,

      // 공정
      b.ltxa1        as OperText,

      // 작업시간
      b.vgw02        as StdTime,
      b.vge02        as TimeUnit,

      // 기준수량
      b.bmsch        as BaseQty @<Semantics.quantity.unitOfMeasure: 'Meins',
      b.meins        as Meins @<Semantics.unitOfMeasure: true,

      // 활동유형
      b.lstar        as Lstar1,
      b.lstar2       as Lstar2,
      b.lstar3       as Lstar3,

      // 활동유형 단가
      p1.tkg00       as Price1 @<Semantics.amount.currencyCode: 'Waers',
      p2.tkg00       as Price2 @<Semantics.amount.currencyCode: 'Waers',
      p3.tkg00       as Price3 @<Semantics.amount.currencyCode: 'Waers',

      // 통화
      coalesce( p1.waers,
          p2.waers ) as Waers @<Semantics.currencyCode: true
}
where
  e.matnr = $parameters.p_matnr;
