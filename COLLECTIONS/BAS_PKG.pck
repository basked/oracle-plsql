CREATE OR REPLACE NONEDITIONABLE PACKAGE BAS_PKG IS
  TYPE empl_ntt IS TABLE OF employees%ROWTYPE;
  --for table functions
  -- TYPE empl_rt IS RECORD (FNAME VARCHAR2(100), LNAME VARCHAR2(30));
  -- TYPE empl_ntt IS TABLE OF empl_rt;

  FUNCTION get_emp(p_emp_id IN EMPLOYEES.EMPLOYEE_ID%TYPE) RETURN empl_ntt
    PIPELINED;
  -- DATE TYPE 
  FUNCTION get_timezone RETURN TIMESTAMP
    WITH TIME ZONE;

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
    RETURN;
  END get_emp;
  
END BAS_PKG;
/
