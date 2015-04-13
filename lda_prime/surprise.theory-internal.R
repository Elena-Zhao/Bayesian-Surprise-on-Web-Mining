
#source(tcp.lda-internal.R);
#source(tcp.lda.R);
#source(surprise.core.theory.R);


#the surprise calculation
#dArray sample
calculate.surprise <- function(pre, nex, dataDis){
  
    n <- length(pre);
    temp <- array(dim=n);  #1st time
    temp2 <- array(dim=n);#2nd time
    surprises <- array(dim=n);
    
    for(i in 1:n){
      
      temp[i]<- (1/n * pre[i])/(dataDis)
      
    #  print(temp[i])
      temp2[i] <- (temp[i] * nex[i])/(dataDis)
    
  #    print(temp2[i])
    
    #Computing suprise for each model
        if(temp2[i]==0 || temp[i]==0){
            surprises[i]=0;
        }else{
            surprises[i] <- log(temp2[i]/temp[i], base = 2)
        }
    }

    surprise <- 0;
    for(j in 1:n)
    {
      surprise <- temp2[i] * surprises[i]+surprise;
    }
    return (surprise)

}

remove.nosensen <- function(theta){
  #n_row <- nrow(theta);
  n_col <- ncol(theta);
  
  result <- (theta+(1/n_col))/2;
  return (result); 
}

# result <- result  from remove.nonsense
get.all.surprise.internal <- function(result){
  n_row <- nrow(result);
  n_col <- ncol(result);
  
  sum_of_col <- array(dim=n_col); #存放所有列的和
  
  for(j in 1:n_col){
    sum_of_col[j] <- sum(result[,j]);   #计算每一列的和
  }
  
  left_row_average <- array(dim=n_col) #剩余行的均值
  current_row <- array(dim=n_col)  #当前处理的行
  
  surprises <- array(dim=n_row); #存放每个网页surprise值
  
  
  for(i in 1:n_row){
    current_row <-result[i,] ;
    
  
   left_row_average <- (sum_of_col -current_row )/(n_row-1);     #当列所有和减去当前行
  
    
    surprises[i] <- calculate.surprise(pre=left_row_average,nex=current_row,dataDis=1/n_row);  #计算surprise
    
  }
  
  return (surprises)
}


#get order of surprise
get.surprise.order <- function(surprise_array){
  n <- length(surprise_array);
  order <- array(dim=n);
  not_in <- array(dim=n,data=1);
 
  
 for(i in 1:n){
   
   for(a in 1:n){
    if(not_in[a]){
     max_value=surprise_array[a];
     max_index=a; 
     break;
    }
   }
   
   for(j in a:n){
    if(not_in[j] && surprise_array[j]>max_value){
      max_value = surprise_array[j];
      max_index=j;
    }  
   }
  
   order[i]=max_index;
   not_in[max_index]=0;
  
 }
 
  
  return (order)
}


#get file order
get.surprise.file.order <- function(theta,order){
  n = length(order);
  file_name <- rownames(theta);
  file_order <- array(dim=n);
  
  for(i in 1:n){
    file_order[i] <- file_name[order[i]];
  }
  
  return (file_order);
}




