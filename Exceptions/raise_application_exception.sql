DECLARE
  bas_not_data_err EXCEPTION;
  bas_not_data_msg CONSTANT VARCHAR2(500) := 'Отдел c ID=' || &dep_id ||
                                             ' не найден.';
  PRAGMA EXCEPTION_INIT(bas_not_data_err, 100);

  bas_null_val_err EXCEPTION;
  bas_null_val_code CONSTANT NUMBER := -20500; --6502;
  bas_null_val_msg  CONSTANT VARCHAR2(500) := 'Значение переменной не может быть равно NULL';
  PRAGMA EXCEPTION_INIT(bas_null_val_err, -6502);

  l_dep_name VARCHAR2(150);
  l_empl_cnt INTEGER NOT NULL DEFAULT 0;
BEGIN

  IF &dep_id IS NULL THEN
    bas_err_pkg.raise_by_lang(bas_err_pkg.err_val_not_nullerr_val_not_null);
  END IF;

  SELECT d.department_name, COUNT(*) AS cnt
    INTO l_dep_name, l_empl_cnt
    FROM employees e, departments d
   WHERE e.department_id = d.department_id
     AND d.department_id = &dep_id
   GROUP BY d.department_name;
  dbms_output.put_line(l_dep_name || ' ' || l_empl_cnt);
EXCEPTION
  WHEN bas_err_pkg.exc_val_not_null THEN
    dbms_output.put_line('Отдел c ID=' || &dep_id || ' не найден.');
  WHEN bas_null_val_err THEN
    dbms_output.put_line(bas_null_val_msg);
  WHEN OTHERS THEN
    dbms_output.put_line(SQLCODE || ':' || SQLERRM(SQLCODE));
END;
