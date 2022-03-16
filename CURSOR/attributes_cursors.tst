﻿PL/SQL Developer Test script 3.0
32
DECLARE
  CURSOR empl_cur IS
    SELECT * FROM employees e WHERE e.employee_id < 120;
  empl_rec    empl_cur%ROWTYPE;
  l_empl_rows NUMBER;
BEGIN
  --   OPEN empl_cur;
  <<cur_label>>
  BEGIN
    LOOP
      FETCH empl_cur
        INTO empl_rec;
      EXIT WHEN empl_cur%NOTFOUND;
      dbms_output.put_line('N=' || empl_cur%ROWCOUNT || ', ' ||
                           empl_rec.first_name);
    END LOOP;
    l_empl_rows := empl_cur%ROWCOUNT;
    CLOSE empl_cur;
  EXCEPTION
    WHEN INVALID_CURSOR THEN
      dbms_output.put_line('INV CUR');
      OPEN empl_cur;
      GOTO cur_label;
  END;
  UPDATE employees e SET salary2 = NULL WHERE e.employee_id < 120;
  dbms_output.put_line(SQL%ROWCOUNT || ',' || l_empl_rows);
  -- фиксируем если количество прочитанных для отчёта строк равно количеству обновлённых
  IF SQL%ROWCOUNT = l_empl_rows THEN
    dbms_output.put_line('FETCH ROWS = UPDATED ROWS');
    COMMIT;
  END IF;
END;
0
4
empl_cur
empl_rec
empl_cur%ROWCOUNT
SQL%ROWCOUNT
