CREATE DATABASE IF NOT EXISTS kalyan
COMMENT 'My database name is kalyan'
LOCATION '/user/orienit/Govind/hive/kalyan'
WITH DBPROPERTIES ('creator' = 'Govind', 'date' = '2018-01-20');

USE kalyan;

CREATE TABLE IF NOT EXISTS employee1_json_raw(str string);
LOAD DATA LOCAL INPATH '/home/orienit/input-files/employee1.json' OVERWRITE INTO TABLE employee1_json_raw;

CREATE TABLE IF NOT EXISTS employee1_json ( empid int, name string, salary float, dept string );
INSERT INTO TABLE employee1_json select get_json_object(str,'$.empid') as empid, get_json_object(str,'$.name') as name, get_json_object(str,'$.salary') as salary, get_json_object(str,'$.dept') as dept from employee1_json_raw;

CREATE TABLE employee1_op AS select * from employee1_json where empid > 2 and dept = 'dev';


CREATE TABLE IF NOT EXISTS employee1_xml_raw(str string);
LOAD DATA LOCAL INPATH '/home/orienit/input-files/employee1.xml' OVERWRITE INTO TABLE employee1_xml_raw;

CREATE TABLE IF NOT EXISTS employee1_xml ( empid int, name string, salary float, dept string );
INSERT INTO TABLE employee1_xml 
select xpath(str,'employee/empid/text()') as empid, xpath(str,'employee/name/text()') as name, xpath(str,'employee/salary/text()') as salary, xpath(str,'employee/dept/text()') as dept from employee1_xml_raw;

CREATE TABLE employee1_op AS select * from employee1_xml where empid > 2 and dept = 'dev';
