CREATE OR REPLACE NONEDITIONABLE PACKAGE bas_tem IS
  TYPE empl_sal_rt IS RECORD(
    employee_id employees.employee_id%TYPE,
    salary      employees.salary%TYPE);
  TYPE empl_sal_nt IS TABLE OF empl_sal_rt;
  CURSOR empl_sal_cur(p_job_id employees.job_id%TYPE) IS
    SELECT e.employee_id, e.salary
      FROM employees e
     WHERE e.job_id = p_job_id;
  PROCEDURE init_sal(p_job_id employees.job_id%TYPE);
END bas_tem;
/
CREATE OR REPLACE NONEDITIONABLE PACKAGE BODY bas_tem IS
  PROCEDURE init_sal(p_job_id employees.job_id%TYPE) IS
    empl_sal empl_sal_nt;
  BEGIN
    OPEN empl_sal_cur(p_job_id);
    FETCH empl_sal_cur BULK COLLECT
      INTO empl_sal;
    CLOSE empl_sal_cur;
    FOR l_row IN empl_sal.first .. empl_sal.last LOOP
      dbms_output.put_line(empl_sal(l_row).salary);
      /*  INSERT INTO employees_tmp
        (ID, empl_sal)
      VALUES
        (1, empl_sal_ont(empl_sal(l_row).e_id, empl_sal(l_row).e_salary));
        */
    END LOOP;
  END;
END bas_tem;
/
