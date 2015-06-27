### Slide 44

table <- m$mapreduce(
  map = "function(){emit({origin: this.origin, dest:this.dest}, 1)}",
  reduce = "function(id, counts){return Array.sum(counts)}"
)
print(table)


### Slide 45
hist <- m$mapreduce(
  map = "function(){emit(Math.floor(this.distance/100)*100, 1)}",
  reduce = "function(id, counts){return Array.sum(counts)}"
)
print(hist)


### Slide 46
m <- mongo("diamonds")
data(diamonds, package = "ggplot2")
m$insert(diamonds)

mapper <- 'function(){
  var x = this.x;
  var dist = means.map(function(mk){return Math.pow(mk-x, 2)});
  var min = Math.min.apply(Math, dist);
  emit(dist.indexOf(min), {count:1, sum:x});
}'

reducer <- 'function(id, val){
  return {
    count : Array.sum(val.map(function(val){return val.count})),
    sum : Array.sum(val.map(function(val){return val.sum}))
  };
}'

# Starting values
means <- c(4,5,6)

# EM
repeat {
  print(means)
  result <-m$mapreduce(mapper, reducer, scope=list(means=means))
  newmeans <- sort(result$value$sum/result$value$count)
  if(identical(means, newmeans))
    break
  means <- newmeans
}

# Compare to R solution:
sort(kmeans(diamonds$x, 3)$centers)
