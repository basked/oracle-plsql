declare
  var_glob  number;
  my_exception Exception;
  cursor c is
    select sk.num_kard
      from sklad sk
     where sk.num_sklad = 346
     order by 1 asc;
  num_kard_rec c%rowtype;
begin
  <<local_block>>
  declare
    loc_var number;
  begin
    loc_var:=333;
   var_glob:=loc_var;
  end local_block;
   dbms_output.put_line('Значение было присвоено в анонимном блоке '||var_glob);
  open c;
  loop
    fetch c
      into num_kard_rec;
    if num_kard_rec.num_kard = 428521 then
      raise my_exception;
    end if;
    exit when c%notfound;
    dbms_output.put_line(num_kard_rec.num_kard);
  end loop;
  close c;
EXCEPTION
  when my_exception then
    dbms_output.put_line('My Exception');
end;
