@AbapCatalog.sqlViewName: 'ZCDSV_E2_PP_0002'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: '[PP] 자재소요량 계산'
@Metadata.ignorePropagatedAnnotations: true
define view ZCDS_E2_PP_0002
  with parameters
    p_matnr : zee2_mm_matnr, // 생산
    p_gamng : zee2_pp_gamng, // 생산 지시 수 (몇개생산?)
    p_gstrp : zee2_pp_pm_ordgstrp
  as select from    zte2pp0002                                       as a
    inner join      zte2pp0003                                       as b on a.stlnr = b.stlnr
    inner join      zte2mm0001                                       as c on b.idnrk = c.matnr
    left outer join ZCDS_E2_PP_0005( p_gstrp : $parameters.p_gstrp ) as d on b.idnrk = d.Matnr
{
  key b.idnrk                                                                                   as Matnr, // 자재 id (idnrk)
      c.maktx                                                                                   as Maktx, // 자재명
      // 기준 수량 (1단위당 필요한 ) , g
      b.menge                                                                                   as Menge @<Semantics.quantity.unitOfMeasure: 'Meins',
      b.meins                                                                                   as Meins @<Semantics.unitOfMeasure: true, // 단위 (G)
      // 소요량 (생산에 필요한 총 양)
      ( b.menge * $parameters.p_gamng )                                                         as Req_qty_g @<Semantics.quantity.unitOfMeasure: 'Meins', // (G) or EA

      case
       when b.idnrk like 'P%'
       then  ( b.menge * $parameters.p_gamng )  // 이거 포장재면 그대
      else
      cast( b.menge * $parameters.p_gamng as abap.fltp ) / cast( c.ntgew as abap.fltp )
      end                                                                                       as Req_qty_u @<Semantics.quantity.unitOfMeasure: 'Unit_meins', // 실제 단위


      // 가용재고 (현재 창고에서 쓸수있는) unit
      coalesce(d.total_stock, 0)                                                                as Avail_qty_u @<Semantics.quantity.unitOfMeasure: 'Unit_meins', // G이 아님
      //창고에서 쓸 수 있는 g??
      case
        when b.idnrk like 'P%' then  coalesce(d.total_stock, 0)
        else coalesce(d.total_weight, 0)
      end                                                                                      as Avail_qty_g @<Semantics.quantity.unitOfMeasure: 'Meins',
      c.meins                                                                                   as Unit_meins, // 실제 사용되는 단위
      // 재고가 모자란 양


      // ( coalesce(d.total_stock, 0) - ( b.menge * $parameters.p_gamng ) )                     as Shortage @<Semantics.quantity.unitOfMeasure: 'Meins',
      //   coalesce(d.total_weight, 0) - b.menge * $parameters.p_gamng                          as Shortage_g @<Semantics.quantity.unitOfMeasure: 'Meins',
      //   cast(coalesce(d.total_stock, 0) as abap.fltp)
      //   -  cast( b.menge * $parameters.p_gamng as abap.fltp ) / cast( c.ntgew as abap.fltp ) as Shortage_u @<Semantics.quantity.unitOfMeasure: 'Unit_meins',



      case
        when b.idnrk like 'P%' // 포장재면 ea임
        then coalesce(d.total_stock, 0) - ( b.menge * $parameters.p_gamng ) // ea로 나옴
        else  cast(coalesce(d.total_stock, 0) as abap.fltp)
       -  cast( b.menge * $parameters.p_gamng as abap.fltp ) / cast( c.ntgew as abap.fltp ) end as Shortage_u @<Semantics.quantity.unitOfMeasure: 'Unit_meins',

      case
        when b.idnrk like 'P%'
        then cast(0  as abap.fltp)
      //   then coalesce(d.total_stock, 0) - ( b.menge * $parameters.p_gamng )
        else coalesce(d.total_weight, 0) - b.menge * $parameters.p_gamng  end                   as Shortage_g @<Semantics.quantity.unitOfMeasure: 'Meins'

}
where
  a.matnr = $parameters.p_matnr;
