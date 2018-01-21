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


ADD JAR /home/orienit/Jars/hivexmlserde-1.0.5.3.jar;

CREATE TABLE IF NOT EXISTS employee1_xml ( empid int, name string, salary float, dept string )
ROW FORMAT SERDE 'com.ibm.spss.hive.serde2.xml.XmlSerDe'
WITH SERDEPROPERTIES (
"column.xpath.empid"="/employee/empid/text()",
"column.xpath.name"="/employee/name/text()",
"column.xpath.salary"="/employee/salary/text()",
"column.xpath.dept"="/employee/dept/text()"
)
STORED AS
INPUTFORMAT 'com.ibm.spss.hive.serde2.xml.XmlInputFormat'
OUTPUTFORMAT 'org.apache.hadoop.hive.ql.io.IgnoreKeyTextOutputFormat'
TBLPROPERTIES (
"xmlinput.start"="<employee",
"xmlinput.end"="</employee>"
);

LOAD DATA LOCAL INPATH '/home/orienit/input-files/employee1.xml' OVERWRITE INTO TABLE employee1_xml;

CREATE TABLE employee1_op AS select * from employee1_xml where empid > 2 and dept = 'dev';
