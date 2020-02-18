# MySQL README
MySql Database version 8.0.16
---

Useful mysql commands for setting up development environment and reset root password

## Set Up

#### Create new database
    CREATE DATABASE lyt_db;

---

#### Create New User

##### Local user
    CREATE USER 'newuser'@'localhost' IDENTIFIED BY 'user_password';

##### Remote user
    CREATE USER 'newuser'@'10.8.0.5' IDENTIFIED BY 'user_password';

---

#### Grant Access Privileges
Grant permission format:
    GRANT permission1, permission2 ON database_name.table_name TO 'database_user'@'localhost';

Examples

    GRANT CREATE, DELETE, INSERT, SELECT, UPDATE ON lyt_db.* TO 'dev'@'localhost';

Grand all privileges to a user account on all databases:

    GRANT ALL PRIVILEGES ON *.* TO 'database_user'@'localhost';

Grant multiple privileges to a user account over a specific database:

    GRANT CREATE, SELECT, INSERT, DELETE, UPDATE ON database_name.* TO database_user@'localhost';

Common privileges
- ALL PRIVILEGES – Grants all privileges to a user account.
- CREATE – The user account is allowed to create databases and tables.
- DROP - The user account is allowed to drop databases and tables.
- DELETE - The user account is allowed to delete rows from a specific table.
- INSERT - The user account is allowed to insert rows into a specific table.
- SELECT – The user account is allowed to read a database.
- UPDATE - The user account is allowed to update table rows.
---
## Reset Root
Start mysql with the following flag

    mysql --skip-grant-tables;

In the mysql client, tell the server to reload the grant tables so that account-management statements work:

    FLUSH PRIVILEGES;

Reset root password

      ALTER USER 'root'@'localhost' IDENTIFIED BY 'MyNewPass';


## Common Errors

####  'Client does not support authentication protocol requested by server; consider upgrading MySQL client'

      ALTER USER 'user'@'host' IDENTIFIED WITH mysql_native_password BY 'password';

      FLUSH PRIVILEGES;

      [Stackoverflow](https://stackoverflow.com/questions/50093144/mysql-8-0-client-does-not-support-authentication-protocol-requested-by-server)



---
## Resources
NEW USER

https://linuxize.com/post/how-to-create-mysql-user-accounts-and-grant-privileges/

RESET PASSWORD

https://dev.mysql.com/doc/refman/8.0/en/resetting-permissions.html
