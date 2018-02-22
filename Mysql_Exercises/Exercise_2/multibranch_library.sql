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
mysql> select branch, title from holdings where title IN (select title from titles where author = 'Ann Brown');
+--------+----------+
| branch | title    |
+--------+----------+
| B1     | Susannah |
| B3     | Susannah |
| B2     | The Wife |
| B3     | The Wife |
+--------+----------+
4 rows in set (0.00 sec)

******************QUERY 3-  branches that hold any books by AnnBrown(without using a nested subquery)******
mysql> select branch, holdings.title from holdings, titles where titles.author = 'Ann Brown' AND holdings.title = titles.title;
+--------+----------+
| branch | title    |
+--------+----------+
| B1     | Susannah |
| B3     | Susannah |
| B2     | The Wife |
| B3     | The Wife |
+--------+----------+
4 rows in set (0.00 sec)

***********************QUERY 4 -  Total number of books held at each branches*******************
mysql> select branch, sum(copies) as total_number_books from holdings group by branch;
+--------+--------------------+
| branch | total_number_books |
+--------+--------------------+
| B1     |                  6 |
| B2     |                  9 |
| B3     |                  9 |
+--------+--------------------+
3 rows in set (0.00 sec)


**************************************DATABASE SCHEMA******************************************

mysql> use library_system;
Database changed
mysql> create table branches(
    -> bcode varchar(5) NOT NULL,
    -> librarian varchar(20),
    -> address varchar(50),
    -> primary key(bcode));
Query OK, 0 rows affected (0.02 sec)

mysql> create table titles(
    -> title varchar(50),
    -> author varchar(50) not null,
    -> publisher varchar(50) not null,
    -> primary key(title));
Query OK, 0 rows affected (0.02 sec)

mysql> create table holdings(
    -> branch varchar(5),
    -> title varchar(50),
    -> copies int(100) not null,
    -> primary key(branch, title),
    -> foreign key(branch) references branches(bcode),
    -> foreign key(title) references titles(title));
Query OK, 0 rows affected (0.03 sec)

mysql> describe branches;
+-----------+-------------+------+-----+---------+-------+
| Field     | Type        | Null | Key | Default | Extra |
+-----------+-------------+------+-----+---------+-------+
| bcode     | varchar(5)  | NO   | PRI | NULL    |       |
| librarian | varchar(20) | YES  |     | NULL    |       |
| address   | varchar(50) | YES  |     | NULL    |       |
+-----------+-------------+------+-----+---------+-------+
3 rows in set (0.02 sec)

mysql> describe titles;
+-----------+-------------+------+-----+---------+-------+
| Field     | Type        | Null | Key | Default | Extra |
+-----------+-------------+------+-----+---------+-------+
| title     | varchar(50) | NO   | PRI |         |       |
| author    | varchar(50) | NO   |     | NULL    |       |
| publisher | varchar(50) | NO   |     | NULL    |       |
+-----------+-------------+------+-----+---------+-------+
3 rows in set (0.02 sec)

mysql> describe holdings;
+--------+-------------+------+-----+---------+-------+
| Field  | Type        | Null | Key | Default | Extra |
+--------+-------------+------+-----+---------+-------+
| branch | varchar(5)  | NO   | PRI |         |       |
| title  | varchar(50) | NO   | PRI |         |       |
| copies | int(100)    | NO   |     | NULL    |       |
+--------+-------------+------+-----+---------+-------+
3 rows in set (0.01 sec)

*******************************SAMPLE INSERT QUERIES**************************************
mysql> insert into branches(bcode, librarian, address) values
    -> ('B1', 'John Smith', '2 Anglesea Rd'),
    -> ('B2', 'Mary Jones', '34 Pearse St'),
    -> ('B3', 'Francis Ownes', 'Grange X');
Query OK, 3 rows affected (0.00 sec)
Records: 3  Duplicates: 0  Warnings: 0

mysql> insert into titles (title, author, publisher) values
    -> ('Susannah', 'Ann Brown', 'Macmillian'),
    -> ('How to Fish', 'Amy Fly', 'Stop Press'),
    -> ('A History of Dublin', 'David Little', 'Wiley'),
    -> ('Computers', 'Blaise Pascal', 'Applewoods'),
    -> ('The Wife', 'Ann Brown', 'Macmillian');
Query OK, 5 rows affected (0.00 sec)
Records: 5  Duplicates: 0  Warnings: 0

mysql> insert into holdings(branch, title, copies) values
    -> ('B1', 'Susannah', 3),
    -> ('B1', 'How to Fish', 2),
    -> ('B1', 'A History of Dublin', 1),
    -> ('B2', 'How to Fish', 4),
    -> ('B2', 'The Wife', 3),
    -> ('B2', 'Computers', 2),
    -> ('B3', 'A History of Dublin', 1),
    -> ('B3', 'Computers', 4),
    -> ('B3', 'Susannah', 3),
    -> ('B3', 'The Wife', 1);
Query OK, 10 rows affected (0.00 sec)
Records: 10  Duplicates: 0  Warnings: 0

mysql> select * from branches;
+-------+---------------+---------------+
| bcode | librarian     | address       |
+-------+---------------+---------------+
| B1    | John Smith    | 2 Anglesea Rd |
| B2    | Mary Jones    | 34 Pearse St  |
| B3    | Francis Ownes | Grange X      |
+-------+---------------+---------------+
3 rows in set (0.00 sec)

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

