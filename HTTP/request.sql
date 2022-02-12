DECLARE
   req UTL_HTTP.req;    -- "Объект запроса" (на самом деле запись PL/SQL)
   resp UTL_HTTP.resp;  -- "Объект ответа" (тоже запись PL/SQL)
   buf VARCHAR2(32767); --- буфер для хранения данных страницы
BEGIN
   req := UTL_HTTP.begin_request('https://www.lenta.com/',
      http_version => UTL_HTTP.http_version_1_1);
   UTL_HTTP.set_header(req, 'User-Agent' , 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/98.0.4758.82 Safari/537.36');
   resp := UTL_HTTP.get_response(req);
   BEGIN
      LOOP
         UTL_HTTP.read_text(resp, buf);
         -- Обработка содержимого buf (например, сохранение в массиве)
      END LOOP;
   EXCEPTION
      WHEN UTL_HTTP.end_of_body
      THEN
         NULL;
   END;
   UTL_HTTP.end_response(resp);
END; 
