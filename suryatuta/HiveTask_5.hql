CREATE TABLE student_parquet(
 id int,
 course string) 
 STORED AS parquet;

Load data local inpath '/home/orienit/student.parquet' into overwrite table student_parquet;

create table student_parquet_op as select * from student_parquet where id>2 and course='spark' 