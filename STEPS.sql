 
/* 
   Создаем пользователя
   Пример: https://www.youtube.com/watch?v=lw_gny4zoEI
*/
 
--1) Второй вариант .Переключаемся в сессии на контейнер 
ALTER SESSION SET "_ORACLE_SCRIPT"=TRUE;


--2) Создаем пользователя
CREATE USER basked IDENTIFIED BY basked;

--3) Права на подключение 
GRANT CREATE SESSION TO basked;

--4) Все права 
GRANT ALL PRIVILEGES TO basked;

--5) После запускаем скрипты для создания тестовой схемы HR под basked
 /*     
  hr_cre.sql 
  hr_cre.sql 
  hr_popul.sql 
  hr_idx.sql 
  hr_code.sql 
  hr_comnt.sql 
  hr_analz.sql 
 */
