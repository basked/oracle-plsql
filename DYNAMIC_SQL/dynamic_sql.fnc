CREATE OR REPLACE NONEDITIONABLE PROCEDURE work_with_forall IS
  error_add_columns EXCEPTION;

  PROCEDURE add_field_salary2 IS
  
    sql_dml VARCHAR2(100) := 'ALTER TABLE EMPLOYEES ADD SALARY2 VARCHAR(50)';
  BEGIN
    EXECUTE IMMEDIATE sql_dml;
    dbms_output.put_line('ADD SALARY2');
  EXCEPTION
    WHEN OTHERS THEN
      dbms_output.put_line('Ошибка при добавлении поля SALARY2 ' ||
                           SQLERRM);
      RAISE error_add_columns;
  END;

  PROCEDURE del_field_salary2 IS
    sql_dml VARCHAR2(100) := 'ALTER TABLE EMPLOYEES DROP COLUMN SALARY2';
  BEGIN
    EXECUTE IMMEDIATE sql_dml;
    dbms_output.put_line('DROP SALARY2');
  EXCEPTION
    WHEN OTHERS THEN
      dbms_output.put_line('Ошибка при удалении поля SALARY2 ' || SQLERRM);
  END;

  PROCEDURE select_empl(source_tbl IN VARCHAR2) IS
    empl_cursor INTEGER;
    ignore      INTEGER;
    fn  VARCHAR2(30);
  BEGIN
    -- Prepare a cursor to select from the source table: 
    empl_cursor := dbms_sql.open_cursor;
    DBMS_SQL.PARSE(empl_cursor,
                   'SELECT first_name  FROM ' || source_tbl,
                   DBMS_SQL.NATIVE);
    DBMS_SQL.DEFINE_COLUMN(empl_cursor, 1, fn,50);
    ignore := DBMS_SQL.EXECUTE(empl_cursor);
    
    LOOP
      IF DBMS_SQL.FETCH_ROWS(empl_cursor) > 0 THEN
        -- get column values of the row 
       DBMS_SQL.COLUMN_VALUE(empl_cursor, 1, fn);
       Dbms_Output.put_line(fn);
      END IF;
    END LOOP;
  EXCEPTION
    WHEN OTHERS THEN
      IF DBMS_SQL.IS_OPEN(empl_cursor) THEN
        DBMS_SQL.CLOSE_CURSOR(empl_cursor);
      END IF;
      RAISE;
  END;

BEGIN
  BEGIN
    add_field_salary2;
  EXCEPTION
    WHEN error_add_columns THEN
      dbms_output.put_line('Обработка ошибки возникшей при добавлении');
      del_field_salary2;
  END;
  del_field_salary2;
  select_empl('employees');

END;
/
create or replace noneditionable package body dbms_sql wrapped
a000000
1
abcd
abcd
abcd
abcd
abcd
abcd
abcd
abcd
abcd
abcd
abcd
abcd
abcd
abcd
abcd
b
18ede 246f
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
xZs
/
CREATE OR REPLACE NONEDITIONABLE PROCEDURE work_with_forall IS
  error_add_columns EXCEPTION;

  PROCEDURE add_field_salary2 IS
  
    sql_dml VARCHAR2(100) := 'ALTER TABLE EMPLOYEES ADD SALARY2 VARCHAR(50)';
  BEGIN
    EXECUTE IMMEDIATE sql_dml;
    dbms_output.put_line('ADD SALARY2');
  EXCEPTION
    WHEN OTHERS THEN
      dbms_output.put_line('Ошибка при добавлении поля SALARY2 ' ||
                           SQLERRM);
      RAISE error_add_columns;
  END;

  PROCEDURE del_field_salary2 IS
    sql_dml VARCHAR2(100) := 'ALTER TABLE EMPLOYEES DROP COLUMN SALARY2';
  BEGIN
    EXECUTE IMMEDIATE sql_dml;
    dbms_output.put_line('DROP SALARY2');
  EXCEPTION
    WHEN OTHERS THEN
      dbms_output.put_line('Ошибка при удалении поля SALARY2 ' || SQLERRM);
  END;

  PROCEDURE select_empl(source_tbl IN VARCHAR2) IS
    empl_cursor INTEGER;
    ignore      INTEGER;
    fn  VARCHAR2(30);
  BEGIN
    -- Prepare a cursor to select from the source table: 
    empl_cursor := dbms_sql.open_cursor;
    DBMS_SQL.PARSE(empl_cursor,
                   'SELECT first_name  FROM ' || source_tbl,
                   DBMS_SQL.NATIVE);
    DBMS_SQL.DEFINE_COLUMN(empl_cursor, 1, fn,50);
    ignore := DBMS_SQL.EXECUTE(empl_cursor);
    
    LOOP
      IF DBMS_SQL.FETCH_ROWS(empl_cursor) > 0 THEN
        -- get column values of the row 
       DBMS_SQL.COLUMN_VALUE(empl_cursor, 1, fn);
       Dbms_Output.put_line(fn);
      END IF;
    END LOOP;
  EXCEPTION
    WHEN OTHERS THEN
      IF DBMS_SQL.IS_OPEN(empl_cursor) THEN
        DBMS_SQL.CLOSE_CURSOR(empl_cursor);
      END IF;
      RAISE;
  END;

BEGIN
  BEGIN
    add_field_salary2;
  EXCEPTION
    WHEN error_add_columns THEN
      dbms_output.put_line('Обработка ошибки возникшей при добавлении');
      del_field_salary2;
  END;
  del_field_salary2;
  select_empl('employees');

END;
/
CREATE OR REPLACE NONEDITIONABLE PROCEDURE work_with_forall IS
  error_add_columns EXCEPTION;

  PROCEDURE add_field_salary2 IS
  
    sql_dml VARCHAR2(100) := 'ALTER TABLE EMPLOYEES ADD SALARY2 VARCHAR(50)';
  BEGIN
    EXECUTE IMMEDIATE sql_dml;
    dbms_output.put_line('ADD SALARY2');
  EXCEPTION
    WHEN OTHERS THEN
      dbms_output.put_line('Ошибка при добавлении поля SALARY2 ' ||
                           SQLERRM);
      RAISE error_add_columns;
  END;

  PROCEDURE del_field_salary2 IS
    sql_dml VARCHAR2(100) := 'ALTER TABLE EMPLOYEES DROP COLUMN SALARY2';
  BEGIN
    EXECUTE IMMEDIATE sql_dml;
    dbms_output.put_line('DROP SALARY2');
  EXCEPTION
    WHEN OTHERS THEN
      dbms_output.put_line('Ошибка при удалении поля SALARY2 ' || SQLERRM);
  END;

  PROCEDURE select_empl(source_tbl IN VARCHAR2) IS
    empl_cursor INTEGER;
    ignore      INTEGER;
    fn  VARCHAR2(30);
  BEGIN
    -- Prepare a cursor to select from the source table: 
    empl_cursor := dbms_sql.open_cursor;
    DBMS_SQL.PARSE(empl_cursor,
                   'SELECT first_name  FROM ' || source_tbl,
                   DBMS_SQL.NATIVE);
    DBMS_SQL.DEFINE_COLUMN(empl_cursor, 1, fn,50);
    ignore := DBMS_SQL.EXECUTE(empl_cursor);
    
    LOOP
      IF DBMS_SQL.FETCH_ROWS(empl_cursor) > 0 THEN
        -- get column values of the row 
       DBMS_SQL.COLUMN_VALUE(empl_cursor, 1, fn);
       Dbms_Output.put_line(fn);
      END IF;
    END LOOP;
  EXCEPTION
    WHEN OTHERS THEN
      IF DBMS_SQL.IS_OPEN(empl_cursor) THEN
        DBMS_SQL.CLOSE_CURSOR(empl_cursor);
      END IF;
      RAISE;
  END;

BEGIN
  BEGIN
    add_field_salary2;
  EXCEPTION
    WHEN error_add_columns THEN
      dbms_output.put_line('Обработка ошибки возникшей при добавлении');
      del_field_salary2;
  END;
  del_field_salary2;
  select_empl('employees');

END;
/
 
BEGIN
  work_with_forall;
END;
/
