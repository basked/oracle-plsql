PL/SQL Developer Test script 3.0
23
DECLARE
  CURSOR empl_cur IS
    SELECT * FROM employees e WHERE e.employee_id < 120;
  empl_rec empl_cur%ROWTYPE;
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
    CLOSE empl_cur;
  EXCEPTION
    WHEN INVALID_CURSOR THEN
      dbms_output.put_line('INV CUR');
      OPEN empl_cur;
      GOTO cur_label;
  END;
END;
0
2
empl_cur
empl_rec
