@AbapCatalog.sqlViewName: 'ZCDV_E2_PP_0003'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: '[PP] 부족수량'
@Metadata.ignorePropagatedAnnotations: true
define view ZCDS_E2_PP_0003 // 생산 지시 수 (몇개생산?)
  with parameters
    p_matnr : matnr,
    p_gamng : gamng,
    p_gstrp : datum
  as select from ZCDS_E2_PP_0002( p_matnr : $parameters.p_matnr,
                                  p_gamng : $parameters.p_gamng,
                                  p_gstrp : $parameters.p_gstrp)
{
  key Matnr,
      Maktx,
      Menge,
      Meins,
      Req_qty_g,
      Avail_qty_u,
      Req_qty_u,
      Avail_qty_g,
      Unit_meins,
      case
      when Shortage_g > 0 then 0
      else abs(Shortage_g)
      end as Shortage_g,
      case
      when Shortage_g >= 0 then '@0V@'
      else '@0W@'
      end as Status,
      case
      when Shortage_g >= 0  then '투입 가능'
      else '투입 불가'
      end as Status_txt,
      case
      when Shortage_u > 0 then 0
      else abs(Shortage_u)
      end as Shortage_u
};
