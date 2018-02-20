mysql> create table branch(bcode varchar(5) NOT NULL, librarian varchar(20), address varchar(30), PRIMARY KEY(bcode));
Query OK, 0 rows affected (0.02 sec)

mysql> describe branch;
+-----------+-------------+------+-----+---------+-------+
| Field     | Type        | Null | Key | Default | Extra |
+-----------+-------------+------+-----+---------+-------+
| bcode     | varchar(5)  | NO   | PRI | NULL    |       |
| librarian | varchar(20) | YES  |     | NULL    |       |
| address   | varchar(30) | YES  |     | NULL    |       |
+-----------+-------------+------+-----+---------+-------+
3 rows in set (0.02 sec)

mysql> create table titles(title varchar(40) NOT NULL, author varchar(40) NOT NULL, publisher varchar(40) NOT NULL, PRIMARY KEY(title));
Query OK, 0 rows affected (0.02 sec)

mysql> describe titles;
+-----------+-------------+------+-----+---------+-------+
| Field     | Type        | Null | Key | Default | Extra |
+-----------+-------------+------+-----+---------+-------+
| title     | varchar(40) | NO   | PRI | NULL    |       |
| author    | varchar(40) | NO   |     | NULL    |       |
| publisher | varchar(40) | NO   |     | NULL    |       |
+-----------+-------------+------+-----+---------+-------+
3 rows in set (0.02 sec)

mysql> create table holdings(branch varchar(30) NOT NULL, title varchar(30) NOT NULL, copies int(10) NOT NULL, PRIMARY KEY(branch, title), FOREIGN KEY(title) REFERENCES titles(title), FOREIGN KEY(branch) REFERENCES branch(bcode));
Query OK, 0 rows affected (0.02 sec)

mysql> describe holdings;
+--------+-------------+------+-----+---------+-------+
| Field  | Type        | Null | Key | Default | Extra |
+--------+-------------+------+-----+---------+-------+
| branch | varchar(30) | NO   | PRI | NULL    |       |
| title  | varchar(30) | NO   | PRI | NULL    |       |
| copies | int(10)     | NO   |     | NULL    |       |
+--------+-------------+------+-----+---------+-------+
3 rows in set (0.02 sec)

*******************************SAMPLE INSERT QUERIES**************************************
mysql> insert into branch(bcode, librarian, address) values ('B3', 'Francis Owens', 'Grange X');
Query OK, 1 row affected (0.01 sec)

mysql> select * from branch;
+-------+---------------+---------------+
| bcode | librarian     | address       |
+-------+---------------+---------------+
| B1    | Johnsmith     | 2 Anglesea Rd |
| B2    | Mary Jones    | 34 Pearse St  |
| B3    | Francis Owens | Grange X      |
+-------+---------------+---------------+
3 rows in set (0.00 sec)
mysql> insert into titles(title, author, publisher) values ('Computers', 'Blaise Pascal', 'Applewoods');
Query OK, 1 row affected (0.01 sec)

mysql> select * from titles;
+---------------------+---------------+------------+
| title               | author        | publisher  |
+---------------------+---------------+------------+
| A History of Dublin | David Little  | Wiley      |
| Computers           | Blaise Pascal | Applewoods |
| How to Fish         | Amy Fly       | Stop Press |
| Susannah            | Ann Brown     | Macmillian |
| The Wife            | Ann Brown     | Macmillian |
+---------------------+---------------+------------+
5 rows in set (0.00 sec)

mysql> insert into holdings(branch, title, copies) values ('B3', 'Susannah', 3);
Query OK, 1 row affected (0.00 sec)

mysql> select * from holdings;
+--------+---------------------+--------+
| branch | title               | copies |
+--------+---------------------+--------+
| B1     | A History of Dublin |      1 |
| B1     | How to Fish         |      2 |
| B1     | Susannah            |      3 |
| B2     | Computers           |      2 |
| B2     | How to Fish         |      4 |
| B2     | The Wife            |      3 |
| B3     | A History of Dublin |      1 |
| B3     | Computers           |      4 |
| B3     | Susannah            |      3 |
| B3     | The Wife            |      1 |
+--------+---------------------+--------+
10 rows in set (0.00 sec)

******************************EXERCISE QUERIES********************************************

********QUERY 1 - the names of all library books published by Macmillan*************************** 

mysql> select title from titles where publisher = 'Macmillian';
+----------+
| title    |
+----------+
| Susannah |
| The Wife |
+----------+
2 rows in set (0.00 sec)

********************QUERY 2 - branches that hold any books by AnnBrown(using a nested subquery)******
mysql> select branch from holdings where title IN (select title from titles where author = 'Ann Brown');
+--------+
| branch |
+--------+
| B1     |
| B3     |
| B2     |
| B3     |
+--------+
4 rows in set (0.00 sec)

******************QUERY 3-  branches that hold any books by AnnBrown(without using a nested subquery)******
mysql> select branch from holdings, titles where titles.author = 'Ann Brown' AND holdings.title = titles.title;
+--------+
| branch |
+--------+
| B1     |
| B3     |
| B2     |
| B3     |
+--------+
4 rows in set (0.00 sec)

***********************QUERY 4 -  Total number of books held at each branch*******************
mysql> select branch, sum(copies) as total_number_books from holdings group by branch;
+--------+--------------------+
| branch | total_number_books |
+--------+--------------------+
| B1     |                  6 |
| B2     |                  9 |
| B3     |                  9 |
+--------+--------------------+
3 rows in set (0.00 sec)