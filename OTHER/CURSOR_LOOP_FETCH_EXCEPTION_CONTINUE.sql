DECLARE
  CURSOR categories_cur IS
    SELECT 1 AS ID, 'title1' AS title
      FROM dual
    UNION
    SELECT 2 AS ID, 'title2' AS title
      FROM dual
    UNION
    SELECT 3 AS ID, 'title3' AS title
      FROM dual
    UNION
    SELECT 4 AS ID, 'title4' AS title
      FROM dual
    UNION
    SELECT 5 AS ID, 'title5' AS title
      FROM dual;

  categories_rec categories_cur%ROWTYPE;
  err_title      EXCEPTION;
BEGIN
  DELETE FROM categories;
  COMMIT;
  OPEN categories_cur;
  <<categories_loop>>
  LOOP
    FETCH categories_cur
      INTO categories_rec;
    EXIT WHEN categories_cur%NOTFOUND;
  
    INSERT INTO categories
      (ID, title)
    VALUES
      (categories_rec.id, categories_rec.title);
    -- пропускаем title2
    IF categories_rec.title = 'title2' THEN
      dbms_output.put_line('Ошибка при добавлении записи для ' ||
                           categories_rec.title);
      CONTINUE;
    END IF;
    -- выбрасываем исключение и прерываем цикл если title4
    IF categories_rec.title = 'title4' THEN
      RAISE err_title;
    END IF;
    COMMIT;
  END LOOP categories_loop;
  CLOSE categories_cur;
EXCEPTION
  WHEN err_title THEN
    dbms_output.put_line('Ошибка при добавлении записи для ' ||
                         categories_rec.title);
    ROLLBACK;
END;
