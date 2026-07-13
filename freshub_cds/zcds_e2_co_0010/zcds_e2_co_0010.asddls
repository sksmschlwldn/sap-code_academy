@AbapCatalog.sqlViewName: 'ZCDSV_E2_CO_0010'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: '[CO] 오더별 간접비 계산'
@Metadata.ignorePropagatedAnnotations: true
define view zcds_e2_co_0010
  with parameters
    p_aufnr : zee2_pp_aufnr,
    p_gjahr : zee2_co_gjahr,
    p_perio : zee2_co_perio
  as select from zcds_e2_co_0013( p_gjahr : $parameters.p_gjahr, p_perio : $parameters.p_perio ) as a
    inner join   zte2pp0001                                                                      as b on a.Kostl = b.kostl
    inner join   zte2pp0005                                                                      as c on c.arbpl = b.arbpl
    inner join   zte2pp0009                                                                      as d on c.plnnr = d.plnnr
    inner join   zte2pp0011                                                                      as e on  e.aufnr = $parameters.p_aufnr
                                                                                                      and e.vornr = c.vornr
{
  c.vornr as Vornr,
  a.Kostl as Kostl,
  a.Kstar as Kstar,
  a.Gjahr as Gjahr,
  a.Perio as Perio,
  a.Ktext as Ktext,
  a.Wkg00 as Wkg00 @<Semantics.amount.currencyCode: 'Waers',
  a.Waers as Waers @<Semantics.currencyCode: true,
  e.ismnw as Ismnw @<Semantics.quantity.unitOfMeasure: 'Vge02',
  e.vge02 as Vge02 @<Semantics.unitOfMeasure: true

}
where
       d.aufnr = $parameters.p_aufnr
  and(
       a.Kstar = '0050000001'
    or a.Kstar = '0050000002'
    or a.Kstar = '0050000003'
    or a.Kstar = '0050000004'
    or a.Kstar = '0050000005'
    or a.Kstar = '0050000023'
    or a.Kstar = '0050000024'
    or a.Kstar = '0051000001'
    or a.Kstar = '0051000002'
    or a.Kstar = '0051000003'
    or a.Kstar = '0051000004'
    or a.Kstar = '0051000005'
    or a.Kstar = '0051000006'

  )
