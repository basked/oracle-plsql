﻿DECLARE
  counter NUMBER;
BEGIN
  FOR i IN REVERSE 0 .. 10 LOOP
    DBMS_OUTPUT.PUT_LINE(i);
  END LOOP;
END;
