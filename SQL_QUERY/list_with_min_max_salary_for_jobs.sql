/*
Запрос выводит зарплаты по каждой профессии и актульным пользователям 
*/

WITH
-- Список работников которые работают в данный момент
employees_act AS
 (SELECT e.employee_id,
         e.first_name || ' ' || e.last_name AS fio,
         e.job_id,
         e.salary,
         e.manager_id
    FROM employees e
   WHERE e.employee_id NOT IN
         (SELECT jh.employee_id
            FROM job_history jh
           WHERE e.hire_date NOT BETWEEN jh.start_date AND jh.end_date
             AND jh.employee_id = e.employee_id
             AND jh.job_id = e.job_id)),
-- таблица уникальных профессий со списком работников(в одном столбце) для кажой профессии
all_empl_for_job AS
 (SELECT j.job_id,
         j.job_title,
         j.min_salary AS min_salary_def,
         j.max_salary AS max_salary_def,
         listagg(e.fio, ', ') WITHIN GROUP(ORDER BY e.fio) AS employees
    FROM jobs j
    LEFT JOIN employees_act e
      ON j.job_id = e.job_id
   GROUP BY j.job_id, j.job_title, j.min_salary, j.max_salary),
-- таблица работников с актуальными профессиями в разрезе минимальной и максимальной ЗП
sal_min_max AS
 (SELECT e.job_id, MIN(e.salary) AS min_salary, MAX(e.salary) AS max_salary
    FROM employees_act e
   GROUP BY e.job_id)

SELECT JOB_TITLE,
       EMPLOYEES,
       MIN_SALARY_DEF,
       MAX_SALARY_DEF,
       NVL(MIN_SALARY, 0) AS MIN_SALARY,
       NVL(MAX_SALARY, 0) AS MAX_SALARY
  FROM all_empl_for_job aefj
  LEFT JOIN sal_min_max smm
    ON aefj.job_id = smm.job_id
 ORDER BY job_title
