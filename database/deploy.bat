echo off  
set errorlevel=0  

set sql_path=G:\Projects\workspace\BassOA\database\sql

::MySQL
set mysql_home=D:\MySQL\MySQLServer\
set mysql_bin=%mysql_home%bin\

cd /d %sql_path%
  
set host=localhost
set port=3306
set user=root
set password=1

%mysql_bin%mysql -h %host% -P %port% -u %user% -p %password% <craete_database.sql 

::修改要执行的.sql文件(testsql.sql)   
::mysql -h%host% -P%port% -u%user% -p%password% < testsql.sql 

pause