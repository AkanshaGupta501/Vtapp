mysql> create database sandwich_exercise;
Query OK, 1 row affected (0.00 sec)

mysql> use sandwich_exercise;
Database changed
mysql> create table tastes(
    -> name varchar(50),
    -> filling varchar(50),
    -> primary key(name, filling));
Query OK, 0 rows affected (0.01 sec)

mysql> create table locations(
    -> lname varchar(50),
    -> phone int(10),
    -> address varchar(200),
    -> primary key(lname));
Query OK, 0 rows affected (0.02 sec)

mysql> create table sandwiches(
    -> location varchar(100),
    -> bread varchar(100),
    -> filling varchar(100),
    -> price float(10,2),
    -> primary key(location, bread, filling));
Query OK, 0 rows affected (0.02 sec)

mysql> describe tastes;
+---------+-------------+------+-----+---------+-------+
| Field   | Type        | Null | Key | Default | Extra |
+---------+-------------+------+-----+---------+-------+
| name    | varchar(50) | NO   | PRI |         |       |
| filling | varchar(50) | NO   | PRI |         |       |
+---------+-------------+------+-----+---------+-------+
2 rows in set (0.02 sec)

mysql> describe locations;
+---------+--------------+------+-----+---------+-------+
| Field   | Type         | Null | Key | Default | Extra |
+---------+--------------+------+-----+---------+-------+
| lname   | varchar(50)  | NO   | PRI |         |       |
| phone   | int(10)      | YES  |     | NULL    |       |
| address | varchar(200) | YES  |     | NULL    |       |
+---------+--------------+------+-----+---------+-------+
3 rows in set (0.01 sec)

mysql> describe sandwiches;
+----------+--------------+------+-----+---------+-------+
| Field    | Type         | Null | Key | Default | Extra |
+----------+--------------+------+-----+---------+-------+
| location | varchar(100) | NO   | PRI |         |       |
| bread    | varchar(100) | NO   | PRI |         |       |
| filling  | varchar(100) | NO   | PRI |         |       |
| price    | float(10,2)  | YES  |     | NULL    |       |
+----------+--------------+------+-----+---------+-------+
4 rows in set (0.02 sec)

 ************************SAMPLE INSERT QUERIES*********************************

mysql> insert into tastes(name, filling) values
    -> ('brown', 'beef'),
    -> ('brown', 'ham'),
    -> ('brown', 'turkey'),
    -> ('green', 'beef'),
    -> ('green', 'cheese'),
    -> ('green', 'turkey'),
    -> ('jones', 'cheese');
Query OK, 7 rows affected (0.00 sec)
Records: 7  Duplicates: 0  Warnings: 0

mysql> insert into locations(lname, phone, address) values
    -> ('butterly', 7023421, 'college st'),
    -> ('lincoln', 6834523, 'lincoln palace'),
    -> ('old nag', 7678132, 'dame st'),
    -> ('O\'Neil\'s', 6742134, 'pearse st');
Query OK, 4 rows affected (0.01 sec)
Records: 4  Duplicates: 0  Warnings: 0

mysql> insert into sandwiches (location, bread, filling, price) values
    -> ('butterly', 'white', 'cheese', 1.00),
    -> ('butterly', 'white', 'ham', 1.10 ),
    -> ('lincoln', 'rye', 'beef', 1.35),
    -> ('lincoln','rye','ham', 1.25),
    -> ('lincoln', 'white', 'ham', 1.30),
    -> ('old nag', 'rye', 'beef', 1.35),
    -> ('old nag', 'rye', 'ham', 1.40),
    -> ('O\'Neil\'s', 'white', 'cheese', 1.20),
    -> ('O\'Neil\'s', 'white', 'turkey', 1.35),
    -> ('O\'Neil\'s', 'whole', 'ham', 1.25);
Query OK, 10 rows affected (0.01 sec)
Records: 10  Duplicates: 0  Warnings: 0

mysql> select * from sandwiches;
+----------+-------+---------+-------+
| location | bread | filling | price |
+----------+-------+---------+-------+
| butterly | white | cheese  |  1.00 |
| butterly | white | ham     |  1.10 |
| lincoln  | rye   | beef    |  1.35 |
| lincoln  | rye   | ham     |  1.25 |
| lincoln  | white | ham     |  1.30 |
| O'Neil's | white | cheese  |  1.20 |
| O'Neil's | white | turkey  |  1.35 |
| O'Neil's | whole | ham     |  1.25 |
| old nag  | rye   | beef    |  1.35 |
| old nag  | rye   | ham     |  1.40 |
+----------+-------+---------+-------+
10 rows in set (0.00 sec)

mysql> select * from locations;
+----------+---------+----------------+
| lname    | phone   | address        |
+----------+---------+----------------+
| butterly | 7023421 | college st     |
| lincoln  | 6834523 | lincoln palace |
| O'Neil's | 6742134 | pearse st      |
| old nag  | 7678132 | dame st        |
+----------+---------+----------------+
4 rows in set (0.00 sec)

mysql> select * from tastes;
+-------+---------+
| name  | filling |
+-------+---------+
| brown | beef    |
| brown | ham     |
| brown | turkey  |
| green | beef    |
| green | cheese  |
| green | turkey  |
| jones | cheese  |
+-------+---------+
7 rows in set (0.00 sec)

******************************EXERCISE QUERIES**************************************

*****QUERY 1 places where Jones can eat(using a nested subquery)*******************
mysql> select location from sandwiches where filling = (select filling from tastes where name = 'jones');
+----------+
| location |
+----------+
| butterly |
| O'Neil's |
+----------+
2 rows in set (0.01 sec)

********QUERY 2 places where Jones can eat(without using a nested subquery)*************
mysql> select location from sandwiches, tastes where tastes.name = 'jones' AND tastes.filling = sandwiches.filling;
+----------+
| location |
+----------+
| butterly |
| O'Neil's |
+----------+
2 rows in set (0.00 sec)

********QUERY 3 for each location the number of people who can eat there*********************
mysql> select S.location, count(T.name) as People_Count from sandwiches as S, tastes as T where T.filling = S.filling group by S.location;
+----------+--------------+
| location | People_Count |
+----------+--------------+
| butterly |            3 |
| lincoln  |            4 |
| O'Neil's |            5 |
| old nag  |            3 |
+----------+--------------+
4 rows in set (0.00 sec)
