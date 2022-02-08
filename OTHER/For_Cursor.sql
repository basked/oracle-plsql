DECLARE
  error_cnt  EXCEPTION;
  l_num_kard sklad.num_kard%TYPE;
  CURSOR sklad_cur IS
    SELECT sk.num_kard, sk.num_sklad
      FROM sklad sk
     WHERE sk.num_sklad = 346;
BEGIN
  l_num_kard := 0;
  FOR sklad_rec IN sklad_cur LOOP
    dbms_output.put_line('Карточка:' || sklad_rec.num_kard);
    IF sklad_rec.num_kard = 42852 THEN
      l_num_kard := sklad_rec.num_kard;
      RAISE error_cnt;
    END IF;
  END LOOP;
EXCEPTION
  WHEN error_cnt THEN
    dbms_output.put_line('Ошибка в карточке: ' || l_num_kard);
END;
