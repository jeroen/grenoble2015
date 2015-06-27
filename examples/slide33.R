library(mongolite)
library(nycflights13)

# Insert some data
m <- mongo(collection = "nycflights")
m$insert(flights)

# Total number of records
m$count()

# Matches for given query
m$count('{"month":1, "day":1}')


##### Slide 34: retrieving data
jan1 <- m$find('{"month":1,"day":1}')
nrow(jan1)

test <- m$find(limit = 1000)
nrow(test)

# Select fields
test <- m$find(fields = '{"tailnum" : true, "distance" : true}')
names(test)

# Select fields ommiting id
test <- m$find(fields = '{"tailnum" : true, "distance" : true, "_id": false}')
names(test)


##### Slide 35
jan1 <- m$find('{"month":1,"day":1}', sort='{"distance":-1}')
head(jan1)

out  <- m$find('{}', sort='{"distance":-1}')

m$index(add = "distance")
out  <- m$find('{}', sort='{"distance":-1}')


#### Slide 36: adding indices
m$index()
m$index(add = '{"year": true, "month":true, "day":true}')


#### Slide 37: benchmark
system.time(m$count('{"day":31, "month":12}'))

m$index(add="month")
system.time(m$count('{"day":31, "month":12}'))

m$index(add="day")
system.time(m$count('{"day":31, "month":12}'))

m$index(add = '{"day":true, "month":true}')
system.time(m$count('{"day":31, "month":12}'))


#### Slide 38: distinct
m$distinct("carrier")
m$distinct("carrier", query = '{"distance":{"$gt":3000}}')


#### Slide 39: aggregation
m$aggregate('[{"$group":{
  "_id":"$carrier",
  "count": {"$sum":1},
  "average":{"$avg":"$distance"}
}}]')


### Slide 40: streaming
m$find(query = '{}', pagesize = 1000, handler = function(df){
  # Processes a page of data
  cat("Got data frame with", nrow(df), "rows\n")
})


### Slide 41: removing
m$count()
m$remove('{"carrier": "UA"}', multiple = TRUE)
m$count()

m$remove('{"_id":{"$oid":"4d512b45cc9374271b02ec4f"}}')

m$drop()



### Slide 42: import/export
library(curl)
library(mongolite)
m2 <- mongo("diamonds")
m2$import(curl("https://jeroenooms.github.io/data/diamonds.json"))
m2$count()

# export to jsonlines
m2$export(file("~/diamonds.ndjson"))

# Test that it worked
library(jsonlite)
dmd <- stream_in(file("~/diamonds.ndjson"))
