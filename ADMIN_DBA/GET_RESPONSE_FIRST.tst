PL/SQL Developer Test script 3.0
30
DECLARE

   req UTL_HTTP.req;
   resp UTL_HTTP.resp;
   buf VARCHAR2(1000);
   pagelob CLOB;
BEGIN
   UTL_HTTP.set_wallet('file:d:\app\baske\product\21c\admin\basked_certificate', 'basked2000');
   req := UTL_HTTP.begin_request('http://www.nbrb.by');
   UTL_HTTP.set_header(req, 'User-Agent', 'Mozilla/4.0');
   resp := UTL_HTTP.get_response(req);
  
  -- resp := UTL_HTTP.get_response(req);
   DBMS_LOB.createtemporary(pagelob, TRUE);
   BEGIN
      LOOP
         UTL_HTTP.read_text(resp, buf);
         DBMS_LOB.writeappend(pagelob, LENGTH(buf), buf);
         dbms_output.put_line(buf);
      END LOOP;
   EXCEPTION
      WHEN UTL_HTTP.end_of_body
      THEN
         NULL;
   END;
   UTL_HTTP.end_response(resp);
 

   DBMS_LOB.freetemporary(pagelob);
END;
3
resp
0
0
pagelob
0
0
buf
0
0
3
resp
pagelob
buf
