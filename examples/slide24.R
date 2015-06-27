# Calculate delay for flights over 1000 miles
library(dplyr)
library(curl)
con <- gzcon(curl("http://jeroenooms.github.io/data/nycflights13.json.gz"))
output <- file(tmp <- tempfile(), open = "wb")
stream_in(con, function(df){
  df <- filter(df, distance > 1000)
  df <- mutate(df, delta = dep_delay - arr_delay)
  stream_out(df, output, verbose = FALSE)
})
close(output)
