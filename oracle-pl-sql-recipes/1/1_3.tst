﻿PL/SQL Developer Test script 3.0
7
DECLARE
  counter NUMBER;
BEGIN
  FOR i IN REVERSE 0 .. 10 LOOP
    DBMS_OUTPUT.PUT_LINE(i);
  END LOOP;
END;
0
1
i
