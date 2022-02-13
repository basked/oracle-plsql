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
    IF p_auto_commit THEN
      r_cnt := SQL%ROWCOUNT;
      COMMIT;
    END IF;
  EXCEPTION
    WHEN OTHERS THEN
      IF SQLCODE = -1 THEN
        ROLLBACK;
        dbms_output.put_line('Попытка вставить дубликат записи.');
        dbms_output.put_line(dbms_utility.format_error_backtrace);
        RAISE;
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
    IF p_auto_commit THEN
      r_cnt := SQL%ROWCOUNT;
      COMMIT;
    END IF;
  EXCEPTION
    WHEN OTHERS THEN
      IF SQLCODE = -1 THEN
        ROLLBACK;
        dbms_output.put_line('Ошибка при обновлении записи.');
        dbms_output.put_line(dbms_utility.format_error_backtrace);
        RAISE;
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
      r_cnt := SQL%ROWCOUNT;
      COMMIT;
    END IF;
  EXCEPTION
    WHEN OTHERS THEN
      dbms_output.put_line(SQLERRM);
      IF SQLCODE = -1 THEN
        dbms_output.put_line('Ошибка при удалении записи.');
        dbms_output.put_line(dbms_utility.format_error_backtrace);
        RAISE;
        ROLLBACK;
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
  SET TRANSACTION ISOLATION LEVEL SERIALIZABLE NAME 'first transaction';
  dbms_output.put_line('Таблица до изменений: ' || r_cnt);
  fetch_data;

  ids_nt := ids_ntt(1, 2, 3, 4);
  delete_data(ids_nt, r_cnt, TRUE);
  dbms_output.put_line('Удалено записей: ' || r_cnt);
  fetch_data;
  ba_nt := ba_ntt(ba_rt_(1, 'name1'),
                  ba_rt_(2, 'name2'),
                  ba_rt_(3, 'name3'),
                  ba_rt_(4, 'name4'));
  insert_data(ba_nt, r_cnt);
  dbms_output.put_line('Вставлено записей: ' || r_cnt);
  fetch_data;
  ba_nt := NULL;
  ba_nt := ba_ntt(ba_rt_(1, 'NAME1'),
                  ba_rt_(2, 'NAME2'),
                  ba_rt_(3, 'NAME3'),
                  ba_rt_(4, 'NAME4'));
  update_data(ba_nt, r_cnt);
  dbms_output.put_line('Обнавлено записей: ' || r_cnt);
  fetch_data;
  COMMIT;
EXCEPTION
  WHEN OTHERS THEN
    dbms_output.put_line(SQLERRM || ' ' || SQLCODE);
    dbms_output.put_line(dbms_utility.format_error_backtrace);
    ROLLBACK;
END;
