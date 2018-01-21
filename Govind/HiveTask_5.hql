USE kalyan;

hdfs dfs -put /home/orienit/input-files/student.parquet /user/orienit/Govind/hive

invalidate metadata;

DROP TABLE IF EXISTS student_parquet;

CREATE EXTERNAL TABLE student_parquet LIKE PARQUET '/user/orienit/Govind/hive/student.parquet'
STORED AS PARQUET
LOCATION '/user/orienit/Govind/hive';

CREATE TABLE student_parquet_op AS select * from student_parquet where id > 2 and course = 'spark';