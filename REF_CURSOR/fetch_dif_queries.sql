DECLARE
  TYPE empl_crt IS REF CURSOR;
  TYPE empl_rt IS RECORD(
    id_employee_id employees.employee_id%TYPE,
    salary         employees.salary%TYPE);

  empl_cr empl_crt;
  PROCEDURE fetch_reg_cur(rc IN empl_crt) IS
    empl_r empl_rt;
  BEGIN
    LOOP
      EXIT WHEN rc%NOTFOUND;
      FETCH rc
        INTO empl_r;
      dbms_output.put_line(empl_r.salary);
    END LOOP;
    CLOSE rc;
  END;
BEGIN
  bas_pkg.line_separ('Первый набор ');
  OPEN empl_cr FOR
    SELECT et.employee_id, et.salary FROM emplyees_tmp et;
  fetch_reg_cur(empl_cr);
  bas_pkg.line_separ('Второй набор ');
  OPEN empl_cr FOR
    SELECT e.employee_id, e.salary FROM employees e;
  fetch_reg_cur(empl_cr);
END;
