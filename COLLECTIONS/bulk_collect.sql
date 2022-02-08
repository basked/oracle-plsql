DECLARE
  TYPE empl_rt IS RECORD(
    department_name departments.department_name%TYPE,
    fio             employees.last_name%TYPE,
    salary          employees.salary%TYPE);

  CURSOR empl_cur(p_job_id employees.job_id%TYPE) IS
    SELECT d.department_name,
           e.first_name || ' ' || e.last_name AS fio,
           e.salary
      FROM departments d
      LEFT JOIN employees e
     USING (department_id)
     WHERE e.job_id = p_job_id;
  TYPE empl_aat IS TABLE OF empl_cur%ROWTYPE INDEX BY PLS_INTEGER;
  TYPE employee_aat IS TABLE OF employees%ROWTYPE;
  TYPE employee_id_aat IS TABLE OF employees.employee_id%TYPE;
  TYPE salary_aat IS TABLE OF employees.salary%TYPE;
  l_empl        empl_aat;
  l_employee    employee_aat;
  l_empl_rec    empl_rt;
  l_row         PLS_INTEGER;
  l_salary      salary_aat;
  l_employee_id employee_id_aat;
BEGIN
  bas_pkg.line_separ('Вывод покупателей через запись');
  OPEN empl_cur('IT_PROG');
  LOOP
    FETCH empl_cur
      INTO l_empl_rec;
    dbms_output.put_line(l_empl_rec.fio);
    EXIT WHEN empl_cur%NOTFOUND;
  END LOOP;
  CLOSE empl_cur;

  bas_pkg.line_separ('Коллекция записей неявного курсора');
  SELECT * BULK COLLECT INTO l_employee FROM employees;
  FOR l_row IN l_employee.first .. l_employee.last LOOP
    dbms_output.put_line(l_employee(l_row).first_name);
  END LOOP;

  bas_pkg.line_separ('Коллекция записей из явного курсора');
  OPEN empl_cur('IT_PROG');
  LOOP
    FETCH empl_cur BULK COLLECT
      INTO l_empl;
    l_row := l_empl.first;
    WHILE l_row <= l_empl.count LOOP
      dbms_output.put_line(l_empl(l_row).fio || ' / ' || l_empl(l_row).department_name ||
                            ' / ' || l_empl(l_row).salary);
      l_row := l_empl.next(l_row);
    END LOOP;
    EXIT WHEN empl_cur%NOTFOUND;
  END LOOP;
  CLOSE empl_cur;
 
  bas_pkg.line_separ('Обновление данных о сотрудниках и вывод через RETURNING');
  UPDATE employees e
     SET e.salary = e.salary * 10
   WHERE e.job_id = 'IT_PROG'
  RETURNING e.employee_id, e.salary BULK COLLECT INTO l_employee_id, l_salary;
  FOR indx IN l_salary.first .. l_salary.last LOOP
    dbms_output.put_line(bas_pkg.get_fio(l_employee_id(indx)) ||
                         ', salary=' || l_salary(indx));
  END LOOP;
  ROLLBACK;
END;
