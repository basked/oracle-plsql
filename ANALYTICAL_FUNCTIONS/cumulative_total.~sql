-- аналитический отчёт с нарастающим итогом по профессиям
EXPLAIN PLAN FOR 
SELECT d.department_name,
       e.job_id,
       e.salary,
       /*dep_job_sum - сумма нарастающий итог */
       SUM(e.salary) OVER(PARTITION BY d.department_name ORDER BY e.salary) AS dep_job_sum,
       SUM(e.salary) OVER(PARTITION BY d.department_name) AS dep_sum,
       SUM(e.salary) over() AS total_sum
  FROM departments d
  LEFT JOIN employees e
   USING(department_id )
 WHERE e.job_id IS NOT NULL
 ORDER BY 1
 OFFSET 1 ROWS
 FETCH NEXT 5  ROWS ONLY;
   
SELECT 
    PLAN_TABLE_OUTPUT 
FROM 
    TABLE(DBMS_XPLAN.DISPLAY());      
