# Postgres Cheatsheet

Postgres has multiple shortcut functions, starting with a forward slash, "\"

Any SQL command that is not a shortcut, must end with a semicolon, ";"

## Connect ##

[psql reference](http://www.postgresql.org/docs/current/static/app-psql.html)

```sql
psql

psql -U <username> -d <database> -h <hostname>

psql --username=<username> --dbname=<database> --host=<hostname>
```

## Disconnect ##

```sql
\q
\!
```


## Clear The Screen ##

```sql
(CTRL + L)
```

## Info ##

```sql
\conninfo
```

### Show Version ###
```
SHOW SERVER_VERSION;
```

### Show System Status ###

```sql
\conninfo
```

### Show Environmental Variables ###

```sql
SHOW ALL;
```

### List Users ###

```sql
SELECT rolname FROM pg_roles;
```

### Show Current User ###

```sql
SELECT current_user;
```

### Show Current User's Permissions ###

```
\du
```

### List Databases ###

```sql
\l
```

### Show Current Database ###

```sql
SELECT current_database();
```

### Show All Tables In Database ###

```sql
\dt
```

### List Functions ###

```sql
\df <schema>
```

## Configure ##

[Runtime Configuration](http://www.postgresql.org/docs/current/static/runtime-config.html)

```shell
sudo nano $(locate -l 1 main/postgresql.conf)
sudo service postgresql restart
```

## Debug Logs ##

```shell
# print the last 24 lines of the debug log
sudo tail -24 $(find /var/log/postgresql -name 'postgresql-*-main.log')
```

## Databases ##

### List Databases ###
Also shows owner info and access privileges, etc.

```sql
\l
```

### Show Database Owner ###

```sql
SELECT d.datname as "Name",
pg_catalog.pg_get_userbyid(d.datdba) as "Owner"
FROM pg_catalog.pg_database d
WHERE d.datname = 'database_name'
ORDER BY 1;
```

### Connect to Database ###

```sql
\c <database_name>
```

### Show Current Database ###

```sql
SELECT current_database();
```

### Create Database ###

[Reference](http://www.postgresql.org/docs/current/static/sql-createdatabase.html)

```sql
CREATE DATABASE <database_name> WITH OWNER <username>;
```

### Delete Database ###
[Reference](http://www.postgresql.org/docs/current/static/sql-dropdatabase.html)

```sql
DROP DATABASE IF EXISTS <database_name>;
```

### Rename Database ###
[Reference](http://www.postgresql.org/docs/current/static/sql-alterdatabase.html)

```sql
ALTER DATABASE <old_name> RENAME TO <new_name>;
```

## Users ##

### Show Users ###

```sql
\du
```

### List Roles ###

```sql
SELECT rolname FROM pg_roles;
```

### Create User ###
[Reference](http://www.postgresql.org/docs/current/static/sql-createuser.html)

```sql
CREATE USER <user_name> WITH PASSWORD '<password>';
```

### Drop User ###
[Reference](http://www.postgresql.org/docs/current/static/sql-dropuser.html)

```sql
DROP USER IF EXISTS <user_name>;
```

### Alter User Password ###
[Reference](http://www.postgresql.org/docs/current/static/sql-alterrole.html)

```sql
ALTER ROLE <user_name> WITH PASSWORD '<password>';
```

## Permissions ##
[Excellent Article](https://www.depesz.com/2007/10/19/grantall/)

### Become the postgres User (If you have permission errors) ###

```shell
sudo su - postgres
psql
```

### View List of Relations ###

```sql
\dt
```

### View Permissions on Single Table ###

```sql
\z MyTable
```
### List Users and Their Permissions ###

```sql
\du
```

### Grant All Permissions on Database ###
[Reference](http://www.postgresql.org/docs/current/static/sql-grant.html)

```sql
GRANT ALL PRIVILEGES ON DATABASE <db_name> TO <user_name>;
```

### Grant Connection Permissions on Database ###

```sql
GRANT CONNECT ON DATABASE <db_name> TO <user_name>;
```

### Grant Permissions on Schema ###

```sql
GRANT USAGE ON SCHEMA public TO <user_name>;
```

### Grant Permissions to Functions ###

```sql
GRANT EXECUTE ON ALL FUNCTIONS IN SCHEMA public TO <user_name>;
```

### Grant Permissions to SELECT, UPDATE, INSERT, DELETE on ALL Tables ###

```sql
GRANT SELECT, UPDATE, INSERT ON ALL TABLES IN SCHEMA public TO <user_name>;
```

### Grant Permissions on a Table ###

```sql
GRANT SELECT, UPDATE, INSERT ON <table_name> TO <user_name>;
```

### Grant Permissions to SELECT on a Table ###

```sql
GRANT SELECT ON ALL TABLES IN SCHEMA public TO <user_name>;
```

## Schema ##

###  List Schemas ###

```sql
\dn

SELECT schema_name FROM information_schema.schemata;

SELECT nspname FROM pg_catalog.pg_namespace;
```

###  Create Schema ###
[Reference](http://www.postgresql.org/docs/current/static/sql-createschema.html)

```sql
CREATE SCHEMA IF NOT EXISTS <schema_name>;
```

###  Drop Schema ###
[Reference](http://www.postgresql.org/docs/current/static/sql-dropschema.html)

```sql
DROP SCHEMA IF EXISTS <schema_name> CASCADE;
```

## Tables ##

### List Tables in Current DB ###

```sql
\dt

SELECT table_schema,table_name FROM information_schema.tables ORDER BY table_schema,table_name;
```

### List Tables Globally ###

```sql
\dt *.*.

SELECT * FROM pg_catalog.pg_tables
```

### List Table Schema ###

```sql
\d <table_name>
\d+ <table_name>

SELECT column_name, data_type, character_maximum_length
FROM INFORMATION_SCHEMA.COLUMNS
WHERE table_name = '<table_name>';
```

### Create Table ###
[Reference](http://www.postgresql.org/docs/current/static/sql-createtable.html)
```sql
CREATE TABLE <table_name>(
  <column_name> <column_type>,
  <column_name> <column_type>
);
```

### Create Table With an Auto-Incrementing Primary Key ###

```sql
CREATE TABLE <table_name> (
  <column_name> SERIAL PRIMARY KEY
);
```

### Delete Table ###
[Reference](http://www.postgresql.org/docs/current/static/sql-droptable.html)

```sql
DROP TABLE IF EXISTS <table_name> CASCADE;
```

## Columns ##

### View Columns ###
```bash
SELECT column_name FROM information_schema.columns WHERE table_name = '<table_name>' ORDER BY ordinal_position;
```
This approach may also work:
```bash
SELECT * FROM <table_name> WHERE false;
```
In other cases, you may have to use the following:
```bash
SELECT * FROM <table_name> WHERE 1 = 0;
```

### Add Column ###
[Reference](http://www.postgresql.org/docs/current/static/sql-altertable.html)

```sql
ALTER TABLE <table_name> IF EXISTS
ADD <column_name> <data_type> [<constraints>];
```

### Update Column ###

```sql
ALTER TABLE <table_name> IF EXISTS
ALTER <column_name> TYPE <data_type> [<constraints>];
```

### Delete Column ###

```sql
ALTER TABLE <table_name> IF EXISTS
DROP <column_name>;
```

### Update Column To Be an Auto-Incrementing Primary Key ###

```sql
ALTER TABLE <table_name>
ADD COLUMN <column_name> SERIAL PRIMARY KEY;
```

### Insert Into a Table With an Auto-Incrementing Primary Key ###

```sql
INSERT INTO <table_name>
VALUES (DEFAULT, <value1>);

INSERT INTO <table_name> (<column1_name>,<column2_name>)
VALUES ( <value1>,<value2> );
```

## Data ##

### Read All Data ###
[Reference](http://www.postgresql.org/docs/current/static/sql-select.html)
```sql
SELECT * FROM <table_name>;
```

### Read One Row of Data ###

```sql
SELECT * FROM <table_name> LIMIT 1;
```

### Search For Data ###

```sql
SELECT * FROM <table_name> WHERE <column_name> = <value>;
```

### Insert Data ###
[Reference](http://www.postgresql.org/docs/current/static/sql-insert.html)

```sql
INSERT INTO <table_name> VALUES( <value_1>, <value_2> );
```

### Edit Data ###
[Reference](http://www.postgresql.org/docs/current/static/sql-update.html)

```sql
UPDATE <table_name>
SET <column_1> = <value_1>, <column_2> = <value_2>
WHERE <column_1> = <value>;
```

### Delete All Data ###
[Reference](http://www.postgresql.org/docs/current/static/sql-delete.html)

```sql
DELETE FROM <table_name>;
```

### Delete Specific Data ###

```sql
DELETE FROM <table_name>
WHERE <column_name> = <value>;
```

## Scripting ##

### Run Local Script On Remote Host ###
[Reference](http://www.postgresql.org/docs/current/static/app-psql.html)

```shell
psql -U <username> -d <database> -h <host> -f <local_file>

psql --username=<username> --dbname=<database> --host=<host> --file=<local_file>
```

### Backup Database Data (Everything) ###
[Reference](http://www.postgresql.org/docs/current/static/app-pgdump.html)

```shell
pg_dump <database_name>

pg_dump <database_name>
```

### Backup Database (Only Data) ###

```shell
pg_dump -a <database_name>

pg_dump --data-only <database_name>
```

### Backup Database (Only Schema) ###

```shell
pg_dump -s <database_name>

pg_dump --schema-only <database_name>
```

### Restore Database Data ###
[Reference](http://www.postgresql.org/docs/current/static/app-pgrestore.html)

```shell
pg_restore -d <database_name> -a <file_pathway>

pg_restore --dbname=<database_name> --data-only <file_pathway>
```

### Restore Database Schema ###

```shell
pg_restore -d <database_name> -s <file_pathway>

pg_restore --dbname=<database_name> --schema-only <file_pathway>
```

### Export Table (to CSV File) ###
[Reference](http://www.postgresql.org/docs/current/static/sql-copy.html)

```sql
\copy <table_name> TO '<file_path>' CSV
```

### Export Table (Specific Columns to CSV File)

```sql
\copy <table_name>(<column_1>,<column_1>,<column_1>) TO '<file_path>' CSV
```

### Import CSV File Into Table ###
[Reference](http://www.postgresql.org/docs/current/static/sql-copy.html)

```sql
\copy <table_name> FROM '<file_path>' CSV
```

### Import CSV File Into Table (Only Specific Columns) ###

```sql
\copy <table_name>(<column_1>,<column_1>,<column_1>) FROM '<file_path>' CSV
```

## Debugging ##

http://www.postgresql.org/docs/current/static/using-explain.html

http://www.postgresql.org/docs/current/static/runtime-config-logging.html

## Advanced Features
http://www.tutorialspoint.com/postgresql/postgresql_constraints.htm

### Functions ###

#### Create ####

```sql
  CREATE OR REPLACE FUNCTION removeTables() RETURNS void
  LANGUAGE plpgsql
  AS $$
  DECLARE
    rec record;
  BEGIN
    FOR rec IN (SELECT tablename FROM pg_tables WHERE schemaname = current_schema() AND tablename <> 'spatial_ref_sys') LOOP
      EXECUTE 'DROP TABLE IF EXISTS ' || quote_ident(rec.tablename) || ' CASCADE';
    END LOOP;
  END;
  $$;
  ```
#### Get Function Owner ####
[StackOverflow](https://dba.stackexchange.com/questions/259001/postgres-get-function-owner)

```sql
SELECT proname,
       proowner::regrole
FROM pg_proc
WHERE pronamespace::regnamespace::text = 'public';
```
Note: You may prefer `oid::regprocedure` over `proname`

#### Delete Function ####

```sql
DROP FUNCTION IF EXISTS Foo;
```
If that fails, you may have to include parameters.  Some Postgres versions require them to distinguish overloaded functions. To unambiguously identify a function you can put only types of its parameters.

```sql
DROP FUNCTION IF EXISTS Foo(INT);
```

