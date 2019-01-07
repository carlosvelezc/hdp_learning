
### **Phoenix**

Phoenix es como Drill, pero sólo para HBase. Es decir, es una interfaz para realizar consultas SQL sobre bases de datos no relacionales.
+ Soporta transacciones (e.g. bloquea cuando alguien está insertando) y OLTP.
+ Es muy rápido, incluso más que HBase en algunos casos.
+ Soporta índices secundarios y funciones definidas por el usuario (UDFs).

> Drill también soporta HBase. Por lo tanto, usar cualquiera de los dos, teniendo en cuenta que Phoenix se dedica sólo a HBase, mientras que Drill también a otros.

> Recuerda: Es muy rápido, pero la base sigue siendo no-relacional. Por lo tanto, si se empiezan a usar cruces pesados, mejor pensar si lo que hace falta es una tabla que en sí misma ya contenga la respuesta a mi pregunta.

*Phoenix* se puede usar mediante:
+ CLI
+ Phoenix API para Java
+ JDBC driver (thick client)
+ Phoenix Query Server (PQS) (thin client)
+ .jar's para MapReduce, Spark, Hive, Pig y Flume.


### **Presto**

Al igual que Drill, se puede conectar a diferentes bases de datos de "big data" al mismo tiempo.

+ Optimizado para consultas OLAP (data warehousing), así que no es tan pensado como Phoenix para muchas consultas rápidas.
+ Fue desarrollado por Facebook, que obviamente maneja altos volúmenes de datos.
+ Expone interfaces para uso con JDBC, CLI o incluso Tableau.

A diferencia de Drill, sí tiene conexión con Cassandra.