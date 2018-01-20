USE kalyan;

CREATE TABLE IF NOT EXISTS RiskFactor(YearStart int, YearEnd int, LocationAbbr string, LocationDesc string, Datasource string, Class string, Topic string, 
Question string, Data_Value_Unit string, Data_Value_Type double, Data_Value float, Data_Value_Alt float, Data_Value_Footnote_Symbol string, Data_Value_Footnote string,
Low_Confidence_Limit float, High_Confidence_Limit float, Sample_Size float, Total float, Age int, Education string, Gender string, Income double, Race_Ethnicity string,
GeoLocation string, ClassID string, TopicID string, QuestionID string, DataValueTypeID string, LocationID int, StratificationCategory1 string,
Stratification1 string, StratificationCategoryId1 string, StratificationID1 string)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
LINES TERMINATED BY '\n'
STORED AS TEXTFILE
TBLPROPERTIES("skip.header.line.count" = "1");

LOAD DATA LOCAL INPATH '/home/orienit/input-files/Behavioral_Risk_Factor_Surveillance_System.csv' OVERWRITE INTO TABLE RiskFactor;


CREATE TABLE IF NOT EXISTS RiskFactorPartition(YearStart int, LocationAbbr string, Datasource string, Class string, Topic string, 
Question string, Data_Value_Unit string, Data_Value_Type double, Data_Value float, Data_Value_Alt float, Data_Value_Footnote_Symbol string, Data_Value_Footnote string,
Low_Confidence_Limit float, High_Confidence_Limit float, Sample_Size float, Total float, Age int, Education string, Gender string, Income double, Race_Ethnicity string,
ClassID string, TopicID string, QuestionID string, DataValueTypeID string, LocationID int, StratificationCategory1 string,
Stratification1 string, StratificationCategoryId1 string, StratificationID1 string)
PARTITIONED BY (YearEnd int, LocationDesc string, GeoLocation string)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
LINES TERMINATED BY '\n'
STORED AS TEXTFILE;

set hive.exec.dynamic.partition = true;
set hive.exec.dynamic.partition.mode = nonstrict;
set hive.exec.max.dynamic.partitions.pernode = 1000;

INSERT INTO TABLE RiskFactorPartition
PARTITION (YearEnd, LocationDesc, GeoLocation)
select YearStart,LocationAbbr,Datasource,Class,Topic,Question,Data_Value_Unit,Data_Value_Type,Data_Value,Data_Value_Alt,
Data_Value_Footnote_Symbol,Data_Value_Footnote,Low_Confidence_Limit,High_Confidence_Limit ,Sample_Size,Total,Age,Education,Gender,Income,
Race_Ethnicity,ClassID,TopicID,QuestionID,DataValueTypeID,LocationID,StratificationCategory1,Stratification1,StratificationCategoryId1,StratificationID1,
YearEnd,LocationDesc,GeoLocation from RiskFactor;

CREATE TABLE IF NOT EXISTS RiskFactorFilter as select * from RiskFactor where Sample_Size > 1000 and (Age between 40 and 50);


