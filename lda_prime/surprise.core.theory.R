#the core of surprise theory
#define the range of scan 
range <-c(0,30);


#funciton : normal distribution of near one
normal.distribution.near <- function(x){
  y=dnorm(x,mean=5,sd=2);
  return(y);
}

#funciton : normal distribution of medium one
normal.distribution.medium <- function(x){
  y=dnorm(x,mean=15,sd=2);
  return(y);
}


#funciton : normal distribution of far one
normal.distribution.far <- function(x){
  y=dnorm(x,mean=25,sd=2);
  return(y);
}


#function  :  define the likelihood function -> near
#input     :  x, self-variable parameter; avg, mean of normal distribution; sd, standard distance of normal function
likelihood.near <- function(x){
  
 if(x==1){
   y = integrate(normal.distribution.near,lower = Inf,upper = x);
 }else if(x>1 && x<30)
 {
   y = integrate(normal.distribution.near,lower = x-1,upper = x);
 }else if(x==30){
   y = integrate(normal.distribution.near,lower = x-1,upper = Inf);
 }
 return(y$value)
}

#function  :  define the likelihood function -> medium
#input     :  x, self-variable parameter; avg, mean of normal distribution; sd, standard distance of normal function
likelihood.medium <- function(x){
  
  if(x==1){
    y = integrate(normal.distribution.medium,lower = Inf,upper = x);
  }else if(x>1 && x<30)
  {
    y = integrate(normal.distribution.medium,lower = x-1,upper = x);
  }else if(x==30){
    y = integrate(normal.distribution.medium,lower = x-1,upper = Inf);
  }
  return(y$value)
}


#function  :  define the likelihood function -> far
#input     :  x, self-variable parameter; avg, mean of normal distribution; sd, standard distance of normal function
likelihood.far<- function(x){
  
  if(x==1){
    y = integrate(normal.distribution.far,lower = Inf,upper = x);
  }else if(x>1 && x<30)
  {
    y = integrate(normal.distribution.far,lower = x-1,upper = x);
  }else if(x==30){
    y = integrate(normal.distribution.far,lower = x-1,upper = Inf);
  }
  return(y$value)
}



#the surprise calculation
calculateSurprise2 <- function(dtArray){
  
  dtArray= c(5,12,11,21,9,3,2);
  options(digits = 3)
  
  results <- matrix(nrow = 50, ncol = 9)
  colnames(results) <- c("data", "p1", "p2", "p3", "pos1", "pos2", "pos3", "posSum", "surprise")
  
  results[1:length(dtArray),1] <- dtArray
  results[1, 2:4] <- 1/3
  #likelihood1 <-function(x) return(dnorm(x, mean = 5, sd = 2))
  #likelihood2 <-function(x) return(dnorm(x, mean = 15, sd = 2))
  #likelihood3 <-function(x) return(dnorm(x, mean = 25, sd = 2))
 
  
#   likelihood <- function(x, avg, sd){
#     if(x == range[1]){
#       return(dnorm(x, mean = avg, sd = sd))
#     }else if(x == range[2]){
#       return(1- dnorm((x - 1), mean = avg, sd = sd))
#     }else{
#       tmp <- pnorm(d, mean = avg, sd = sd) - pnorm((x-1), mean = avg, sd = sd)
#       return(tmp)
#     }
#     
#   }
  
  
  #p(D) can be neglected here since the chances of distance D are equally possible
  
  for(i in 1:length(dtArray)){
#     results[i, 5] <- (results[i, 2] * likelihood(results[i, 1], 5, 2))/(1/30)
#     results[i, 6] <- (results[i, 3] * likelihood(results[i, 1], 15, 2))/ (1/30)
#     results[i, 7] <- (results[i, 4] * likelihood(results[i, 1], 25, 2))/ (1/30)
    
        
          results[i, 5] <- (results[i, 2] * likelihood.near(results[i, 1]))/(1/30)
        results[i, 6] <- (results[i, 3] * likelihood.medium(results[i, 1]))/ (1/30)
        results[i, 7] <- (results[i, 4] * likelihood.far(results[i, 1]))/ (1/30)
  
    results[i, 8] <- results[i, 5] + results[i, 6] + results[i, 7]
    
    #Computing suprise for each model
    suprise1 <- log(results[i, 5]/results[i, 2], base = 2)
    suprise2 <- log(results[i, 6]/results[i, 3], base = 2)
    suprise3 <- log(results[i, 7]/results[i, 4], base = 2)
    
    results[i, 9] <- results[i, 5] * suprise1 + results[i, 6] * suprise2 + results[i, 7] * suprise3
    
    results[i+1, 2] <- results[i, 5]
    results[i+1, 3] <- results[i, 6]
    results[i+1, 4] <- results[i, 7]
    
  }
  return(results[1:length(dtArray),])
}

