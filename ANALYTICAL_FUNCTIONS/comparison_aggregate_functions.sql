-- Без GROUP BY 
SELECT d.department_name, e_out.salary AS max_salary
  FROM departments d
  LEFT JOIN employees e_out
    ON d.department_id = e_out.department_id
 WHERE e_out.salary IN (SELECT MAX(salary) FROM employees e_in WHERE e_in.department_id=e_out.department_id)
ORDER BY d.department_name

/*
 Plan Hash Value  : 1152507038 

-------------------------------------------------------------------------------------------
| Id  | Operation                         | Name        | Rows | Bytes  | Cost | Time     |
-------------------------------------------------------------------------------------------
|   0 | SELECT STATEMENT                  |             | 3267 | 153549 |   10 | 00:00:01 |
| * 1 |   FILTER                          |             |      |        |      |          |
|   2 |    SORT GROUP BY                  |             | 3267 | 153549 |   10 | 00:00:01 |
| * 3 |     HASH JOIN                     |             | 3267 | 153549 |    9 | 00:00:01 |
|   4 |      MERGE JOIN                   |             |  106 |   4240 |    6 | 00:00:01 |
|   5 |       TABLE ACCESS BY INDEX ROWID | DEPARTMENTS |   27 |    567 |    2 | 00:00:01 |
|   6 |        INDEX FULL SCAN            | DEPT_ID_PK  |   27 |        |    1 | 00:00:01 |
| * 7 |       SORT JOIN                   |             |  107 |   2033 |    4 | 00:00:01 |
|   8 |        TABLE ACCESS FULL          | EMPLOYEES   |  107 |   2033 |    3 | 00:00:01 |
|   9 |      TABLE ACCESS FULL            | EMPLOYEES   |  107 |    749 |    3 | 00:00:01 |
-------------------------------------------------------------------------------------------

Predicate Information (identified by operation id):
------------------------------------------
* 1 - filter("E_OUT"."SALARY"=MAX("SALARY"))
* 3 - access("E_IN"."DEPARTMENT_ID"="E_OUT"."DEPARTMENT_ID")
* 7 - access("D"."DEPARTMENT_ID"="E_OUT"."DEPARTMENT_ID")
* 7 - filter("D"."DEPARTMENT_ID"="E_OUT"."DEPARTMENT_ID")

*/
--с учётом GROUP BY 
SELECT d.department_name,  MAX(e.salary)  AS max_salary
  FROM departments d
  LEFT JOIN employees e
    ON d.department_id = e.department_id
    WHERE e.department_id IS NOT NULL
 GROUP BY d.department_name
ORDER BY d.department_name

/*
Plan Hash Value  : 374846896 

----------------------------------------------------------------------------------------
| Id  | Operation                       | Name        | Rows | Bytes | Cost | Time     |
----------------------------------------------------------------------------------------
|   0 | SELECT STATEMENT                |             |    4 |    92 |    7 | 00:00:01 |
|   1 |   SORT GROUP BY                 |             |    4 |    92 |    7 | 00:00:01 |
|   2 |    MERGE JOIN                   |             |  105 |  2415 |    6 | 00:00:01 |
|   3 |     TABLE ACCESS BY INDEX ROWID | DEPARTMENTS |   27 |   432 |    2 | 00:00:01 |
|   4 |      INDEX FULL SCAN            | DEPT_ID_PK  |   27 |       |    1 | 00:00:01 |
| * 5 |     SORT JOIN                   |             |  106 |   742 |    4 | 00:00:01 |
| * 6 |      TABLE ACCESS FULL          | EMPLOYEES   |  106 |   742 |    3 | 00:00:01 |
----------------------------------------------------------------------------------------

Predicate Information (identified by operation id):
------------------------------------------
* 5 - access("D"."DEPARTMENT_ID"="E"."DEPARTMENT_ID")
* 5 - filter("D"."DEPARTMENT_ID"="E"."DEPARTMENT_ID")
* 6 - filter("E"."DEPARTMENT_ID" IS NOT NULL)
*/


