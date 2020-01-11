users = LOAD '/user/maria_dev/ml-100k/u.user' 
USING PigStorage('|') 
AS (userID:int, age:int, gender:chararray, occupation:chararray, zip:int);


/*
La llave es implícita, por lo que sólo se listan las columnas.
En este caso, habíamos creado una tabla en HBase con la llave userID (queda implícita),
y la familia de columnas "userInfo"
*/
STORE users INTO 'hbase://users' 
USING org.apache.pig.backend.hadoop.hbase.HBaseStorage (
'userinfo:age,userinfo:gender,userinfo:occupation,userinfo:zip');

