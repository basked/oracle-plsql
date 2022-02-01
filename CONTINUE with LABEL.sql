BEGIN
  <<out_loop>>
  FOR outer_loop IN 1 .. 6 LOOP
    dbms_output.put_line('Внешний цикл, item=' || outer_loop);
    <<in_looop>>
    FOR inner_loop IN 1 .. 6 LOOP
      dbms_output.put_line('Внутренний цикл, item=' || inner_loop);
      -- переход к внешней метке
      CONTINUE out_loop;
    END LOOP inner_loop;
  END LOOP outer_loop;
END;
