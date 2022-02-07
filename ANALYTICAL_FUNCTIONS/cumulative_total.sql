﻿-- аналитический отчёт с нарастающим итогом по профессиям
SELECT d.department_name,
       e.job_id,
       e.salary,
       /*dep_job_sum - сумма нарастающий итог */
       SUM(e.salary) OVER(PARTITION BY d.department_name ORDER BY e.salary) AS dep_job_sum,
       SUM(e.salary) OVER(PARTITION BY d.department_name) AS dep_sum,
       SUM(e.salary) over() AS total_sum
  FROM departments d
  LEFT JOIN employees e
    ON d.department_id = e.department_id
 WHERE e.job_id IS NOT NULL
   
