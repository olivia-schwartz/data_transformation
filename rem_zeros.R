library(tidyverse)
library(vegan) #rclr transform

setwd("C:/Users/Olivia.Schwartz/OneDrive - University of Denver/Projects/Alzheimers NAU/20250527_HILIC_BATCH3/20250527_HILIC_BATCH3_FC")

#Inputs:
# (1) quant table (.csv)
# (2) metadata table (.csv), "filename"

ft <- read.csv("processed_batchc16_stdnorm/HILIC_FC_batchc16_normtostd_samples_0rem.csv", header = T, check.names = F, sep = ",")
md <- read.csv("20250527_HILIC_BATCH3_FC_16O_wk52_md.csv")

names <- md$filename
names <- c(names, colnames(ft)[])
colnames(ft)<-gsub(".Peak.area","",colnames(ft)) #Remove ".Peak.area." 
ft <- ft[, colnames(ft) %in% names, drop = FALSE]


rem_rows <- numeric(0)
for (r in 1:nrow(ft)){
  
  if (all(ft[r,15:ncol(ft)] == 0)) {
    rem_rows[length(rem_rows)+1] <- r
    
  }

}


test <- ft[-rem_rows, ]


write.csv(test, file="HILIC_FC_batchc16_normtostd_samples2.csv")
