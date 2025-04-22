library(tidyverse)

# (1) Quant table (.csv)
#     As produced by mzmine
# (2) Metadata (.csv)
#     1st col: file names
setwd("C:/Users/Olivia.Schwartz/OneDrive - University of Denver/Projects/Alzheimers NAU/202504_HILIC_IntStd_Runs/Serum")

metadata <- read.csv("C:/Users/Olivia.Schwartz/OneDrive - University of Denver/Projects/Alzheimers NAU/202504_HILIC_IntStd_Runs/Serum/20250417_Serum_md_16O.csv")
quant_table <- read.csv("C:/Users/Olivia.Schwartz/OneDrive - University of Denver/Projects/Alzheimers NAU/202504_HILIC_IntStd_Runs/Serum/mzmine/20250417_Serum_iimn_gnps_quant.csv", sep = ",")
#canopus <- read.csv("canopus_formula_summary.csv")




colnames(quant_table)<-gsub(".Peak.area","",colnames(quant_table)) #Remove ".Peak.area." 
#colnames(metadata) <- paste(colnames(quant_filtered)[14:ncol(quant_filtered)], " Peak area", sep=" ")

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

write.csv(quant_filtered, file="20250416_Ser_16O_quant.csv")
