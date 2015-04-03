#Predefined range for input values
pRange <- c(0, 30)
rangeLen<-30

# Return the discrete likelihood value
likelihood <- function(x, avg, sd){
   if(x == pRange[1]){
       return(pnorm(x, mean = avg, sd = sd))
   }else if(x == pRange[2]){
       return(1-pnorm((x - 1), mean = avg, sd = sd))
   }else{
       tmp <- pnorm(x, mean = avg, sd = sd) - pnorm((x-1), mean = avg, sd = sd)
       return(tmp)
   }
}

#Return likelihood distribution for plotting
getLHArray <- function(x, avg, sd){
  lh<-c()
  for(i in x){
    lh<-c(lh, likelihood(i, avg, sd))
  }
  return(lh)
}

   
calculateSurprise <- function(dtArray){
   options(digits = 3)

   results <- matrix(nrow = 150, ncol = 9)
   colnames(results) <- c("data", "prior1", "prior2", "prior3", "posterior1", "posterior2", "posterior3", "surprise", "range")
   
   results[1:length(dtArray),1] <- dtArray
   results[1, 2:4] <- 1/3
   
   #p(D) can be neglected here since the chances of distance D are equally possible
   
   for(i in 1:length(dtArray)){
   		#Compute temperary posterior according to Bayesian theory
       tmp1 <- (results[i, 2] * likelihood(results[i, 1], 5, 3))/(1/rangeLen)
       tmp2 <- (results[i, 3] * likelihood(results[i, 1], 15, 3))/ (1/rangeLen)
       tmp3 <- (results[i, 4] * likelihood(results[i, 1], 25, 3))/ (1/rangeLen)
       updateFactor <- 1/(tmp1 + tmp2 + tmp3)

       #---------------------------------Key Modification--------------------------------#
       #Modify the posterior value to make sure all of them stay in an acceptable range: #
       #too small values will strongly suppress the variability of beliefs so taht they  #
       #always stays in a considerable low level (e.g. e-30), rendering the surprise val #
       #UNCHANGED																		 #
       #---------------------------------------------------------------------------------#
       posterior <- c(tmp1 * updateFactor, tmp2 * updateFactor, tmp3 * updateFactor)
       posterior[which(posterior < 1/rangeLen)] <- 1/rangeLen
       posterior[order(posterior, decreasing = TRUE)[1]] <- 1 - sum(posterior[order(posterior, decreasing = TRUE)[-1]])
       results[i, 5:7] <- posterior

       #Computing suprise for each model
       suprise1 <- log2(results[i, 5]/results[i, 2])
       suprise2 <- log2(results[i, 6]/results[i, 3])
       suprise3 <- log2(results[i, 7]/results[i, 4])

       #The total surprise exprerienced by the observer 
       #taken with respect to the posterior distribution over the model space M. 
       results[i, 8] <- results[i, 5] * suprise1 + results[i, 6] * suprise2 + results[i, 7] * suprise3
       
       #The new beliefs of the observer are hence changed:
       #using the posterior resulting from our above observation as new prior:
       results[i+1, 2] <- results[i, 5]
       results[i+1, 3] <- results[i, 6]
       results[i+1, 4] <- results[i, 7]

       #Designate the model with highest belief as winner
       winner <- order(c(results[i,5], results[i,6], results[i,7]), decreasing = TRUE)[1]
       if(winner ==1){
          results[i, 9] <- 1
       }else if(winner ==2){
          results[i, 9] <- 2
       }else{
          results[i, 9] <- 3
       }
   }

   #Begin plotting
   par(mfrow = c(3, 1))
   x<-pRange[1]:pRange[2]
   plot(x, getLHArray(x, 5, 3), type = 'p', main = "Likelihood Distribution", ylab = 'value', col = 'green')
   lines(x, getLHArray(x, 15, 3), type = 'p', col = 'blue')
   lines(x, getLHArray(x, 25, 3), type = 'p', col = 'orange')

   plot(results[1:length(dtArray),1], type = 'l', main = "TestData", ylab = 'value')
   plot(results[1:length(dtArray),8], type = 'l', main = "Surprise Distribution", ylab = 'surprise')

   return(results[1:length(dtArray),])
}