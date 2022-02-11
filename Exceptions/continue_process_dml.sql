DECLARE
  l_empl_id   employees.employee_id%TYPE;
  l_email     employees.email%TYPE;
  l_err_fetch EXCEPTION;
  PRAGMA EXCEPTION_INIT(l_err_fetch, -1422);
BEGIN
  BEGIN
    SELECT e.email INTO l_email FROM employees e WHERE e.manager_id = 102;
  EXCEPTION
    WHEN l_err_fetch THEN
      dbms_output.put_line('Many rows result');
      l_email := 'AHUNOLD';
  END;

  UPDATE employees e
     SET e.commission_pct = 0.5
   WHERE e.email = l_email
  RETURNING e.employee_id INTO l_empl_id;
  dbms_output.put_line('Обработано строк:' || SQL%ROWCOUNT || ', ' ||
                       l_empl_id || bas_pkg.get_fio_manager(l_empl_id));

END;
