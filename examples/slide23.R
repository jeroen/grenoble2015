library(curl)
con <- gzcon(curl("http://jeroenooms.github.io/data/diamonds.json"))
xmeans <- vector()

stream_in(con, function(df){
  # Processes a page of data
  # cat("Got data frame with", nrow(df), "rows\n")
  xmeans <<- c(xmeans, mean(df$x))

}, pagesize = 1000)
