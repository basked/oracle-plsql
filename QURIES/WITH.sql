WITH t1 AS
 (SELECT e.job_id,
			COUNT(e.job_id) AS cnt,
			SUM(e.salary) AS job_total_salary
  FROM employees e
  GROUP BY e.job_id),
t2 AS
 (SELECT e.first_name,
			e.job_id,
			e.salary,
			t1.job_total_salary,
			t1.cnt
  FROM employees e
  LEFT JOIN t1
  ON e.job_id = t1.job_id)
SELECT *
FROM t2
ORDER BY t2.job_id
