DECLARE
  CURSOR sklad_cur IS
    SELECT sk.num_kard, sk.num_sklad
      FROM sklad sk
     WHERE sk.num_sklad = 346;
BEGIN
  FOR sklad_rec IN sklad_cur LOOP
    dbms_output.put_line('Карточка:' || sklad_rec.num_kard);
  END LOOP;
END;
