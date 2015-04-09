source('tcp.lda-internal.R')
source('tcp.lda.R')
result <- tcp.lda(testDir="../../../preprocessing/result/America/",K=10)
source('surprise.theory-internal.R')
source('surprise.theory.R')
surprise_result <- surprise.theory(theta=result$lda$theta)
surprise_result$file_order
