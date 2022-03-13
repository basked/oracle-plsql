CREATE OR REPLACE NONEDITIONABLE PACKAGE BAS_PKG IS
  TYPE empl_ntt IS TABLE OF employees%ROWTYPE;
  CURSOR cur_emp_list(p_job_id IN jobs.job_id%TYPE := NULL) IS
    SELECT e.first_name || ' ' || e.last_name
      FROM employees e
     WHERE e.job_id = p_job_id;
  fio_nt fio_ntt;
  fio_va fio_vat;
  --for table functions
  -- TYPE empl_rt IS RECORD (FNAME VARCHAR2(100), LNAME VARCHAR2(30));
  -- TYPE empl_ntt IS TABLE OF empl_rt;

  FUNCTION get_emp(p_emp_id IN EMPLOYEES.EMPLOYEE_ID%TYPE) RETURN empl_ntt
    PIPELINED;
  FUNCTION get_emp1(p_emp_id IN EMPLOYEES.EMPLOYEE_ID%TYPE) RETURN empl_ntt
    PIPELINED;
  PROCEDURE getCntByDep(p_dep_id IN departments.department_id%TYPE);
END BAS_PKG;
/
CREATE OR REPLACE NONEDITIONABLE PACKAGE BODY BAS_PKG IS
  FUNCTION get_emp(p_emp_id IN EMPLOYEES.EMPLOYEE_ID%TYPE) RETURN empl_ntt
    PIPELINED IS
    CURSOR empl_cur IS
      SELECT e.* FROM employees e WHERE e.employee_id < p_emp_id;
    empl_nt empl_ntt;
  BEGIN
    OPEN empl_cur;
    LOOP
      FETCH empl_cur BULK COLLECT
        INTO empl_nt;
      FOR i IN 1 .. empl_nt.count LOOP
        PIPE ROW(empl_nt(i));
      END LOOP;
      EXIT WHEN empl_cur%NOTFOUND;
    END LOOP;
    CLOSE empl_cur;
  END get_emp;
  -- aoi?ay aa?ney 
  FUNCTION get_emp1(p_emp_id IN EMPLOYEES.EMPLOYEE_ID%TYPE) RETURN empl_ntt
    PIPELINED IS
    empl_nt empl_ntt;
  BEGIN
    SELECT e.*
      BULK COLLECT
      INTO empl_nt
      FROM employees e
     WHERE e.employee_id < p_emp_id;
    FOR i IN 1 .. empl_nt.count LOOP
      empl_nt(i).first_name := empl_nt(i).first_name || '-F';
      PIPE ROW(empl_nt(i));
    END LOOP;
  END get_emp1;

  PROCEDURE getCntByDep(p_dep_id IN departments.department_id%TYPE) IS
    l_dep_name VARCHAR2(150);
    l_empl_cnt INTEGER NOT NULL DEFAULT 0;
  BEGIN
  
    IF p_dep_id IS NULL THEN
      bas_err_pkg.raise_by_lang(-20002);
    END IF;
  
    SELECT d.department_name, COUNT(*) AS cnt
      INTO l_dep_name, l_empl_cnt
      FROM employees e, departments d
     WHERE e.department_id = d.department_id
       AND d.department_id = p_dep_id
     GROUP BY d.department_name;
    dbms_output.put_line(l_dep_name || ' ' || l_empl_cnt);
  EXCEPTION
    WHEN bas_err_pkg.exc_val_not_null THEN
      dbms_output.put_line('Отдел c ID=' || p_dep_id || ' не найден.');
    WHEN bas_err_pkg.exc_dep_is_null THEN
      dbms_output.put_line('Отдел равен NULL');
    WHEN OTHERS THEN
      dbms_output.put_line(SQLCODE || ':' || SQLERRM(SQLCODE));
    
  END getCntByDep;

END BAS_PKG;
/
