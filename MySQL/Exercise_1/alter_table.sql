
mysql> create database mysql_exercises;
Query OK, 1 row affected (0.00 sec)

mysql> use mysql_exercises;
Database changed
mysql> create table testing_table(name varchar(10) NOT NULL, contact_name varchar(10) NOT NULL, roll_no varchar(10) NOT NULL);
Query OK, 0 rows affected (0.02 sec)

mysql> describe testing_table;
+--------------+-------------+------+-----+---------+-------+
| Field        | Type        | Null | Key | Default | Extra |
+--------------+-------------+------+-----+---------+-------+
| name         | varchar(10) | NO   |     | NULL    |       |
| contact_name | varchar(10) | NO   |     | NULL    |       |
| roll_no      | varchar(10) | NO   |     | NULL    |       |
+--------------+-------------+------+-----+---------+-------+
3 rows in set (0.04 sec)

mysql> alter table testing_table drop column name;
Query OK, 0 rows affected (0.04 sec)
Records: 0  Duplicates: 0  Warnings: 0

mysql> describe testing_table;
+--------------+-------------+------+-----+---------+-------+
| Field        | Type        | Null | Key | Default | Extra |
+--------------+-------------+------+-----+---------+-------+
| contact_name | varchar(10) | NO   |     | NULL    |       |
| roll_no      | varchar(10) | NO   |     | NULL    |       |
+--------------+-------------+------+-----+---------+-------+
2 rows in set (0.02 sec)

mysql> alter table testing_table change contact_name username varchar(10);
Query OK, 0 rows affected (0.04 sec)
Records: 0  Duplicates: 0  Warnings: 0

mysql> describe testing_table;
+----------+-------------+------+-----+---------+-------+
| Field    | Type        | Null | Key | Default | Extra |
+----------+-------------+------+-----+---------+-------+
| username | varchar(10) | YES  |     | NULL    |       |
| roll_no  | varchar(10) | NO   |     | NULL    |       |
+----------+-------------+------+-----+---------+-------+
2 rows in set (0.01 sec)

mysql> alter table testing_table add column first_name varchar(10) NOT NULL, add column last_name varchar(10);
Query OK, 0 rows affected (0.04 sec)
Records: 0  Duplicates: 0  Warnings: 0

mysql> describe testing_table;
+------------+-------------+------+-----+---------+-------+
| Field      | Type        | Null | Key | Default | Extra |
+------------+-------------+------+-----+---------+-------+
| username   | varchar(10) | YES  |     | NULL    |       |
| roll_no    | varchar(10) | NO   |     | NULL    |       |
| first_name | varchar(10) | NO   |     | NULL    |       |
| last_name  | varchar(10) | YES  |     | NULL    |       |
+------------+-------------+------+-----+---------+-------+
4 rows in set (0.02 sec)

mysql> alter table testing_table modify roll_no int(4) NOT NULL;
Query OK, 0 rows affected (0.04 sec)
Records: 0  Duplicates: 0  Warnings: 0

mysql> describe testing_table;
+------------+-------------+------+-----+---------+-------+
| Field      | Type        | Null | Key | Default | Extra |
+------------+-------------+------+-----+---------+-------+
| username   | varchar(10) | YES  |     | NULL    |       |
| roll_no    | int(4)      | NO   |     | NULL    |       |
| first_name | varchar(10) | NO   |     | NULL    |       |
| last_name  | varchar(10) | YES  |     | NULL    |       |
+------------+-------------+------+-----+---------+-------+
4 rows in set (0.02 sec)
