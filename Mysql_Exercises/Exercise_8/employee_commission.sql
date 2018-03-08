***Exercise_queries***
**Ques - 1 Find the employee who gets highest total commission**

mysql> SELECT employees.name, SUM(commission_amount) AS Total_Amount
    -> FROM employees LEFT JOIN commissions
    -> ON employee_id = employees.id
    -> GROUP BY employee_id
    -> HAVING Total_Amount = (SELECT MAX(total) FROM (
    -> SELECT sum(commission_amount) AS total
    -> FROM commissions
    -> GROUP BY employee_id) HighestCommission);
+-------------+--------------+
| name        | Total_Amount |
+-------------+--------------+
| Chris Gayle |         9000 |
| Wasim Akram |         9000 |
+-------------+--------------+
2 rows in set (0.00 sec)

**Ques-2 Select employee with 4th highest salary**

mysql> mysql> SELECT name FROM employees
    -> INNER JOIN (
    -> SELECT salary FROM employees
    -> GROUP BY salary
    -> ORDER BY salary DESC
    -> LIMIT 1 offset 3) FourthHighest
    -> ON employees.salary = FourthHighest.salary;
+--------------+
| name         |
+--------------+
| Rahul Dravid |
| MS DHoni     |
+--------------+
2 rows in set (0.00 sec)


**Ques-3 Find the department that is giving highest commission**

mysql> SELECT departments.name AS Department,
     Total_Commission FROM departments
     LEFT JOIN (
     SELECT employees.department_id, sum(commission_amount) AS Total_Commission
     FROM employees
     LEFT JOIN commissions
     ON employee_id = employees.id
     GROUP BY employees.department_id) AS departments_commission
     ON departments.id = departments_commission.department_id
     GROUP BY Total_Commission
     having Total_Commission = (SELECT MAX(total) FROM (
     SELECT sum(commission_amount) AS total 
       FROM employees LEFT JOIN commissions
     ON employee_id = employees.id
     GROUP BY employees.department_id) HighestCommission);
+------------+------------------+
| Department | Total_Commission |
+------------+------------------+
| banking    |            13000 |
+------------+------------------+
1 row in set (0.00 sec)

**Ques-4 Find employees with commission greater than Rs.3000**

mysql> SELECT group_concat(name) AS Employees,
    -> commission_amount AS Commission_Paid FROM
    -> employees join commissions
    -> ON employee_id = employees.id
    -> GROUP BY commission_amount
    -> HAVING commission_amount > 3000;
+--------------------------+-----------------+
| Employees                | Commission_Paid |
+--------------------------+-----------------+
| Rahul Dravid,Chris Gayle |            4000 |
| Chris Gayle,Wasim Akram  |            5000 |
+--------------------------+-----------------+
2 rows in set (0.00 sec)



****Database Schema****

mysql> SELECT * FROM departments;
+----+-----------+
| id | name      |
+----+-----------+
|  1 | banking   |
|  2 | insurance |
|  3 | service   |
+----+-----------+
3 rows in set (0.00 sec)

mysql> SELECT * FROM employees;
+----+---------------+---------+---------------+
| id | name          | salary  | department_id |
+----+---------------+---------+---------------+
|  1 | Chris Gayle   | 1000000 |             1 |
|  2 | Michael Clark |  800000 |             2 |
|  3 | Rahul Dravid  |  700000 |             1 |
|  4 | Ricky Ponting |  600000 |             2 |
|  5 | Albie Morkel  |  650000 |             2 |
|  6 | Wasim Akram   |  750000 |             3 |
+----+---------------+---------+---------------+
6 rows in set (0.00 sec)

mysql> SELECT * FROM commissions;
+----+-------------+-------------------+
| id | employee_id | commission_amount |
+----+-------------+-------------------+
|  1 |           1 |              5000 |
|  2 |           2 |              3000 |
|  3 |           3 |              4000 |
|  4 |           1 |              4000 |
|  5 |           2 |              3000 |
|  6 |           4 |              2000 |
|  7 |           5 |              1000 |
|  8 |           6 |              5000 |
|  9 |           6 |              4000 |
+----+-------------+-------------------+
9 rows in set (0.02 sec)


mysql> create database employee_commission;
Query OK, 1 row affected (0.01 sec)

mysql> use employee_commission;
Database changed
mysql> create table departments(
    -> id int auto_increment,
    -> name varchar(30) not null,
    -> primary key(id));
Query OK, 0 rows affected (0.02 sec)

mysql> create table employees(
    -> id int auto_increment,
    -> name varchar(30) not null,
    -> salary int(100) default 0,
    -> department_id int not null,
    -> primary key(id));
Query OK, 0 rows affected (0.02 sec)

mysql> create table commissions(
    -> id int auto_increment,
    -> employee_id int not null,
    -> commission_amount int(100) not null,
    -> primary key(id),
    -> foreign key(employee_id) references employees(id));
Query OK, 0 rows affected (0.01 sec)

mysql> alter table employees add foreign key(department_id) references departments(id);
Query OK, 0 rows affected (0.03 sec)
Records: 0  Duplicates: 0  Warnings: 0

mysql> describe departments;
+-------+-------------+------+-----+---------+----------------+
| Field | Type        | Null | Key | Default | Extra          |
+-------+-------------+------+-----+---------+----------------+
| id    | int(11)     | NO   | PRI | NULL    | auto_increment |
| name  | varchar(30) | NO   |     | NULL    |                |
+-------+-------------+------+-----+---------+----------------+
2 rows in set (0.02 sec)

mysql> describe employees;
+---------------+-------------+------+-----+---------+----------------+
| Field         | Type        | Null | Key | Default | Extra          |
+---------------+-------------+------+-----+---------+----------------+
| id            | int(11)     | NO   | PRI | NULL    | auto_increment |
| name          | varchar(30) | NO   |     | NULL    |                |
| salary        | int(100)    | YES  |     | 0       |                |
| department_id | int(11)     | NO   | MUL | NULL    |                |
+---------------+-------------+------+-----+---------+----------------+
4 rows in set (0.03 sec)

mysql> describe commissions;
+-------------------+----------+------+-----+---------+----------------+
| Field             | Type     | Null | Key | Default | Extra          |
+-------------------+----------+------+-----+---------+----------------+
| id                | int(11)  | NO   | PRI | NULL    | auto_increment |
| employee_id       | int(11)  | NO   | MUL | NULL    |                |
| commission_amount | int(100) | NO   |     | NULL    |                |
+-------------------+----------+------+-----+---------+----------------+
3 rows in set (0.02 sec)

mysql> insert into departments(name) values
    -> ('banking'),
    -> ('insurance'),
    -> ('service');
Query OK, 3 rows affected (0.00 sec)
Records: 3  Duplicates: 0  Warnings: 0

mysql> insert into employees(name, salary, department_id) values
    -> ('Chris Gayle', 1000000, 1),
    -> ('Michael Clark', '800000', 2),
    -> ('Rahul Dravid', 700000, 1),
    -> ('Ricky Ponting', 600000, 2),
    -> ('Albie Morkel', 650000, 2),
    -> ('Wasim Akram', 750000, 3);
Query OK, 6 rows affected (0.00 sec)
Records: 6  Duplicates: 0  Warnings: 0

mysql> insert into commissions(employee_id, commission_amount) values
    -> (1, 5000),
    -> (2, 3000),
    -> (3, 4000),
    -> (1, 4000),
    -> (2, 3000),
    -> (4, 2000),
    -> (5, 1000),
    -> (6, 5000);
Query OK, 8 rows affected (0.00 sec)
Records: 8  Duplicates: 0  Warnings: 0


**creating index as commission_amount because its referenced most of the time**
mysql> create index commission_amount on commissions(commission_amount);
Query OK, 0 rows affected (0.05 sec)
Records: 0  Duplicates: 0  Warnings: 0
