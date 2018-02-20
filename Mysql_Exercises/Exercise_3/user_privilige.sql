mysql> create database vtapp;
Query OK, 1 row affected (0.01 sec)

mysql> use vtapp;
Database changed

#Create the user
mysql> CREATE USER 'vtapp_user'@'localhost' IDENTIFIED BY '1234';
Query OK, 0 rows affected (0.00 sec)

#Grant permissions to the user
mysql> GRANT ALL PRIVILEGES ON vtapp.* TO 'vtapp_user'@'localhost';
Query OK, 0 rows affected (0.00 sec)

