CREATE OR REPLACE NONEDITIONABLE PACKAGE bas_pkg IS

  TYPE fio_rt IS RECORD(
    first_name employees.first_name%TYPE,
    last_name  employees.last_name%TYPE);
  TYPE list_fields_t IS TABLE OF VARCHAR2(64);
  TYPE list_fields_type_t IS TABLE OF VARCHAR2(32);
  PROCEDURE line_separ(msg IN VARCHAR2, length_str IN NUMBER := 100);
  FUNCTION get_salary(p_employee_id employees.employee_id%TYPE)
    RETURN employees.salary%TYPE;
  FUNCTION get_fio(p_employee_id employees.employee_id%TYPE) RETURN VARCHAR2;
  PROCEDURE create_table(p_tab_name IN VARCHAR2,
                         p_fields   IN list_fields_t,
                         p_types    IN list_fields_type_t);
  PROCEDURE dummy(p_tab_name IN VARCHAR2, p_id_to NUMBER);
END bas_pkg;
/
CREATE OR REPLACE NONEDITIONABLE PACKAGE BODY bas_pkg IS
  PROCEDURE line_separ(msg IN VARCHAR2, length_str IN NUMBER := 100) IS
    l_cnt NUMBER;
  BEGIN
    l_cnt := (length_str - LENGTH(msg)) / 2;
    dbms_output.put_line(LPAD('=', l_cnt, '=') || msg ||
                         RPAD('=', l_cnt, '='));
  END line_separ;

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

  FUNCTION get_salary(p_employee_id employees.employee_id%TYPE)
    RETURN employees.salary%TYPE IS
    fio_rec employees%ROWTYPE;
  BEGIN
    SELECT e.salary
      INTO fio_rec.salary
      FROM employees e
     WHERE e.employee_id = p_employee_id;
    RETURN fio_rec.salary;
  END;
  -- Dynamic sql for create table
  PROCEDURE create_table(p_tab_name IN VARCHAR2,
                         p_fields   IN list_fields_t,
                         p_types    IN list_fields_type_t) IS
    e_dif_size        EXCEPTION;
    l_sql_create_stmt VARCHAR(1000);
  BEGIN
    IF p_fields.count <> p_types.count THEN
      RAISE e_dif_size;
    END IF;
    l_sql_create_stmt := 'CREATE TABLE ' || p_tab_name||'(';
    FOR indx IN p_fields.first .. p_fields.last LOOP
     l_sql_create_stmt:=l_sql_create_stmt||' '||p_fields(indx)||' '|| p_types(indx)||',' ; 
     END LOOP;
     l_sql_create_stmt:= l_sql_create_stmt||'  CONSTRAINTS ' || p_tab_name || '_pk PRIMARY KEY (ID))';
    EXECUTE IMMEDIATE 'drop table ' || p_tab_name;
    EXECUTE IMMEDIATE l_sql_create_stmt;
    dbms_output.put_line('Table ' || p_tab_name || ' was created!');
  EXCEPTION
    WHEN e_dif_size THEN
      dbms_output.put_line('Кол-во полей должно соответствовать кол-ву типов.');
    WHEN OTHERS THEN
      IF SQLCODE = -942 THEN
        EXECUTE IMMEDIATE l_sql_create_stmt;
        dbms_output.put_line('Table ' || p_tab_name || ' was created!');
      END IF;
  END;

  -- dummy data
  PROCEDURE dummy(p_tab_name IN VARCHAR2, p_id_to NUMBER) IS
    l_sql_insert_stmt VARCHAR(1000);
  BEGIN
    l_sql_insert_stmt := 'INSERT INTO ' || p_tab_name ||
                         ' SELECT LEVEL AS ID FROM dual CONNECT BY LEVEL BETWEEN 1 AND :id_to ';
  
    EXECUTE IMMEDIATE l_sql_insert_stmt
      USING p_id_to;
    COMMIT;
    dbms_output.put_line('Insert data to table ' || p_tab_name);
  EXCEPTION
    WHEN OTHERS THEN
      dbms_output.put_line('Error code: ' || SQLCODE || ' ' || SQLERRM ||
                           ' WHEN INSERT DATA INTO ' || p_tab_name);
      ROLLBACK;
  END;
END bas_pkg;
