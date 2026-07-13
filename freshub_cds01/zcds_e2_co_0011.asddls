@AbapCatalog.sqlViewName: 'ZCDSV_E2_CO_0011'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: '[CO] 자재별 월 생산오더'
@Metadata.ignorePropagatedAnnotations: true
define view zcds_e2_co_0011 with parameters
    p_matnr : zee2_mm_matnr,
    p_begda : dats, // 시작일
    p_endda : dats // 종료일 
  as select from 
  // zte2mm0001 as a inner join 
  zte2pp0009 as b
    inner join zte2pp0012 as c on c.aufnr = b.aufnr
    inner join zte2pp0015 as d on c.prueflos = d.prueflos
    left outer join zte2co0007 as e on e.aufnr = b.aufnr
{
  b.aufnr as Aufnr,
  b.plnbez as Matnr,
  c.qiactdat as Qiactdat, // 실제생산일 (입고일)
  b.gamng as Gamng @<Semantics.quantity.unitOfMeasure: 'Meins', // 생산 예정수량
  d.ok_qty as Okqty @<Semantics.quantity.unitOfMeasure: 'Meins', // 실제 생산량'
  e.dmatl as Dmatl @<Semantics.amount.currencyCode: 'Waers',
  e.dlabr as Dlabr @<Semantics.amount.currencyCode: 'Waers',
  e.mohad as Mohad  @<Semantics.amount.currencyCode: 'Waers',
  e.wkg00 as Wkg00 @<Semantics.amount.currencyCode: 'Waers',
  e.stprs as Stprs @<Semantics.amount.currencyCode: 'Waers',
  e.waers as Waers @<Semantics.currencyCode: true,
  e.meins as Meins @<Semantics.unitOfMeasure: true
} where b.plnbez = $parameters.p_matnr
   and c.qiactdat between $parameters.p_begda
                      and $parameters.p_endda;
