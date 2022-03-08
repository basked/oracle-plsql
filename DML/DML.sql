DECLARE
  TYPE empl_ntt IS TABLE OF employees%ROWTYPE;
  
  empl_nt empl_ntt;
  empl_r  employees%ROWTYPE;
  PROCEDURE list_empl IS
  BEGIN
    FOR l_row IN (SELECT * FROM employees2) LOOP
      dbms_output.put_line(l_row.employee_id || ' ' || l_row.first_name || ' ' ||
                           l_row.last_name || ' ' || l_row.salary2);
    END LOOP;
  END;
  -- вначале вставка
  PROCEDURE add_empl(empl IN employees%ROWTYPE) IS
  BEGIN
    INSERT INTO employees2
      (employee_id, first_name, last_name, salary2)
    VALUES
      (empl.employee_id, empl.first_name, empl.last_name, empl.salary2);
  EXCEPTION
    WHEN DUP_VAL_ON_INDEX THEN
      UPDATE employees2 e
         SET first_name = empl.first_name,
             last_name  = empl.last_name,
             salary2    = empl.salary2
       WHERE e.employee_id = empl.employee_id;
    
      COMMIT;
  END add_empl;
  --вначале обновление
  PROCEDURE update_empl(empl IN employees%ROWTYPE) IS
  BEGIN
    UPDATE employees2 e
       SET first_name = empl.first_name,
           last_name  = empl.last_name,
           salary2    = empl.salary2
     WHERE e.employee_id = empl.employee_id;
    IF SQL%ROWCOUNT = 0 THEN
      INSERT INTO employees2
        (employee_id, first_name, last_name, salary2)
      VALUES
        (empl.employee_id, empl.first_name, empl.last_name, empl.salary2);
    END IF;
    COMMIT;
  END update_empl;
  -- находим нужного сотрудника по ID
  FUNCTION getEmployeeById(p_employee_id IN employees.employee_id%TYPE)
    RETURN empl_ntt IS
    empl_nt empl_ntt;
  BEGIN
    SELECT *
      BULK COLLECT
      INTO empl_nt
      FROM employees e
     WHERE e.employee_id IN (p_employee_id);
    RETURN empl_nt;
  END;
 
BEGIN
  empl_nt := getEmployeeById(102);
  IF empl_nt.count > 1 THEN
    empl_r         := empl_nt(1);
    empl_r.salary2 := 1111;
    -- update_empl(empl_r);
    add_empl(empl_r);
  END IF;
  list_empl;

END;
