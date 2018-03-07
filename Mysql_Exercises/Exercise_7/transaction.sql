******Exercise Queries*************
***Query 1 -  user1 is depositing Rs.1000 to his account***

mysql> START TRANSACTION;
Query OK, 0 rows affected (0.00 sec)

mysql> UPDATE accounts SET balance = balance + 1000
    -> WHERE account_no =
    -> (SELECT account_no FROM users WHERE name = 'user1');
Query OK, 1 row affected (0.00 sec)
Rows matched: 1  Changed: 1  Warnings: 0

mysql> SELECT * FROM accounts;
+----+------------+---------+
| id | account_no | balance |
+----+------------+---------+
|  1 |      98765 |   11000 |
|  2 |      98766 |    2000 |
|  3 |      98767 |   50000 |
|  5 |      98768 |   45000 |
+----+------------+---------+
4 rows in SET (0.00 sec)

mysql> COMMIT;
Query OK, 0 rows affected (0.00 sec)

***Query 2  user1 is withdrawing rs.500 FROM his account***
mysql> START TRANSACTION;
Query OK, 0 rows affected (0.00 sec)

mysql> UPDATE accounts SET
    -> balance = balance - 500
    -> WHERE account_no = (
    -> SELECT account_no FROM users WHERE name = 'user1');
Query OK, 1 row affected (0.00 sec)
Rows matched: 1  Changed: 1  Warnings: 0

mysql> SELECT * FROM accounts;
+----+------------+---------+
| id | account_no | balance |
+----+------------+---------+
|  1 |      98765 |   10500 |
|  2 |      98766 |    2000 |
|  3 |      98767 |   50000 |
|  5 |      98768 |   45000 |
+----+------------+---------+
4 rows in SET (0.00 sec)

mysql> COMMIT;
Query OK, 0 rows affected (0.00 sec)

mysql> ROLLBACK;
Query OK, 0 rows affected (0.00 sec)

mysql> SELECT * FROM accounts;
+----+------------+---------+
| id | account_no | balance |
+----+------------+---------+
|  1 |      98765 |   10500 |
|  2 |      98766 |    2000 |
|  3 |      98767 |   50000 |
|  5 |      98768 |   45000 |
+----+------------+---------+
4 rows in SET (0.00 sec)


***Query 3 user1 is transferring Rs.200 to user2 account***

mysql> START TRANSACTION;
Query OK, 0 rows affected (0.00 sec)

mysql> UPDATE accounts SET
    -> balance = balance - 200
    -> WHERE account_no = (
    -> SELECT account_no FROM users WHERE name = 'user1');
Query OK, 1 row affected (0.00 sec)
Rows matched: 1  Changed: 1  Warnings: 0

mysql> UPDATE accounts SET
    -> balance = balance + 200
    -> WHERE account_no = (
    -> SELECT account_no FROM users WHERE name = 'user2');
Query OK, 1 row affected (0.00 sec)
Rows matched: 1  Changed: 1  Warnings: 0

mysql> SELECT * FROM accounts;
+----+------------+---------+
| id | account_no | balance |
+----+------------+---------+
|  1 |      98765 |   10300 |
|  2 |      98766 |    2200 |
|  3 |      98767 |   50000 |
|  5 |      98768 |   45000 |
+----+------------+---------+
4 rows in SET (0.00 sec)

mysql> COMMIT;
Query OK, 0 rows affected (0.00 sec)

mysql> ROLLBACK;
Query OK, 0 rows affected (0.00 sec)

mysql> SELECT * FROM accounts;
+----+------------+---------+
| id | account_no | balance |
+----+------------+---------+
|  1 |      98765 |   10300 |
|  2 |      98766 |    2200 |
|  3 |      98767 |   50000 |
|  5 |      98768 |   45000 |
+----+------------+---------+
4 rows in SET (0.00 sec)

****************DATABASE SCHEMA************************
mysql> CREATE TABLE users(
    -> id int auto_increment,
    -> name varchar(30) NOT NULL,
    -> email varchar(50) NOT NULL,
    -> account_no int(40) NOT NULL,
    -> PRIMARY KEY(id));
Query OK, 0 rows affected (0.02 sec)

mysql> CREATE TABLE accounts(
    -> id int auto_increment,
    -> account_no int(40) NOT NULL,
    -> balance int(100) default 0,
    -> PRIMARY KEY(id));
Query OK, 0 rows affected (0.01 sec)

mysql> DESCRIBE users;
+------------+-------------+------+-----+---------+----------------+
| Field      | Type        | Null | Key | Default | Extra          |
+------------+-------------+------+-----+---------+----------------+
| id         | int(11)     | NO   | PRI | NULL    | auto_increment |
| name       | varchar(30) | NO   |     | NULL    |                |
| email      | varchar(50) | NO   |     | NULL    |                |
| account_no | int(40)     | NO   |     | NULL    |                |
+------------+-------------+------+-----+---------+----------------+
4 rows in SET (0.02 sec)

mysql> DESCRIBE accounts;
+------------+----------+------+-----+---------+----------------+
| Field      | Type     | Null | Key | Default | Extra          |
+------------+----------+------+-----+---------+----------------+
| id         | int(11)  | NO   | PRI | NULL    | auto_increment |
| account_no | int(40)  | NO   |     | NULL    |                |
| balance    | int(100) | YES  |     | 0       |                |
+------------+----------+------+-----+---------+----------------+
3 rows in SET (0.02 sec)

#INSERTing the data

mysql> INSERT INTO users(name, email, account_no) VALUESs
    -> ('user1', 'user1@gmail.com', 98765),
    -> ('user2', 'user2@gmail.com', 98766),
    -> ('user3', 'user3@gmail.com', 98767),
    -> ('user4', 'user4@gmail.com', 98768);
Query OK, 4 rows affected (0.00 sec)
Records: 4  Duplicates: 0  Warnings: 0

mysql> INSERT INTO accounts(account_no, balance) VALUESs
    -> (98765, 10000),
    -> (98766, 2000),
    -> (98767, 50000),
    -> (989768, 45000);
Query OK, 4 rows affected (0.01 sec)
Records: 4  Duplicates: 0  Warnings: 0


mysql> SELECT * FROM users;
+----+-------+-----------------+------------+
| id | name  | email           | account_no |
+----+-------+-----------------+------------+
|  1 | user1 | user1@gmail.com |      98765 |
|  2 | user2 | user2@gmail.com |      98766 |
|  3 | user3 | user3@gmail.com |      98767 |
|  4 | user4 | user4@gmail.com |      98768 |
+----+-------+-----------------+------------+
4 rows in SET (0.00 sec)

mysql> SELECT * FROM accounts;
+----+------------+---------+
| id | account_no | balance |
+----+------------+---------+
|  1 |      98765 |   10000 |
|  2 |      98766 |    2000 |
|  3 |      98767 |   50000 |
|  5 |      98768 |   45000 |
+----+------------+---------+
4 rows in SET (0.00 sec)
