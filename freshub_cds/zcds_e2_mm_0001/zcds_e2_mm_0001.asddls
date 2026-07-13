@AbapCatalog.sqlViewName: 'ZCDSV_E2_MM_0001'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: '[MM] 안전재고, 현재고 비교'
@Metadata.ignorePropagatedAnnotations: true
define view ZCDS_E2_MM_0001
  as select from    zte2mm0001      as a
    left outer join ZCDS_E2_PP_0001 as b on a.matnr = b.Matnr
{
  key   a.matnr                                                        as Matnr,
        a.safstk                                                       as Safstk,
        b.total_stock                                                  as total_stock,

        cast(b.total_stock as abap.fltp) / cast(a.safstk as abap.fltp) as stock_ratio

}
