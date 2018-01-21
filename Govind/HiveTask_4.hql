USE kalyan;

ADD JAR /home/orienit/Jars/hivexmlserde-1.0.5.3.jar;

CREATE TABLE IF NOT EXISTS employee4_xml ( empid int, name string, salary float, dept string, details struct<address:ARRAY<string>,pincode:ARRAY<int>> )
ROW FORMAT SERDE 'com.ibm.spss.hive.serde2.xml.XmlSerDe'
WITH SERDEPROPERTIES (
"column.xpath.empid"="/employee/empid/text()",
"column.xpath.name"="/employee/name/text()",
"column.xpath.salary"="/employee/salary/text()",
"column.xpath.dept"="/employee/dept/text()",
"column.xpath.details"="/employee/details/*"
)
STORED AS
INPUTFORMAT 'com.ibm.spss.hive.serde2.xml.XmlInputFormat'
OUTPUTFORMAT 'org.apache.hadoop.hive.ql.io.IgnoreKeyTextOutputFormat'
TBLPROPERTIES (
"xmlinput.start"="<employee",
"xmlinput.end"="</employee>"
);

LOAD DATA LOCAL INPATH '/home/orienit/input-files/employee4.xml' OVERWRITE INTO TABLE employee4_xml;

CREATE TABLE employee4_op AS select * from employee4_xml where empid > 2 and dept = 'dev';