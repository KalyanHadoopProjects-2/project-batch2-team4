Create database kalyan;
ADD JAR /usr/lib/hive-hcatalog/lib/hive-hcatalog-core.jar;
Create table if not exists employee2_json(empid int,name string,salary string, dept string)
row format 'org.apache.hive.hcatalog.data.JsonSerDe' 
field items terminated by '\t' stored as textfile;
load data local inpath '/home/orienit/employee2.json' into overwrite table employee2_json;

create table employee2_op as select * from employee2_json where empid>2 or dept='dev';
