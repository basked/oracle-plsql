PL/SQL Developer Test script 3.0
20
-- Created on 17.03.2022 by BASKED 
DECLARE
  -- Local variables here
  l_fio VARCHAR2(50);

BEGIN
  SELECT e.last_name || ' ' || e.first_name AS fio
    INTO l_fio
    FROM employees e
   WHERE e.employee_id = 100;
  -- WHERE e.employee_id = -9; --100, 101;
  -- WHERE e.employee_id IN (100, 101);
  dbms_output.put_line(l_fio);
EXCEPTION
  WHEN NO_DATA_FOUND THEN
    dbms_output.put_line('NO_DATA_FOUND');
  WHEN TOO_MANY_ROWS THEN
    dbms_output.put_line('TOO_MANY_ROWS');
  
END;
0
0
