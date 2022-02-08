/*
DROP TABLE hmo_coverage;
 
CREATE TABLE hmo_coverage (
   ID NUMBER , 
   denial VARCHAR2(100),
   patient_name VARCHAR2(100),
   cnt NUMBER 
  -- CONSTRAINT hmo_coverage_pk   PRIMARY KEY(ID),
  -- CONSTRAINT hmo_coverage_fk  FOREIGN KEY(employee_id) REFERENCES employees(employee_ID)
);
*/

DECLARE
  TYPE employee_indices_aat IS TABLE OF BOOLEAN INDEX BY PLS_INTEGER;
  TYPE denials_t IS TABLE OF hmo_coverage.denial%TYPE;
  TYPE number_varray_t IS VARRAY(1000) OF NUMBER;
  TYPE patient_names_t IS TABLE OF hmo_coverage.denial%TYPE;
  TYPE hmo_coverage_t IS TABLE OF hmo_coverage%ROWTYPE;

  l_denials          denials_t := denials_t('TOO SICK',
                                            'TOO POOR',
                                            'COMPLAINS TOO MUCH');
  l_names            patient_names_t := patient_names_t('John Lovecanal',
                                                        'John Travolta',
                                                        'Sally Works2Jobs');
  l_hmo_coverage     hmo_coverage_t;
  number_varray      number_varray_t;
  l_employee_ids     number_varray_t;
  l_employee_indices employee_indices_aat;
BEGIN
  /* Cause an ORA-22160 error */
  -- l_denials.DELETE (2);

  DELETE FROM hmo_coverage;
  COMMIT;

  SELECT e.employee_id, e.first_name, e.last_name, e.salary
    BULK COLLECT
    INTO l_hmo_coverage
    FROM employees e;
  FORALL l_row IN l_hmo_coverage.first .. l_hmo_coverage.last
    INSERT INTO hmo_coverage
    VALUES
      (l_hmo_coverage(l_row).id,
       l_hmo_coverage(l_row).denial,
       l_hmo_coverage(l_row).patient_name,
       l_hmo_coverage(l_row).cnt)
    RETURNING ID BULK COLLECT INTO number_varray;

  dbms_output.put_line('Добавлено ' || l_hmo_coverage.count || ' записей!');
  FOR i IN l_hmo_coverage.first .. l_hmo_coverage.last LOOP
    IF MOD(i, 5) = 0 THEN
      l_employee_indices(i) := TRUE;
    END IF;
  END LOOP;

  bas_pkg.line_separ('Обновить ЗП каждому 5-ому сотруднику');
  FORALL indx IN INDICES OF l_employee_indices
    UPDATE hmo_coverage
       SET cnt = cnt * 1000
     WHERE ID = number_varray(indx) 
  RETURNING cnt BULK COLLECT
    INTO l_employee_ids;
    dbms_output.put_line('Обновлено '||  l_employee_ids.count|| ' элементов колекции!(каждый 5-ый)' ); 
  COMMIT;
END;
 
