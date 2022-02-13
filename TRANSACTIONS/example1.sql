DECLARE
  TYPE ba_rct IS REF CURSOR;
  TYPE ba_rt IS RECORD(
    ID   blok_table_a.id%TYPE,
    NAME blok_table_a.name%TYPE);
  TYPE ba_ntt IS TABLE OF ba_rt;
  TYPE ids_ntt IS TABLE OF NUMBER;
  ba_nt  ba_ntt;
  r_cnt  NUMBER;
  ids_nt ids_ntt;

  -- сонструктор для записи 
  FUNCTION ba_rt_(p_id IN NUMBER, p_name IN VARCHAR2) RETURN ba_rt IS
    ba_r blok_table_a%ROWTYPE;
  BEGIN
    ba_r.id   := p_id;
    ba_r.name := p_name;
    RETURN ba_r;
  END;
  -- вставка данных из коллекции
  PROCEDURE insert_data(ba_nt         IN ba_ntt,
                        r_cnt         OUT NUMBER,
                        p_auto_commit BOOLEAN := FALSE) IS
  BEGIN
    FORALL l_row IN ba_nt.first .. ba_nt.last
      INSERT INTO blok_table_a VALUES (ba_nt(l_row).id, ba_nt(l_row).name);
  EXCEPTION
    WHEN OTHERS THEN
      IF SQLCODE = -1 THEN
        ROLLBACK;
        dbms_output.put_line('Попытка вставить дубликат записи.');
        dbms_output.put_line(dbms_utility.format_error_backtrace);
      END IF;
  END;
  -- обновление данных из коллекции
  PROCEDURE update_data(ba_nt         IN ba_ntt,
                        r_cnt         OUT NUMBER,
                        p_auto_commit BOOLEAN := FALSE) IS
  BEGIN
    FORALL l_row IN ba_nt.first .. ba_nt.last
      UPDATE blok_table_a
         SET NAME = ba_nt(l_row).name
       WHERE ID = ba_nt(l_row).id;
  EXCEPTION
    WHEN OTHERS THEN
      IF SQLCODE = -1 THEN
        ROLLBACK;
        dbms_output.put_line('Ошибка при обновлении записи.');
        dbms_output.put_line(dbms_utility.format_error_backtrace);
      END IF;
  END;
  -- удаление данных из коллекции
  PROCEDURE delete_data(p_ids_nt      IN ids_ntt,
                        r_cnt         OUT NUMBER,
                        p_auto_commit BOOLEAN := FALSE) IS
  BEGIN
    FORALL l_row IN p_ids_nt.first .. p_ids_nt.last
      DELETE FROM blok_table_a WHERE ID = p_ids_nt(l_row);
    IF p_auto_commit THEN
      COMMIT;
    END IF;
  EXCEPTION
    WHEN OTHERS THEN
      IF SQLCODE = -1 THEN
        ROLLBACK;
        dbms_output.put_line('Ошибка при удалении записи.');
        dbms_output.put_line(dbms_utility.format_error_backtrace);
      END IF;
  END;

  -- выборка данных из таблицу
  PROCEDURE fetch_data IS
    ba_r blok_table_a%ROWTYPE;
    rc   ba_rct;
  BEGIN
    OPEN rc FOR
      SELECT * FROM blok_table_a ORDER BY ID;
    bas_pkg.line_separ('Вывод таблицы BLOK_TABLE_A');
    LOOP
      dbms_output.put_line(ba_r.id || '   ' || ba_r.name);
      FETCH rc
        INTO ba_r;
      EXIT WHEN rc%NOTFOUND;
    END LOOP;
    CLOSE rc;
  END;

BEGIN
  ids_nt := ids_ntt(1, 2, 4, 5, 6, 7, 8, 9);
  delete_data(ids_nt, r_cnt, TRUE);
  dbms_output.put_line('Удалено записей: ' || r_cnt);
  fetch_data;
  /*
  
  
  
   ba_nt := ba_ntt(ba_rt_(8, 'name8'),
                   ba_rt_(9, 'name9'),
                   ba_rt_(15, 'name15'),
                   ba_rt_(16, 'name16'));
   --insert_data(ba_nt, r_cnt);
   COMMIT;
   ba_nt := NULL;
   ba_nt := ba_ntt(ba_rt_(8, 'NAME8'),
                   ba_rt_(9, 'NAME9'),
                   ba_rt_(15, 'NAME15'),
                   ba_rt_(16, 'NAME16'));
  -- update_data(ba_nt, r_cnt);
  
  
   COMMIT;
   /**/
END;
