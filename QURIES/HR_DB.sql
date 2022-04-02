-- сумма ЗП по каждому подразделению
SELECT DECODE(department_name, NULL, ' Всего', department_name) AS department_name,
       listagg(last_name, ', ') WITHIN GROUP(ORDER BY last_name) empl_list,
       SUM(salary) sum_dep
  FROM EMployees
  JOIN departments
 USING (department_id)
 GROUP BY ROLLUP(department_name)
 -------------------------------------------
