**************EXERCISE QUERIES*****************
**QUERY -1 Select all articles whose author name is user 3 **

mysql> SELECT content FROM articles,
       users WHERE articles.user_id = users.id AND
       users.name = 'user3';
+-------------------+
| content           |
+-------------------+
| Angels and Demons |
| Blind River       |
+-------------------+
2 rows in set (0.00 sec)


---Using variable----
mysql> set @userName = 'Akansha';
Query OK, 0 rows affected (0.00 sec)

mysql> SELECT content FROM articles,
    -> users WHERE articles.user_id = users.id AND
    -> users.name = @userName;
+-------------------------+
| content                 |
+-------------------------+
| Artificial Intelligence |
+-------------------------+
1 row in set (0.00 sec)


**Query 2 - For all the articles being selected above, select all the articles and also the comments associated with those articles in a single query**

mysql> SELECT articles.content, group_concat(comments.content separator '----') AS Comments
       FROM articles, users, comments
       WHERE articles.id = comments.article_id AND
       articles.user_id = users.id AND
       users.name = 'user3' GROUP BY articles.id;
+-------------------+----------------------+
| content           | Comments             |
+-------------------+----------------------+
| Angels and Demons | Good work----Average |
| Blind River       | Nice work            |
+-------------------+----------------------+
2 rows in set (0.00 sec)



----using nested subquery------
mysql> SELECT articles.content, group_concat(comments.content) AS Comments FROM
       articles LEFT JOIN comments
       ON article_id = articles.id
       WHERE articles.user_id = (
       SELECT users.id FROM users WHERE users.name = 'user3') 
       GROUP BY articles.id;
+-------------------+-------------------+
| content           | Comments          |
+-------------------+-------------------+
| Angels and Demons | Good work,Average |
| Blind River       | Nice work         |
+-------------------+-------------------+
2 rows in set (0.00 sec)

**Query -3 Write a query to select all articles which do not have any comments**

mysql> UPDATE comments SET content = NULL
    -> WHERE id = 10;
Query OK, 1 row affected (0.00 sec)
Rows matched: 1  Changed: 1  Warnings: 0

mysql> SELECT articles.content AS Articles FROM
       articles LEFT JOIN comments
       ON article_id = articles.id
       WHERE comments.content IS NULL;
+-------------+
| Articles    |
+-------------+
| Blind River |
+-------------+
1 row in set (0.00 sec)

**Query 4 Write a query to select article which has maximum comments**

mysql> SELECT articles.content, COUNT(comments.id) AS Count FROM
       articles LEFT JOIN comments
       ON article_id  = articles.id
       GROUP BY articles.id
       HAVING COUNT(comments.id) =
       (SELECT COUNT(articles.id) FROM
       articles join comments
       ON article_id = articles.id
       GROUP BY articles.id
       order by COUNT(articles.id) DESC limit 1);
+-------------------------+-------+
| content                 | Count |
+-------------------------+-------+
| Artificial Intelligence |     2 |
| Angels and Demons       |     2 |
+-------------------------+-------+
2 rows in set (0.00 sec)


**Query 5 Write a query to select article which does not have more than one comment by the same user ( do this using left join and group by )**

mysql> SELECT articles.content, comments.content FROM
       articles LEFT JOIN comments
       ON article_id = articles.id
       GROUP BY articles.id
       HAVING COUNT(distinct comments.user_id) = COUNT(comments.user_id);
+-----------------------------+-----------------------------------+
| content                     | content                           |
+-----------------------------+-----------------------------------+
| Snow White and Seven Dwarfs | Complete package, enjoyed reading |
| Artificial Intelligence     | Could be improvised more          |
| Angels and Demons           | Good work                         |
| Blind River                 | NULL                              |
+-----------------------------+-----------------------------------+
4 rows in set (0.00 sec)


mysql> SELECT articles.content, COUNT(comments.user_id) FROM
       articles LEFT JOIN comments
       ON article_id = articles.id
       GROUP BY articles.id
       HAVING COUNT(distinct comments.user_id) = COUNT(comments.user_id);
+-----------------------------+-------------------------+
| content                     | COUNT(comments.user_id) |
+-----------------------------+-------------------------+
| Snow White and Seven Dwarfs |                       1 |
| Artificial Intelligence     |                       2 |
| Angels and Demons           |                       2 |
| Blind River                 |                       1 |
+-----------------------------+-------------------------+
4 rows in set (0.00 sec)


*******************************DATABASE SCHEMA**********************************

mysql> CREATE DATABASE blogs;
Query OK, 1 row affected (0.00 sec)

mysql> USE blogs;
Database changed
mysql> CREATE TABLE users(
       id INT auto_increment,
       name VARCHAR(30),
       role enum('normal', 'admin'),
       PRIMARY KEY(id));
Query OK, 0 rows affected (0.03 sec)

mysql> CREATE table categories(
       id INT AUTO_INCREMENT,
       category VARCHAR(50),
       PRIMARY KEY(id));
Query OK, 0 rows affected (0.02 sec)

mysql> CREATE table articles(
        id INT AUTO_INCREMENT,
        content VARCHAR(10000),
        user_id INT,
        category_id INT,
        PRIMARY KEY(id),
        FOREIGN KEY(user_id) REFERENCES users(id) ON DELETE CASCADE ON UPDATE CASCADE,
        FOREIGN KEY(category_id) REFERENCES categories(id) ON DELETE CASCADE ON UPDATE CASCADE);
Query OK, 0 rows affected (0.02 sec)

mysql> CREATE table comments(
       id INT AUTO_INCREMENT,
       article_id INT,
       content VARCHAR(1000),
       user_id INT,
       PRIMARY KEY(id),
       FOREIGN KEY(article_id) REFERENCES articles(id) ON DELETE CASCADE ON UPDATE CASCADE,
       FOREIGN KEY(user_id) REFERENCES users(id) ON DELETE CASCADE ON UPDATE CASCADE);
Query OK, 0 rows affected (0.01 sec)

mysql> DESCRIBE users;
+-------+------------------------+------+-----+---------+----------------+
| Field | Type                   | Null | Key | Default | Extra          |
+-------+------------------------+------+-----+---------+----------------+
| id    | int(11)                | NO   | PRI | NULL    | auto_increment |
| name  | varchar(30)            | YES  |     | NULL    |                |
| role  | enum('normal','admin') | YES  |     | NULL    |                |
+-------+------------------------+------+-----+---------+----------------+
3 rows in set (0.02 sec)

mysql> DESCRIBE categories;
+----------+-------------+------+-----+---------+----------------+
| Field    | Type        | Null | Key | Default | Extra          |
+----------+-------------+------+-----+---------+----------------+
| id       | int(11)     | NO   | PRI | NULL    | auto_increment |
| category | varchar(50) | YES  |     | NULL    |                |
+----------+-------------+------+-----+---------+----------------+
2 rows in set (0.02 sec)

mysql> DESCRIBE articles;
+-------------+----------------+------+-----+---------+----------------+
| Field       | Type           | Null | Key | Default | Extra          |
+-------------+----------------+------+-----+---------+----------------+
| id          | int(11)        | NO   | PRI | NULL    | auto_increment |
| content     | varchar(10000) | YES  |     | NULL    |                |
| user_id     | int(11)        | YES  | MUL | NULL    |                |
| category_id | int(11)        | YES  | MUL | NULL    |                |
+-------------+----------------+------+-----+---------+----------------+
4 rows in set (0.02 sec)

mysql> DESCRIBE comments;
+------------+---------------+------+-----+---------+----------------+
| Field      | Type          | Null | Key | Default | Extra          |
+------------+---------------+------+-----+---------+----------------+
| id         | int(11)       | NO   | PRI | NULL    | auto_increment |
| article_id | int(11)       | YES  | MUL | NULL    |                |
| content    | varchar(1000) | YES  |     | NULL    |                |
| user_id    | int(11)       | YES  | MUL | NULL    |                |
+------------+---------------+------+-----+---------+----------------+
4 rows in set (0.02 sec)


*************Database Schema (Manage Queries)*************
mysql> INSERT INTO categories (category) VALUES
    -> ('Science & Technology'),
    -> ('Literature'),
    -> ('Fiction'),
    -> ('Non Fiction'),
    -> ('Comics');
Query OK, 5 rows affected (0.00 sec)
Records: 5  Duplicates: 0  Warnings: 0

mysql> INSERT INTO users (name, role) VALUES
    -> ('Akansha', 'admin'),
    -> ('user3', 'normal'),
    -> ('Sandhya', 'normal'),
    -> ('Vedansh', 'normal'),
    -> ('Gappu', 'normal');
Query OK, 5 rows affected (0.01 sec)
Records: 5  Duplicates: 0  Warnings: 0

mysql> INSERT INTO articles(content, user_id, category_id) VALUES
    -> ('Women in the Window', 4, 2),
    -> ('Dark Bogus', 3, 3),
    -> ('Shelock Holmes', 5, 2),
    -> ('Snow White and Seven Dwarfs', 5, 1),
    -> ('Artificial Intelligence', 1, 4),
    -> ('Angels and Demons', 2, 5),
    -> ('Blind River', 2, 3);
Query OK, 7 rows affected (0.01 sec)
Records: 7  Duplicates: 0  Warnings: 0

mysql> INSERT INTO comments(article_id, content, user_id) VALUES
    -> (3, "Nice work done", 4),
    -> (4, "Good article", 3),
    -> (5, "It was a fun reading the story", 2),
    -> (6, "Complete package, enjoyed reading", 1),
    -> (7, "Good article", 1),
    -> (7, "Nice article,specified pin details", 2),
    -> (6, "This book was the best i have ever read", 4),
    -> (3, "Nice work done by the author", 2);
Query OK, 8 rows affected (0.00 sec)
Records: 8  Duplicates: 0  Warnings: 0

mysql> UPDATE users SET name = 'Aakriti'
    -> WHERE name = 'Vedansh';
Query OK, 1 row affected (0.01 sec)
Rows matched: 1  Changed: 1  Warnings: 0

mysql> UPDATE articles SET category_id = 4
    -> WHERE content = 'Dark Bogus';
Query OK, 1 row affected (0.00 sec)
Rows matched: 1  Changed: 1  Warnings: 0

mysql> UPDATE categories SET category = 'Biography'
    -> WHERE category = 'Fiction';
Query OK, 1 row affected (0.01 sec)
Rows matched: 1  Changed: 1  Warnings: 0

mysql> UPDATE comments SET content = 'Could be improvised more'
    -> WHERE id = 5;
Query OK, 1 row affected (0.00 sec)
Rows matched: 1  Changed: 1  Warnings: 0

mysql> DELETE FROM users WHERE name = 'Aakriti';
Query OK, 1 row affected (0.01 sec)

mysql> DELETE FROM articles WHERE content = 'Dark Bogus';
Query OK, 1 row affected (0.01 sec)

mysql> DELETE FROM categories WHERE category = 'Literature';
Query OK, 1 row affected (0.01 sec)

mysql> DELETE FROM comments WHERE article_id = 3;
Query OK, 0 rows affected (0.00 sec)

mysql> DELETE FROM comments WHERE article_id = 4;
Query OK, 0 rows affected (0.00 sec)

##Final Database 

mysql> SELECT * FROM users;
+----+---------+--------+
| id | name    | role   |
+----+---------+--------+
|  1 | Akansha | admin  |
|  2 | user3   | normal |
|  3 | Sandhya | normal |
|  5 | Gappu   | normal |
+----+---------+--------+
4 rows in set (0.00 sec)

mysql> SELECT * FROM articles;
+----+-----------------------------+---------+-------------+
| id | content                     | user_id | category_id |
+----+-----------------------------+---------+-------------+
|  6 | Snow White and Seven Dwarfs |       5 |           1 |
|  7 | Artificial Intelligence     |       1 |           4 |
|  8 | Angels and Demons           |       2 |           5 |
|  9 | Blind River                 |       2 |           3 |
+----+-----------------------------+---------+-------------+
4 rows in set (0.00 sec)

mysql> SELECT * FROM categories;
+----+----------------------+
| id | category             |
+----+----------------------+
|  1 | Science & Technology |
|  3 | Biography            |
|  4 | Non Fiction          |
|  5 | Comics               |
+----+----------------------+
4 rows in set (0.00 sec)

mysql> SELECT * FROM comments;
+----+------------+------------------------------------+---------+
| id | article_id | content                            | user_id |
+----+------------+------------------------------------+---------+
|  4 |          6 | Complete package, enjoyed reading  |       1 |
|  5 |          7 | Could be improvised more           |       1 |
|  6 |          7 | Nice article,specified pin details |       2 |
+----+------------+------------------------------------+---------+
3 rows in set (0.00 sec)

mysql> INSERT INTO comments(article_id, content, user_id) VALUES
    -> (8, "Good work", 2),
    -> (9, "Nice work", 2),
    -> (8, "Average", 3);
Query OK, 3 rows affected (0.01 sec)
Records: 3  Duplicates: 0  Warnings: 0

mysql> SELECT * FROM comments;
+----+------------+------------------------------------+---------+
| id | article_id | content                            | user_id |
+----+------------+------------------------------------+---------+
|  4 |          6 | Complete package, enjoyed reading  |       1 |
|  5 |          7 | Could be improvised more           |       1 |
|  6 |          7 | Nice article,specified pin details |       2 |
|  9 |          8 | Good work                          |       2 |
| 10 |          9 | Nice work                          |       2 |
| 11 |          8 | Average                            |       3 |
+----+------------+------------------------------------+---------+
6 rows in set (0.00 sec)
