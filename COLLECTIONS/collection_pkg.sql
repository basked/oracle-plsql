CREATE OR REPLACE PACKAGE bas_col IS
  CURSOR employee_cur IS
    SELECT * FROM employees;
  TYPE employee_aat IS TABLE OF employee_cur%ROWTYPE INDEX BY PLS_INTEGER;
  employee_rec employee_cur%ROWTYPE;
  employee_c   employee_aat;
  PROCEDURE init_data;
  PROCEDURE output_employees;
  PROCEDURE change_park(p_title         IN auto_park.title%TYPE,
                        p_auto_park_rec OUT auto_park%ROWTYPE);
END bas_col;
/
CREATE OR REPLACE PACKAGE BODY bas_col IS
  PROCEDURE init_data IS
  BEGIN
    dbms_output.put_line('Data was initialize!');
  END;
  --
  PROCEDURE change_park(p_title IN auto_park.title%TYPE,
                        p_auto_park_rec OUT auto_park%ROWTYPE) IS
    collect_c auto_park.names_auto%TYPE;
  BEGIN
    BEGIN
      SELECT names_auto
        INTO collect_c
        FROM auto_park
       WHERE title = p_title;
      collect_c.trim(2);
      collect_c.extend;
      collect_c(collect_c.last) := 'new item collect11';
      collect_c.extend;
      collect_c(collect_c.last) := 'new item collect21';
    EXCEPTION
      WHEN OTHERS THEN
        dbms_output.put_line('LIMIT COLLECTION = ' || collect_c.limit);
    END;
    UPDATE auto_park
       SET title = 'AUTOPARK', names_auto = collect_c
     WHERE title = p_title
    RETURNING title, names_auto INTO p_auto_park_rec;
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

/
BEGIN
  -- test procedure bas_col.output_employees;
  BEGIN
    bas_col.output_employees;
  END;
  -- test procedure bas_col.change_park
  DECLARE
    park_rec auto_park%ROWTYPE;
  BEGIN
    change_park('AUTOPARK', park_rec);
    COMMIT;
    dbms_output.put_line(park_rec.title);
    FOR i IN park_rec.names_auto.first .. park_rec.names_auto.last LOOP
      dbms_output.put_line(park_rec.names_auto(i));
    END LOOP;
  END; 
END;
