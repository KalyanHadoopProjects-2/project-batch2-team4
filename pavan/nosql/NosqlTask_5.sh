use kalyan;
db.createCollection("employee1_json")
mongoimport --db kalyan --collection employee1_json --drop --file /home/orienit/Desktop/nosql/employee1.json


mongoexport --db kalyan --collection employee1_json  --out /home/orienit/Desktop/employee1_json_op1  //json format

mongoexport --db kalyan --collection employee1_json --type=csv --fields empid,name,salary,dept --out /home/orienit/Desktop/employee1_csv_op1  //csv format

-------

mongoexport --db kalyan --collection employee1_json  --fields name,empid --out /home/orienit/Desktop/employee1_json_op2  //json format

mongoexport --db kalyan --collection employee1_json --type=csv --fields empid,name --out /home/orienit/Desktop/employee1_csv_op1 //csv format

