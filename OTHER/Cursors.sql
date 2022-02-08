
-- Курсор с параметром
DECLARE
  CURSOR cat(p_id IN categories.id%TYPE) IS
    SELECT * FROM CATEGORIES c WHERE c.id > p_id;
BEGIN
  FOR rec IN cat(1) LOOP
    dbms_output.put_line(rec.title);
  END LOOP;
END;
-- Курсоры и возвращаемое значение из DML операции
DECLARE
  CURSOR cat_cur IS
    SELECT * FROM categories;
  cat_rec          categories%ROWTYPE;
  "l_count_insert" PLS_INTEGER;
  -- Вставка данных и возврат количества вставленных записей
  PROCEDURE insert_data(categories_rec IN categories%ROWTYPE,
                        count_insert   OUT PLS_INTEGER) IS
  BEGIN
    INSERT INTO categories2 VALUES categories_rec;
    count_insert := SQL%ROWCOUNT;
  END insert_data;
BEGIN
  OPEN cat_cur;
  LOOP
    FETCH cat_cur
      INTO cat_rec;
    insert_data(cat_rec, "l_count_insert");
    dbms_output.put_line('Вставлено записей:' || "l_count_insert");
    EXIT WHEN cat_cur%NOTFOUND;
  END LOOP;
  CLOSE cat_cur;
END;
