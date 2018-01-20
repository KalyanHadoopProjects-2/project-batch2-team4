USE kalyan;

CREATE TABLE IF NOT EXISTS student_parquet
( name string, id int , course string, year int )
ROW FORMAT SERDE 'org.apache.hadoop.hive.ql.io.parquet.serde.ParquetHiveSerDe'
STORED AS 
INPUTFORMAT 'org.apache.hadoop.hive.ql.io.parquet.MapredParquetInputFormat'
OUTPUTFORMAT 'org.apache.hadoop.hive.ql.io.parquet.MapredParquetOutputFormat';

LOAD DATA LOCAL INPATH '/home/orienit/input-files/student.parquet' OVERWRITE INTO TABLE student_parquet;

CREATE TABLE student_parquet_op AS select * from student_parquet where id > 2 and course = 'spark';