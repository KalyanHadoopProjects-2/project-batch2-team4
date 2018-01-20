
ADD JAR file:///home/pavan/Desktop/hive-hcatalog-core-2.1.1.jar

create table if not exists employee1_json(empid int,name string,salary string, dept string) 
ROW FORMAT SERDE 'org.apache.hive.hcatalog.data.JsonSerDe' STORED AS TEXTFILE;


load data local inpath 'file:///home/pavan/Desktop/hive/employee1.json' into table employee1_json;

create table employee1_op as select * from employee1_json where empid>2 and dept='dev';
