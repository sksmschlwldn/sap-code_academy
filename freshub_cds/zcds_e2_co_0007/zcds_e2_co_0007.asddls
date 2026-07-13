@AbapCatalog.sqlViewName: 'ZCDSV_E2_CO_0007'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: '[CO] 오더별 재료비 계산'
@Metadata.ignorePropagatedAnnotations: true
define view ZCDS_E2_CO_0007
  with parameters
    p_aufnr : zee2_pp_aufnr
  as select from zte2pp0010 as a
    inner join   zte2mm0005 as b on  a.matnr = b.matnr
                                 and a.charg = b.charg
    inner join   zte2mm0001 as c on a.matnr = c.matnr
{
  key a.aufnr           as Aufnr,
  key a.matnr           as Matnr,
  key a.charg           as Charg,

      a.bdmng           as Bdmng @<Semantics.quantity.unitOfMeasure: 'Meins',
      a.meins           as Meins @<Semantics.unitOfMeasure: true,
      b.netpr           as Netpr @<Semantics.amount.currencyCode: 'Waers',
      a.bdmng * b.netpr as Dmbtr @<Semantics.amount.currencyCode: 'Waers',
      b.waers           as Waers @<Semantics.currencyCode: true
}
where
  a.aufnr = $parameters.p_aufnr;
