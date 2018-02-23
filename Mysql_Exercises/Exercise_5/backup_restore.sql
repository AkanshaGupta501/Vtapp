##Query for backing up the database
C:\Program Files\MySQL\MySQL Server 5.5\bin>mysqldump -u root -p  blogs > E:/Github/Mysql_Exercises/Exercise_5/dump.sql


## Restoring the database
C:\Program Files\MySQL\MySQL Server 5.5\bin>mysql -u root -p -D restored < E:/Github/Mysql_Exercises/Exercise_5/dump.sql
Enter password:

C:\Program Files\MySQL\MySQL Server 5.5\bin>

mysql> use restored;
Database changed
mysql> show tables from restored;
+--------------------+
| Tables_in_restored |
+--------------------+
| articles           |
| categories         |
| comments           |
| users              |
+--------------------+
4 rows in set (0.00 sec)

