CREATE TABLE student_avro(id int, course string)
  ROW FORMAT SERDE
  'org.apache.hadoop.hive.serde2.avro.AvroSerDe'
  STORED AS INPUTFORMAT
  'org.apache.hadoop.hive.ql.io.avro.AvroContainerInputFormat'
  OUTPUTFORMAT
  'org.apache.hadoop.hive.ql.io.avro.AvroContainerOutputFormat'

Load data local inpath '/home/orienit/student.avro' into overwrite table student_avro;

create table student_avro_op as select * from student_avro where id>2 and course='spark'