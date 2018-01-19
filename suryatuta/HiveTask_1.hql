Create database kalyan;
ADD JAR /usr/lib/hive-hcatalog/lib/hive-hcatalog-core.jar;
Create table if not exists employee1_json(empid int,name string,salary string, dept string)
row format 'org.apache.hive.hcatalog.data.JsonSerDe' stored as textfile;
load data local inpath '/home/orienit/employee1.json'  into overwrite table employee1_json;

create table employee1_op as select * from employee1_json where empid>2 and dept='dev';
