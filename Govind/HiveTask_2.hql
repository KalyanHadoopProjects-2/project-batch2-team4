USE kalyan;

ADD JAR /home/orienit/Jars/hivexmlserde-1.0.5.3.jar;

CREATE TABLE IF NOT EXISTS employee2_xml ( empid int, name string, salary float, dept string )
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

LOAD DATA LOCAL INPATH '/home/orienit/input-files/employee2.xml' OVERWRITE INTO TABLE employee2_xml;

CREATE TABLE employee2_op AS select * from employee2_xml where empid > 2 and dept = 'dev';