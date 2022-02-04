DECLARE
  CURSOR employees_cur IS
    SELECT * FROM EMPLOYEES;
  employees_rec employees_cur%ROWTYPE;
BEGIN
  OPEN employees_cur;
  LOOP
    FETCH employees_cur
      INTO employees_rec;
    dbms_output.put_line(employees_rec.last_name);
    EXIT WHEN employees_cur%NOTFOUND;
  END LOOP;
  CLOSE employees_cur;
END;
----------------------------------------------------------
DECLARE
  employees_rec employees%ROWTYPE;
  CURSOR employees_cur IS
    SELECT * FROM EMPLOYEES;
  employees_rec2 employees_cur%ROWTYPE;
BEGIN
  OPEN employees_cur;
  LOOP
    FETCH employees_cur
      INTO employees_rec;
    employees_rec2 := employees_rec;
    dbms_output.put_line(employees_rec2.last_name);
    EXIT WHEN employees_cur%NOTFOUND;
  END LOOP;
  CLOSE employees_cur;
END;
----------------------------------------------------------
DECLARE
  TYPE employees_rt IS RECORD(
    last_name employees.last_name%TYPE);
  CURSOR employees_cur IS
    SELECT last_name FROM EMPLOYEES;
  employees_rec employees_rt;
BEGIN
  OPEN employees_cur;
  LOOP
    FETCH employees_cur
      INTO employees_rec;
    dbms_output.put_line(employees_rec.last_name);
    EXIT WHEN employees_cur%NOTFOUND;
  END LOOP;
  CLOSE employees_cur;
END;
----------------------------------------------------------
BEGIN
  FOR employees_rec IN (SELECT * FROM employees) LOOP
    dbms_output.put_line(employees_rec.last_name);
  END LOOP;
END;
----------------------------------------------------------
