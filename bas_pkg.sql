CREATE OR REPLACE PACKAGE bas_pkg IS
  TYPE fio_rt IS RECORD(
    first_name employees.first_name%TYPE,
    last_name  employees.last_name%TYPE);
  FUNCTION get_fio(p_employee_id employees.employee_id%TYPE) RETURN VARCHAR2;
  FUNCTION get_fio2(p_employee_id employees.employee_id%TYPE) RETURN fio_rt;
  FUNCTION get_fio3(fio_rec fio_rt) RETURN VARCHAR2;
END bas_pkg;

CREATE OR REPLACE PACKAGE BODY bas_pkg IS
  FUNCTION get_fio(p_employee_id employees.employee_id%TYPE) RETURN VARCHAR2 IS
    fio_rec employees%ROWTYPE;
  BEGIN
    SELECT e.first_name, e.last_name
      INTO fio_rec.first_name, fio_rec.last_name
      FROM employees e
     WHERE e.employee_id = p_employee_id;
    RETURN fio_rec.first_name || ' ' || fio_rec.last_name;
  END;
 
  FUNCTION get_fio2(p_employee_id employees.employee_id%TYPE) RETURN fio_rt IS
    fio_rec fio_rt;
  BEGIN
    SELECT e.first_name, e.last_name
      INTO fio_rec.first_name, fio_rec.last_name
      FROM employees e
     WHERE e.employee_id = p_employee_id;
    RETURN fio_rec;
  END;
  
  FUNCTION get_fio3(fio_rec fio_rt) RETURN VARCHAR2 IS
  BEGIN
    RETURN fio_rec.last_name || ' ' || fio_rec.first_name;
  END;
END bas_pkg;
