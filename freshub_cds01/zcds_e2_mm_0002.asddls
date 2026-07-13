@AbapCatalog.sqlViewName: 'ZCDSV_E2_MM_0002'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: '[MM] 안전재고, 현재고 비율별'
@Metadata.ignorePropagatedAnnotations: true
define view ZCDS_E2_MM_0002
  as select from ZCDS_E2_MM_0001
{
  key Matnr,
      Safstk,
      total_stock,
      case
      -- 1. 위험: 90% 미만 (0.9 미만)
      when stock_ratio < 0.9
      then '위험'

      -- 2. 주의: 90% 이상 ~ 95% 미만
      when stock_ratio >= 0.9 and stock_ratio < 0.95
      then '주의'

      -- 3. 정상: 95% 이상 ~ 105% 이하
      when stock_ratio >= 0.95 and stock_ratio <= 1.05
      then '정상'

      -- 4. 과잉: 105% 초과 (1.05 초과)
      when stock_ratio > 1.05
      then '과잉'

      else '확인필요'

      end as stock_status
}
