# -*- coding: utf-8 -*-
"""
Created on Sun Dec 30 00:47:43 2018

@author: caranvel
"""
#%%

# starbase es el cliente REST para HBase, contiene un wrapper para Python
from starbase import Connection

# Se crea la conexión con el localhost que es el 127.0.0.1
# y el puerto 8000 que es el que habíamos abierto para REST de HBase
c = Connection("127.0.0.1", "8000") 

ratings = c.table('ratings')

if(ratings.exists()):
    print("Dropping existing ratings table\n")
    ratings.drop()

# En la tabla ratings va a crear una famlia de columnas llamada "rating"
ratings.create('rating')

print("Parsing the ml-100k ratings data...\n")
ratingFile = open("D:/1_HDP/data/ml-100k/u.data", "r")

#%%

# El paquete "starbase" tiene una interfaz batch
# La podemos usar para no estar agregando los registros uno a uno
# Sino enviarlas en lote (batch) cuando se le haga el commit
batch = ratings.batch()

for line in ratingFile:
    (userID, movieID, rating, timestamp) = line.split()
    batch.update(userID, {'rating': {movieID: rating}})
    
ratingFile.close()

print("Commiting ratings data to HBase via REST service\n")
batch.commit(finalize=True)

#%%
## Simulación de cliente
print("Get back ratings for some users...\n")
print("Ratings for user ID 1:\n")
print(ratings.fetch("1"))
print("Ratings for user ID 33:\n")
print(ratings.fetch("33"))


ratings.drop()