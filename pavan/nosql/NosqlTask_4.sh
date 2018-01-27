use kalyan;
db.createCollection("employee1_json")
db.createCollection("employee2_json")
db.createCollection("employee3_json")


mongoimport --db kalyan --collection employee1_json --drop --file /home/orienit/Desktop/nosql/employee1.json
mongoimport --db kalyan --collection employee2_json --drop --file /home/orienit/Desktop/nosql/employee2.json
mongoimport --db kalyan --collection employee3_json --drop --file /home/orienit/Desktop/nosql/employee3.json



mongoexport --db kalyan --collection employee1_json --query '{$and:[{"empid":{$gt:2}},{"dept": "dev"}]}' --out /home/orienit/Desktop/employee1_op/mongoop.json
mongoexport --db kalyan --collection employee2_json --query '{$and:[{"empid":{$gt:2}},{"dept": "dev"}]}' --out /home/orienit/Desktop/employee1_op/mongoop2.json
mongoexport --db kalyan --collection employee3_json --query '{$and:[{"empid":{$gt:2}},{"dept": "dev"}]}' --out /home/orienit/Desktop/employee1_op/mongoop3.json
