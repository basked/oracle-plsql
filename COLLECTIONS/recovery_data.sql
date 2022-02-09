--Recovery data
DECLARE
  TYPE empl_aat IS TABLE OF employees%ROWTYPE;
  l_empl empl_aat;
BEGIN
  SELECT * BULK COLLECT  INTO l_empl
    FROM EMPLOYEES AS OF TIMESTAMP systimestamp - INTERVAL '24' HOUR;
  FOR l_row IN 1 .. l_empl.last LOOP
    UPDATE employees e
       SET e.salary = l_empl(l_row).salary
     WHERE e.employee_id = l_empl(l_row).employee_id;
  END LOOP;
COMMIT;
END;
