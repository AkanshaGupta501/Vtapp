**************EXERCISE QUERIES*****************
**QUERY -1 Select all articles whose author name is user 3 **

mysql> select content from articles, users where articles.user_id = users.id AND users.name = 'user3';
+-----------------------------+
| content                     |
+-----------------------------+
| How AI overpowered humans?  |
| Junk food or home made food |
| Lets sing medleys           |
+-----------------------------+
3 rows in set (0.00 sec)

**Query 2 - For all the articles being selected above, select all the articles and also the comments associated with those articles in a single query**

mysql> select articles.content, group_concat(comments.content separator '----') as Comments
    -> from articles, users, comments
    -> where articles.id = comments.article_id AND
    -> articles.user_id = users.id AND
    -> users.name = 'user3' group by articles.id;
+-----------------------------+--------------------------------------------------------------------------------------------+
| content                     | Comments                                                                                   |
+-----------------------------+--------------------------------------------------------------------------------------------+
| How AI overpowered humans?  | Nice article, with great insights of AI in our day to day life----Nice article----Good job |
| Junk food or home made food | Good work----Nice work                                                                     |
| Lets sing medleys           | Average Work                                                                               |
+-----------------------------+--------------------------------------------------------------------------------------------+
3 rows in set (0.00 sec)



----using nested subquery------
mysql> select articles.content, group_concat(comments.content) as Comments from
    -> articles left join comments
    -> on article_id = articles.id
    -> where articles.user_id = (select users.id from users where users.name = 'user3') group by articles.id;
+-----------------------------+--------------------------------------------------------------------------------------+
| content                     | Comments                                                                             |
+-----------------------------+--------------------------------------------------------------------------------------+
| How AI overpowered humans?  | Nice article, with great insights of AI in our day to day life,Nice article,Good job |
| Junk food or home made food | Good work,Nice work                                                                  |
| Lets sing medleys           | Average Work                                                                         |
+-----------------------------+--------------------------------------------------------------------------------------+
3 rows in set (0.00 sec)


**Query -3 Write a query to select all articles which do not have any comments**

mysql> select articles.content as Articles from
    -> articles left join comments
    -> on article_id = articles.id
    -> where comments.content IS NULL;
+----------------------------------+
| Articles                         |
+----------------------------------+
| Analysing the possibilities      |
| Home is there where parents live |
+----------------------------------+
2 rows in set (0.00 sec)

**Query 4 Write a query to select article which has maximum comments**

mysql> select articles.content, count(comments.id) AS Count from
    -> articles left join comments
    -> on article_id  = articles.id
    -> group by articles.id
    -> having count(comments.id) =
    -> (select count(articles.id) from
    -> articles join comments
    -> on article_id = articles.id
    -> group by articles.id
    -> order by count(articles.id) DESC limit 1);
+----------------------------+-------+
| content                    | Count |
+----------------------------+-------+
| How AI overpowered humans? |     3 |
+----------------------------+-------+
1 row in set (0.00 sec)


**Query 5 Write a query to select article which does not have more than one comment by the same user ( do this using left join and group by )**

mysql> select articles.content, comments.content from
    -> articles left join comments
    -> on article_id = articles.id
    -> group by articles.id
    -> having count(distinct comments.user_id)  = count(comments.user_id);
+--------------------------------------------------+----------------------------------------------------------------+
| content                                          | content                                                        |
+--------------------------------------------------+----------------------------------------------------------------+
| How AI overpowered humans?                       | Nice article, with great insights of AI in our day to day life |
| Let's juggle spices                              | Average article                                                |
| Best out of Waste                                | Delhi's my favourite too....                                   |
| Analysing the possibilities                      | NULL                                                           |
| Travelling to the heart of India                 | Good article                                                   |
| New trends in Bollywood                          | Both are best in their genres                                  |
| Bringing out the best in us                      | Proud of her, making india proud                               |
| Avavni Chaturvedi - First Women Fighter Pilot    | Nice work                                                      |
| Know your house                                  | Amazing pieces, will try them soon                             |
| Mohammad Rafi or Kishore Kumar what's your take? | OMG! never thought of using old carpet like this               |
| Junk food or home made food                      | Good work                                                      |
| Lets sing medleys                                | Average Work                                                   |
| Home is there where parents live                 | NULL                                                           |
| Empowering children                              | Good back old days                                             |
+--------------------------------------------------+----------------------------------------------------------------+
14 rows in set (0.00 sec)

mysql> insert into comments(article_id, content, user_id) values
    -> (12, 'Good work by author', 6),
    -> (1, 'Nice work', 8);
Query OK, 2 rows affected (0.02 sec)
Records: 2  Duplicates: 0  Warnings: 0

mysql> select articles.content, count(comments.user_id) from
    -> articles left join comments
    -> on article_id = articles.id
    -> group by articles.id
    -> having count(distinct comments.user_id) = count(comments.user_id);
+--------------------------------------------------+-------------------------+
| content                                          | count(comments.user_id) |
+--------------------------------------------------+-------------------------+
| Let's juggle spices                              |                       1 |
| Best out of Waste                                |                       1 |
| Analysing the possibilities                      |                       0 |
| Travelling to the heart of India                 |                       2 |
| New trends in Bollywood                          |                       2 |
| Bringing out the best in us                      |                       2 |
| Avavni Chaturvedi - First Women Fighter Pilot    |                       1 |
| Know your house                                  |                       1 |
| Mohammad Rafi or Kishore Kumar what's your take? |                       1 |
| Junk food or home made food                      |                       2 |
| Home is there where parents live                 |                       0 |
| Empowering children                              |                       1 |
+--------------------------------------------------+-------------------------+
12 rows in set (0.00 sec)


*******************************DATABASE SCHEMA**********************************

mysql> create database blogs;
Query OK, 1 row affected (0.00 sec)

mysql> use blogs;
Database changed
mysql> create table users(
    -> id int auto_increment,
    -> name varchar(30),
    -> role enum('normal', 'admin'),
    -> primary key(id));
Query OK, 0 rows affected (0.03 sec)

mysql> create table categories(
    -> id int auto_increment,
    -> category varchar(50),
    -> primary key(id));
Query OK, 0 rows affected (0.02 sec)

mysql> create table articles(
    -> id int auto_increment,
    -> content varchar(10000),
    -> user_id int,
    -> category_id int,
    -> primary key(id),
    -> foreign key(user_id) references users(id),
    -> foreign key(category_id) references categories(id));
Query OK, 0 rows affected (0.02 sec)

mysql> create table comments(
    -> id int auto_increment,
    -> article_id int,
    -> content varchar(1000),
    -> user_id int,
    -> primary key(id),
    -> foreign key(article_id) references articles(id),
    -> foreign key(user_id) references users(id));
Query OK, 0 rows affected (0.01 sec)

mysql> describe users;
+-------+------------------------+------+-----+---------+----------------+
| Field | Type                   | Null | Key | Default | Extra          |
+-------+------------------------+------+-----+---------+----------------+
| id    | int(11)                | NO   | PRI | NULL    | auto_increment |
| name  | varchar(30)            | YES  |     | NULL    |                |
| role  | enum('normal','admin') | YES  |     | NULL    |                |
+-------+------------------------+------+-----+---------+----------------+
3 rows in set (0.02 sec)

mysql> describe categories;
+----------+-------------+------+-----+---------+----------------+
| Field    | Type        | Null | Key | Default | Extra          |
+----------+-------------+------+-----+---------+----------------+
| id       | int(11)     | NO   | PRI | NULL    | auto_increment |
| category | varchar(50) | YES  |     | NULL    |                |
+----------+-------------+------+-----+---------+----------------+
2 rows in set (0.02 sec)

mysql> describe articles;
+-------------+----------------+------+-----+---------+----------------+
| Field       | Type           | Null | Key | Default | Extra          |
+-------------+----------------+------+-----+---------+----------------+
| id          | int(11)        | NO   | PRI | NULL    | auto_increment |
| content     | varchar(10000) | YES  |     | NULL    |                |
| user_id     | int(11)        | YES  | MUL | NULL    |                |
| category_id | int(11)        | YES  | MUL | NULL    |                |
+-------------+----------------+------+-----+---------+----------------+
4 rows in set (0.02 sec)

mysql> describe comments;
+------------+---------------+------+-----+---------+----------------+
| Field      | Type          | Null | Key | Default | Extra          |
+------------+---------------+------+-----+---------+----------------+
| id         | int(11)       | NO   | PRI | NULL    | auto_increment |
| article_id | int(11)       | YES  | MUL | NULL    |                |
| content    | varchar(1000) | YES  |     | NULL    |                |
| user_id    | int(11)       | YES  | MUL | NULL    |                |
+------------+---------------+------+-----+---------+----------------+
4 rows in set (0.02 sec)


mysql> insert into users (name, role) values
    -> ('Akansha', 'admin'),
    -> ('Ashish', 'normal'),
    -> ('Pullu', 'normal'),
    -> ('user3', 'normal'),
    -> ('Preeti', 'normal'),
    -> ('Abhishek', 'normal'),
    -> ('Sandhya', 'normal'),
    -> ('Vedansh', 'normal'),
    -> ('Aastha', 'normal'),
    -> ('Niki', 'normal');
Query OK, 10 rows affected (0.01 sec)
Records: 10  Duplicates: 0  Warnings: 0

mysql> insert into categories(category) values
    -> ('Science & technology'),
    -> ('Lifestyle'),
    -> ('Travelling'),
    -> ('Food'),
    -> ('Entertainment'),
    -> ('Music & Media'),
    -> ('Current Affairs'),
    -> ('Education'),
    -> ('Arts'),
    -> ('Productivity');
Query OK, 10 rows affected (0.00 sec)
Records: 10  Duplicates: 0  Warnings: 0

mysql> insert into articles(content, user_id, category_id) values
    -> ('How AI overpowered humans?',4,1),
    -> ('Let\'s juggle spices', 8, 4),
    -> ('Best out of Waste', 10, 9),
    -> ('Analysing the possibilities', 6, 8),
    -> ('Travelling to the heart of India', 2, 3),
    -> ('New trends in Bollywood', 9, 5),
    -> ('Bringing out the best in us', 7, 2),
    -> ('Avavni Chaturvedi - First Women Fighter Pilot', 1, 7),
    -> ('Know your house', 3, 10),
    -> ('Mohammad Rafi or Kishore Kumar what\'s your take?', 5, 6);
Query OK, 10 rows affected (0.00 sec)
Records: 10  Duplicates: 0  Warnings: 0

mysql> insert into comments(article_id, content, user_id) values
    -> (1, 'Nice article, with great insights of AI in our day to day life', 9),
    -> (2, 'Average article', 7),
    -> (3, 'Delhi\'s my favourite too....', 5),
    -> (4, 'Totally agree, india is home of world\'s best spices', 3),
    -> (5, 'Good article', 10),
    -> (6, 'Both are best in their genres', 1),
    -> (7, 'Proud of her, making india proud', 8),
    -> (8, 'Nice work', 6),
    -> (9, 'Amazing pieces, will try them soon', 4),
    -> (10, 'OMG! never thought of using old carpet like this', 2),
    -> (3, 'Some places are not good as before', 2),
    -> (5, 'Nice work by the author', 8),
    -> (6, 'Mohammaad rafi', 8),
    -> (7, 'We need more youth to save motherland', 6);
Query OK, 14 rows affected (0.00 sec)
Records: 14  Duplicates: 0  Warnings: 0

mysql> insert into articles(content, user_id, category_id) values
    -> ('Junk food or home made food', 4, 4),
    -> ('Lets sing medleys', 4, 6),
    -> ('Home is there where parents live', 1, 8),
    -> ('Empowering children', 5, 8);
Query OK, 4 rows affected (0.00 sec)
Records: 4  Duplicates: 0  Warnings: 0

mysql> select * from users;
+----+----------+--------+
| id | name     | role   |
+----+----------+--------+
|  1 | Akansha  | admin  |
|  2 | Ashish   | normal |
|  3 | Pullu    | normal |
|  4 | user3    | normal |
|  5 | Preeti   | normal |
|  6 | Abhishek | normal |
|  7 | Sandhya  | normal |
|  8 | Vedansh  | normal |
|  9 | Aastha   | normal |
| 10 | Niki     | normal |
+----+----------+--------+
10 rows in set (0.00 sec)

mysql> select * from categories;
+----+----------------------+
| id | category             |
+----+----------------------+
|  1 | Science & technology |
|  2 | Lifestyle            |
|  3 | Travelling           |
|  4 | Food                 |
|  5 | Entertainment        |
|  6 | Music & Media        |
|  7 | Current Affairs      |
|  8 | Education            |
|  9 | Arts                 |
| 10 | Productivity         |
+----+----------------------+
10 rows in set (0.00 sec)

mysql> select * from articles;
+----+--------------------------------------------------+---------+-------------+
| id | content                                          | user_id | category_id |
+----+--------------------------------------------------+---------+-------------+
|  1 | How AI overpowered humans?                       |       4 |           1 |
|  2 | Let's juggle spices                              |       8 |           4 |
|  3 | Best out of Waste                                |      10 |           9 |
|  4 | Analysing the possibilities                      |       6 |           8 |
|  5 | Travelling to the heart of India                 |       2 |           3 |
|  6 | New trends in Bollywood                          |       9 |           5 |
|  7 | Bringing out the best in us                      |       7 |           2 |
|  8 | Avavni Chaturvedi - First Women Fighter Pilot    |       1 |           7 |
|  9 | Know your house                                  |       3 |          10 |
| 10 | Mohammad Rafi or Kishore Kumar what's your take? |       5 |           6 |
| 11 | Junk food or home made food                      |       4 |           4 |
| 12 | Lets sing medleys                                |       4 |           6 |
| 13 | Home is there where parents live                 |       1 |           8 |
| 14 | Empowering children                              |       5 |           8 |
+----+--------------------------------------------------+---------+-------------+
14 rows in set (0.00 sec)

mysql> select * from comments;
+----+------------+----------------------------------------------------------------+---------+
| id | article_id | content                                                        | user_id |
+----+------------+----------------------------------------------------------------+---------+
|  1 |          1 | Nice article, with great insights of AI in our day to day life |       9 |
|  2 |          2 | Average article                                                |       7 |
|  3 |          3 | Delhi's my favourite too....                                   |       5 |
|  4 |          4 | Totally agree, india is home of world's best spices            |       3 |
|  5 |          5 | Good article                                                   |      10 |
|  6 |          6 | Both are best in their genres                                  |       1 |
|  7 |          7 | Proud of her, making india proud                               |       8 |
|  8 |          8 | Nice work                                                      |       6 |
|  9 |          9 | Amazing pieces, will try them soon                             |       4 |
| 10 |         10 | OMG! never thought of using old carpet like this               |       2 |
| 11 |          3 | Some places are not good as before                             |       2 |
| 12 |          5 | Nice work by the author                                        |       8 |
| 13 |          6 | Mohammaad rafi                                                 |       8 |
| 14 |          7 | We need more youth to save motherland                          |       6 |
+----+------------+----------------------------------------------------------------+---------+
14 rows in set (0.00 sec)
