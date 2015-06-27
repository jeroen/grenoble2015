### Slide 12: data frames and jsonlite
library(jsonlite)

# Round trip]
json <- toJSON(mtcars)
all.equal(mtcars, fromJSON(json))
View(mtcars)

# Benchmark
data(diamonds, package= "ggplot2")
system.time(json <- toJSON(diamonds))
system.time(out <- fromJSON(json))
View(out)
