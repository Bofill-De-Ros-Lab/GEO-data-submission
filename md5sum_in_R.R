setwd("~/Downloads/Your_data_directory/")
library("tools")

fileNames <- Sys.glob("*fastq.gz")

file <- fileNames[1]

new_md5sum <- md5sum(file)
combined <- t(c(file,new_md5sum))
combined <-  as.data.frame(combined)
colnames(combined) <- c("file","md5sum")
combined <- combined[0,]

for(file in fileNames){
  new_md5sum <- md5sum(file)
  combined_test <- t(c(file,new_md5sum))
  combined_test <-  as.data.frame(combined_test)
  colnames(combined_test) <- c("file","md5sum")
  combined <- rbind(combined, combined_test)
  print(file)
  print(new_md5sum)
  print(nrow(combined))
  rm(new_md5sum,file,combined_test)
}


write.table(combined, "md5sum.txt", sep="\t", append = F, row.names = F)
