***Exercise_queries***
**Ques - 1 Find the employee who gets highest total commission**

mysql> select distinct name from employees left join
    -> commissions on employee_id where
    -> employees.id IN (
    -> select commissions.employee_id from commissions
    -> where commissions.commission_amount = (select MAX(commission_amount) from commissions));
+-------------+
| name        |
+-------------+
| Chris Gayle |
| Wasim Akram |
+-------------+
2 rows in set (0.00 sec)


**Ques-2 Select employee with 4th highest salary**

mysql> select name, salary from employees
    -> order by salary desc
    -> limit 1 offset 3;
+--------------+--------+
| name         | salary |
+--------------+--------+
| Rahul Dravid | 700000 |
+--------------+--------+
1 row in set (0.00 sec)

**Ques-3 Find the department that is giving highest commission**

mysql> select name from departments where
    -> id IN (
    -> select department_id from employees join commissions
    -> on employee_id = employees.id where
    -> commission_amount = (
    -> select MAX(commission_amount) from commissions));
+---------+
| name    |
+---------+
| banking |
| service |
+---------+
2 rows in set (0.00 sec)

**Ques-4 Find employees with commission greater than Rs.3000**

mysql> select group_concat(name) as Employees,
    -> commission_amount as Commission_Paid from
    -> employees join commissions
    -> on employee_id = employees.id
    -> group by commission_amount
    -> having commission_amount > 3000;
+--------------------------+-----------------+
| Employees                | Commission_Paid |
+--------------------------+-----------------+
| Rahul Dravid,Chris Gayle |            4000 |
| Chris Gayle,Wasim Akram  |            5000 |
+--------------------------+-----------------+
2 rows in set (0.00 sec)



****Database Schema****
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

mysql> select * from departments;
+----+-----------+
| id | name      |
+----+-----------+
|  1 | banking   |
|  2 | insurance |
|  3 | service   |
+----+-----------+
3 rows in set (0.00 sec)

mysql> select * from employees;
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

mysql> select * from commissions;
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
+----+-------------+-------------------+
8 rows in set (0.00 sec)

**creating index as commission_amount because its referenced most of the time**
mysql> create index commission_amount on commissions(commission_amount);
Query OK, 0 rows affected (0.05 sec)
Records: 0  Duplicates: 0  Warnings: 0
