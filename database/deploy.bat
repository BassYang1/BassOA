echo off  
set errorlevel=0  

set sql_path=C:\Users\bass.yang\workspace\OA\BassOA\database\sql

::MySQL
set mysql_home=E:\Program Files\MySQL\MySQL Server 5.5\
set mysql_bin=%mysql_home%bin\

cd /d %sql_path%
  
set host=localhost
set port=3306
set user=root
set password=111111

%mysql_bin%mysql -h %host% -P %port% -u %user% -p %password% <craete_database.sql 

::修改要执行的.sql文件(testsql.sql)   
::mysql -h%host% -P%port% -u%user% -p%password% < testsql.sql 

pause