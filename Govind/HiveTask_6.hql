USE kalyan;

CREATE TABLE IF NOT EXISTS student_avro
( name string, id int , course string, year int )
ROW FORMAT SERDE 'org.apache.hadoop.hive.serde2.avro.AvroSerDe'
STORED AS 
INPUTFORMAT 'org.apache.hadoop.hive.ql.io.avro.AvroContainerInputFormat'
OUTPUTFORMAT 'org.apache.hadoop.hive.ql.io.avro.AvroContainerOutputFormat';

LOAD DATA LOCAL INPATH '/home/orienit/input-files/student.avro' OVERWRITE INTO TABLE student_avro;

CREATE TABLE IF NOT EXISTS student_avro_op as select * from student_avro where id > 2 and course = 'spark';