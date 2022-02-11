WITH all_month AS
 (SELECT EXTRACT(MONTH FROM add_MONTHS(SYSDATE, LEVEL)) id_month,
         to_char(add_MONTHS(SYSDATE, LEVEL),
                 'FMMonth',
                 'NLS_DATE_LANGUAGE=RUSSIAN') AS mon
    FROM dual
  CONNECT BY LEVEL < 12),
empl_month AS
 (SELECT EXTRACT(MONTH FROM jh.start_date) id_month,
         jh.start_date,
         jh.end_date,
         e.first_name,
         e.salary,
         d.department_name,
         j.job_title
    FROM job_history jh
    LEFT JOIN employees e
      ON jh.employee_id = e.employee_id
    LEFT JOIN departments d
      ON jh.department_id = d.department_id
    LEFT JOIN jobs j
      ON jh.job_id = j.job_id)
--------------------------------
SELECT all_month.id_month,
       empl_month.start_date,
       empl_month.first_name,
       empl_month.salary,
       SUM(empl_month.salary) OVER(PARTITION BY EXTRACT(YEAR FROM empl_month.start_date)) sum_first_name
  FROM all_month
  LEFT JOIN empl_month
    ON all_month.id_month = empl_month.id_month
 ORDER BY 1
