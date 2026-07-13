@AbapCatalog.sqlViewName: 'ZCDSV_E2_CO_0025'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: '[CO] 월별 재료비 합'
@Metadata.ignorePropagatedAnnotations: true
define view ZCDS_E2_CO_0025
  as select from zte2pp0010 as b
    inner join zte2mm0001 as c
      on b.matnr = c.matnr
    inner join zte2mm0005 as d
      on b.matnr = d.matnr
     and b.charg = d.charg
{
  key b.aufnr as Aufnr,
  key b.matnr as Matnr,
      c.maktx as Maktx,
      c.dislf as Dislf @<Semantics.quantity.unitOfMeasure: 'Meins', 
      c.ntgew as Ntgew @<Semantics.quantity.unitOfMeasure: 'Gewei',
      c.gewei as Gewei @<Semantics.unitOfMeasure: true,

      b.bdmng as Bdmng @<Semantics.quantity.unitOfMeasure: 'Meins',
      b.meins as Meins @<Semantics.unitOfMeasure: true, 

      cast( b.bdmng * d.netpr as abap.curr( 15, 2 ) ) as Dmatl @<Semantics.amount.currencyCode: 'Waers',

      d.waers as Waers @<Semantics.currencyCode: true
}
