/** Иерархические запросы 
https://docs.oracle.com/cd/B19306_01/server.102/b14200/queries003.htm
*/

-- DML Commands
SELECT e.employee_id, LEVEL, lpad('-', LEVEL, '-') || e.first_name||' '||e.last_name AS FIO
  FROM employees e
CONNECT BY PRIOR e.employee_id = e.manager_id
  START WITH e.employee_id = 100
   ORDER SIBLINGS BY  e.first_name||' '||e.last_name
----------------------------------------------------------------


SELECT last_name "Employee", CONNECT_BY_ISCYCLE "Cycle",
   LEVEL, SYS_CONNECT_BY_PATH(last_name, '/') "Path"
   FROM employees
   WHERE level <= 3 AND department_id = 80
   START WITH last_name = 'King'
   CONNECT BY NOCYCLE PRIOR employee_id = manager_id AND LEVEL <= 5;

