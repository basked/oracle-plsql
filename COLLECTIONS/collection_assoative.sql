DECLARE
  TYPE population_aat IS TABLE OF PLS_INTEGER INDEX BY VARCHAR2(20);
  population  population_aat := population_aat('BELARUS' => 9500000,
                                              'RUSSIA'  => 140500000,
                                              'UKRAIN'  => 35000000);
  i          VARCHAR2(20);
BEGIN
  --population('BELARUS') := 9500000;
  --population('RUSSIA') := 140500000;
  --population('UKRAIN') := 35000000;
  population('RUSSIA') := 135500000;
  i := population.first;
  WHILE i IS NOT NULL LOOP
    dbms_output.put_line('Population in ' || i || ' = ' || population(i));
    i := population.next(i);
  END LOOP;

END;
