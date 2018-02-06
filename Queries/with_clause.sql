/* użycie klauzuli with razem z funkcją analityczną*/

with tmp as (select
add_months(sysdate,-12-level) mies
  from dual
  CONNECT BY LEVEL<12
),
  kpi_tbl as (
select
  to_char(t.mies,'yyyy_mm') mth, nvl(round(sum(KPI_SLA_D)/count(*),2),1) kpi
from tmp t LEFT OUTER JOIN dane d on to_char(t.mies,'yyyy_mm')=to_char(d.CLOSE_DATE,'yyyy_mm')
GROUP BY to_char(t.mies,'yyyy_mm')
ORDER BY 1)
SELECT
  mth,
  kpi,
  round(avg(kpi)
        OVER (
          ORDER BY mth ROWS BETWEEN 5 PRECEDING AND CURRENT ROW ), 2) avg_kpi
FROM kpi_tbl;
