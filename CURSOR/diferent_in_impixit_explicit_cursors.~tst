PL/SQL Developer Test script 3.0
57
-- basked
-- разница между явными и неявными курсорами
DECLARE
  CURSOR ids_cur IS
    SELECT COLUMN_VALUE FROM TABLE(empl_ntt(1, 2, 3));

  CURSOR ids_empl_cur IS
    SELECT e.employee_id FROM employees e WHERE e.employee_id = 0;
  l_ids       VARCHAR2(200);
  l_last_name employees.last_name%TYPE;
BEGIN

  -- GOTO IMPLICIT_CURSOR;

  -- выыодим все строки из коллекции
  FOR l_row IN (SELECT COLUMN_VALUE FROM TABLE(empl_ntt(1, 2, 3))) LOOP
    dbms_output.put_line(l_row.column_value);
  END LOOP;
  -- выыодим строку из коллекции
  FOR l_row IN (SELECT listagg(COLUMN_VALUE, ',') within GROUP(ORDER BY 1) AS IDS
                  FROM TABLE(empl_ntt(1, 2, 3))) LOOP
    dbms_output.put_line(l_row.ids);
  END LOOP;
  <<LISTAGG>>
-- выводим через select 
  SELECT listagg(COLUMN_VALUE, ',') within GROUP(ORDER BY 1) AS IDS
    INTO l_ids
    FROM TABLE(empl_ntt(1, 2, 3));
  dbms_output.put_line(l_ids);

  <<IMPLICIT_CURSOR>>
--в неявном курсоре при отсутствии строк вызывается исключение
  BEGIN
    SELECT e.last_name
      INTO l_last_name
      FROM employees e
     WHERE e.employee_id = 0;
    dbms_output.put_line(l_last_name);
  EXCEPTION
    WHEN OTHERS THEN
      dbms_output.put_line('Нет данных в неявном курсоре.' ||
                           dbms_utility.format_error_stack);
  END;
  <<EXPLICIT_CURSOR>>
--в  явном курсоре при отсутствии строк завершается блок управления без исключения
  BEGIN
    OPEN ids_empl_cur;
    FETCH ids_empl_cur
      INTO l_last_name;
    dbms_output.put_line(l_last_name);
    CLOSE ids_empl_cur;
  EXCEPTION
    WHEN OTHERS THEN
      dbms_output.put_line('Нет данных в явном курсоре' ||
                           dbms_utility.format_error_stack);
  END;
END;
0
2
ids_empl_cur
l_last_name
