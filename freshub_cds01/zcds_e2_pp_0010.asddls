@AbapCatalog.sqlViewName: 'ZCDSV_E2_PP_0010'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: '[PP] 생산오더 Srch Help'
@Metadata.ignorePropagatedAnnotations: true
@OData.entitySet.name: 'AufnrSet'
@OData.publish: true
define view zcds_e2_pp_0010
  as select from zte2pp0009 as a
    inner join   zte2mm0001 as b on a.plnbez = b.matnr
{
  key a.aufnr  as Aufnr,
      a.plnbez as Plnbez,
      b.maktx  as Maktx,
      a.gamng  as Gamng @<Semantics.quantity.unitOfMeasure: 'Meins',
      a.meins  as Meins @<Semantics.unitOfMeasure: true,
      a.gstrp  as Gstrp,
      a.gltrp  as Gltrp
} where a.apstat = '2';
