CREATE OR REPLACE PACKAGE bas_col IS
  CURSOR employee_cur IS
    SELECT * FROM employees;
  TYPE employee_aat IS TABLE OF employee_cur%ROWTYPE INDEX BY PLS_INTEGER;
  employee_rec employee_cur%ROWTYPE;
  employee_c   employee_aat;
  PROCEDURE output_employees;
  PROCEDURE init_data;
END bas_col;

CREATE OR REPLACE PACKAGE BODY bas_col IS
  PROCEDURE init_data IS
  BEGIN
    dbms_output.put_line('Data was initialize!');
  END;
  -- 
  PROCEDURE output_employees IS
  BEGIN
   -- WORK WHITH RECORDS
    sf_timer.start_timer;
    OPEN employee_cur;
    LOOP
      FETCH employee_cur
        INTO employee_rec;
      dbms_output.put_line('First_name:' || employee_rec.first_name);
      EXIT WHEN employee_cur%NOTFOUND;
    END LOOP;
    CLOSE employee_cur;
    sf_timer.show_elapsed_time('-------End block records---------');
     -- WORK WHITH ASSOCIATIVE COLLECTIONS
    sf_timer.start_timer;
    OPEN employee_cur;
    LOOP
      FETCH employee_cur
        INTO employee_rec;
      employee_c(employee_cur%ROWCOUNT) := employee_rec;
      dbms_output.put_line('First_name:' || employee_c(employee_cur%ROWCOUNT).first_name);
      EXIT WHEN employee_cur%NOTFOUND;
    END LOOP;
    CLOSE employee_cur;
    sf_timer.show_elapsed_time('-------End block collections---------');
      -- WORK WHITH BULK COLLECTIONS
    sf_timer.start_timer;
    OPEN employee_cur;
    LOOP
      FETCH employee_cur BULK COLLECT
        INTO employee_c LIMIT 20;
      FOR l_row IN employee_c.first .. employee_c.last LOOP
        dbms_output.put_line('First_name:' || employee_c(l_row).first_name);
      END LOOP;
      EXIT WHEN employee_cur%NOTFOUND;
    END LOOP;
    CLOSE employee_cur;
    sf_timer.show_elapsed_time('-------End block bulk collect---------');
  END;
END bas_col;
