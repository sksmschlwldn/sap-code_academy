@AbapCatalog.sqlViewName: 'ZCDSV_E2_CO_0001'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: '[CO] 재료비 산정'
@Metadata.ignorePropagatedAnnotations: true
define view ZCDS_E2_CO_0001
  with parameters
    p_matnr : zee2_mm_matnr,
    p_spmon : zee2_mm_spmon
  as select from zte2pp0002 as a
    inner join   zte2pp0003 as b on a.stlnr = b.stlnr
    inner join   zte2mm0001 as c on b.idnrk = c.matnr
  // inner join   zte2mm0006 as d on b.idnrk = d.matnr
    inner join   zte2mm0021 as d on b.idnrk = d.matnr
{
  key b.idnrk                                          as Matnr,
      c.maktx                                          as Maktx,
      c.mtart                                          as Mtart,
      b.menge                                          as Bmeng @<Semantics.quantity.unitOfMeasure: 'Meins', // 1개당 필요수량
      b.meins                                          as Meins @<Semantics.unitOfMeasure: true, // 1개당 단위

    /*  case
        when b.idnrk like 'P%'
       then  ( b.menge * d.stprs )
       else
       cast(coalesce( b.menge * d.stprs , 0 ) as abap.fltp)
       / cast( coalesce(c.ntgew, 0) as abap.fltp ) end as Dmbtr @<Semantics.amount.currencyCode: 'Waers',
*/

   /*   case
        when b.idnrk like 'P%'
        then b.menge
       else
       cast(coalesce( b.menge * c.dislf , 0 ) as abap.fltp)
       / cast( coalesce(c.ntgew, 0) as abap.fltp ) end as Bmeng_u @<Semantics.quantity.unitOfMeasure: 'Meins_u',
       
    */   
      c.dislf                                          as Dislf @<Semantics.quantity.unitOfMeasure: 'Meins_u', //1Pack
      c.meins                                          as Meins_u @<Semantics.unitOfMeasure: true, // Pack
      c.ntgew                                          as Ntgew @<Semantics.quantity.unitOfMeasure: 'Meins', // 1000g
      d.stprs                                          as Stprs @<Semantics.amount.currencyCode: 'Waers',  // 1pack당 가
      d.waers                                          as Waers @<Semantics.currencyCode: true, // 통화키
      // 누기 빼고 !!! 
      case when b.idnrk like 'P%' then ( b.menge * d.stprs )
           else coalesce( b.menge * d.stprs , 0 ) end  as Dmbtr_raw 
}
where
      a.matnr = $parameters.p_matnr
  and d.spmon = $parameters.p_spmon;
