@AbapCatalog.sqlViewName: 'ZCDSV_E2_CO_0003'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: '[CO] 배부 사이클 헤더 조회'
@Metadata.ignorePropagatedAnnotations: true
define view ZCDS_E2_CO_0003
  with parameters
    p_kokrs : zee2_co_kokrs
  as select from zte2co0013 as a
    inner join   zte2co0014 as b on  a.kokrs = b.kokrs
                                 and a.cycle = b.cycle
                                 and a.endda = b.endda
    inner join   zte2co0015 as c on  b.kokrs = c.kokrs
                                 and b.cycle = c.cycle
                                 and b.endda = c.endda
                                 and b.segnr = c.segnr
{
  key a.kokrs,
  key a.cycle,
  key a.endda,
  key b.segnr,
  key c.rcv_kostl,
      a.text,
      a.altyp,
      b.snd_kostl,
      b.snd_kstar,
      b.al_kstar,
      c.rcv_rule,
      c.stagr,
      c.perct
}
where
  a.kokrs = $parameters.p_kokrs;
