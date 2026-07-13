@AbapCatalog.sqlViewName: 'ZCDV_E2_PP_0004'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: '[PP] 생산 소요 시'
@Metadata.ignorePropagatedAnnotations: true
define view ZCDS_E2_PP_0004
  with parameters
    p_matnr : zee2_mm_matnr, // 생산
    p_gamng : zee2_pp_gamng
  as select from zte2pp0008 as a
    inner join   zte2pp0005 as b on a.plnnr = b.plnnr
    inner join   zte2pp0001 as c on b.arbpl = c.arbpl
{

      // ( $parameters.p_gamng * b.vgw02 ) as Req_time @<Semantics.quantity.unitOfMeasure: 'Vge02',
      // vge02                             as Vge02 @<Semantics.unitOfMeasure: true

  key b.vornr                       as Vornr,
      c.ktext                       as Ktext,
      b.ltxa1                       as Ltxa1,
      b.vgw02                       as Vgw02,
      b.vge02                       as Vge02 @<Semantics.unitOfMeasure: true,
      // (생산지시수량 / 기준수량) * 단위당 시간
      cast($parameters.p_gamng as abap.fltp ) / cast(b.bmsch as abap.fltp )
       * cast(b.vgw02 as abap.fltp) as Req_Time @<Semantics.quantity.unitOfMeasure: 'Vge02',
      b.bmsch                       as Bmsch @<Semantics.quantity.unitOfMeasure: 'Meins',
      b.meins                       as Meins @<Semantics.unitOfMeasure: true
}
where
  a.matnr = $parameters.p_matnr;
