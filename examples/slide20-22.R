### Slide 20: connections and streaming
library(jsonlite)
library(MASS)

# Stream to stdout
stream_out(cats, stdout())



### Slide 21: streaming jsonlines
library(jsonlite)
library(curl)
con <- curl("https://jeroenooms.github.io/data/diamonds.json")
mydata <- stream_in(con, pagesize = 1000)
View(mydata)

# Compressed streams
con <- gzcon(curl("https://jeroenooms.github.io/data/diamonds.json.gz"))
mydata <- stream_in(con, pagesize = 1000)


### Slide 22: stream from/to files
library(nycflights13)
stream_out(flights, file(tmp <- tempfile()))

# stream back to R
flights2 <- stream_in(file(tmp))
all.equal(flights2, as.data.frame(flights))
unlink(tmp)
View(flights2)

