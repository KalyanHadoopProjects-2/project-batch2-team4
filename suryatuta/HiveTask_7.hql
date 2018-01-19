create table if not exists RiskFactor(YearStart int,YearEnd int,LocationAbbr string,LocationDesc string,Datasource string,Class string,Topic string,Question string,Data_Value_Unit string
,Data_Value_Type double,Data_Value double,
Data_Value_Alt double,Data_Value_Footnote_Symbol double,Data_Value_Footnote double,Low_Confidence_Limit double,High_Confidence_Limit double,Sample_Size double,Total double,Age(years) int
,Education string,Gender string,Income double,
Race/Ethnicity,GeoLocation array<string>,ClassID string,TopicID string,QuestionID string,DataValueTypeID string,LocationID int,StratificationCategory1 string,Stratification1 string
,StratificationCategoryId1 string,StratificationID1 string)
row format delimited by '\n'
collection item terminated by ','
stored as textfile;

Load data local inpath '/home/orienit/Behavioral_Risk_Factor_Surveillance_System.csv' into overwrite table RiskFactor;

Create table if not exists RiskFactorPartition as select * from RiskFactor partitioned by(YearEnd, LocationDesc , GeoLocation) row format delimited by '\n'
collection item terminated by ','
stored as textfile;

create table RiskFactorFilter as select * from RiskFactor where Sample_Size>1000 and Age between(40 and 50);
