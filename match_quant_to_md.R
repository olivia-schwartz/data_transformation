library(tidyverse)

# (1) Quant table (.csv)
#     As produced by mzmine
# (2) Metadata (.csv)
#     1st col: file names
setwd("C:/Users/Olivia.Schwartz/OneDrive - University of Denver/DU/Aron Lab/Experiments/20250106_NAU_HILIC/mzmine/Hippocampus_Run")

metadata <- read.csv("20250106_NAU_HILIC_Hip_16O_md.csv")
quant_table <- read.csv("2025.01.13_Hip_quant.csv", sep = ",")
colnames(quant_table)<-gsub(".Peak.area","",colnames(quant_table)) #Remove ".Peak.area." 

#Check for differences
setdiff(metadata$filename, colnames(quant_table))
setdiff(colnames(quant_table), metadata$filename)

keep_names <- c(colnames(quant_table[1:13]), metadata$filename)

quant_filtered <- quant_table[, names(quant_table) %in% keep_names]

#QC check
setdiff(metadata$filename, colnames(quant_filtered))
setdiff(colnames(quant_filtered), metadata$filename)

#add back "Peak area "
colnames(quant_filtered)[14:ncol(quant_filtered)] <- paste(colnames(quant_filtered)[14:ncol(quant_filtered)], " Peak area", sep=" ")

write.csv(quant_filtered, file="20250113_Hip_16O_quant.csv")
