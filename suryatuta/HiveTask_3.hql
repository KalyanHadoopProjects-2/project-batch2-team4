Create database kalyan;
ADD JAR /usr/lib/hive-hcatalog/lib/hive-hcatalog-core.jar;
Create table if not exists employee3_json(empid int,name string,salary string,dept string,details struct<address:string,pincode:int>)
row format 'org.apache.hive.hcatalog.data.JsonSerDe' 
collection items terminated by ':' stored as textfile;
load data local inpath '/home/orienit/employee3.json' into overwrite table employee3_json;

create table employee3_op as select * from employee3_json where empid>2 and details.address='Hyderabad'