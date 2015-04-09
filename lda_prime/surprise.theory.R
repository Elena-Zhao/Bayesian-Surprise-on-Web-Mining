surprise.theory <- function(theta){
 
result <- new.env();
  #result <- null;
  r <- remove.nosensen(theta);
  surprise_array <- get.all.surprise.internal(r);
  result$surprise_array = surprise_array;
  result$order = get.surprise.order(surprise_array);
  result$file_order = get.surprise.file.order(theta,result$order);
  return(result);
}
