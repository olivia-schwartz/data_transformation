

library(tidyverse)
library(dplyr)

# (1) Quant table (.csv)
#     As produced by mzmine
# (2) Metadata (.csv)
#     1st col: file names
setwd("C:/Users/Olivia.Schwartz/OneDrive - University of Denver/Projects/Alzheimers NAU/Fecal_RP_202412")

metadata <- read.csv("processed_norm_intstd/RP_Fec_norm_intstd_md.csv")
quant_table <- read.csv("processed_norm_intstd/Fec_RP_batchc16_18_norm_intstd_trans.csv", sep = ",")
#canopus <- read.csv("canopus_formula_summary.csv")

colnames(quant_table)<-gsub(".Peak.area","",colnames(quant_table)) #Remove ".Peak.area." 
setdiff(metadata$filename, colnames(quant_table))
setdiff(colnames(quant_table), metadata$filename)



#Check for differences
setdiff(metadata$filename, quant_table$X)
setdiff(quant_table$X, metadata$filename)

keep_names <- quant_table$X
metadata <- metadata[metadata[[1]] %in% keep_names, ]

setdiff(metadata$filename, quant_table$X)
setdiff(quant_table$X, metadata$filename)

colnames(quant_table)[1] <- "filename"
test <- full_join(metadata,quant_table, by ="filename")

# write.csv(test, "RP_Fec_norm_intstd_merge_for_batchc.csv")

metadata_16O <- dplyr::filter(metadata, metadata$ATTRIBUTE_Isotope == "16O")
metadata_18O <- dplyr::filter(metadata, metadata$ATTRIBUTE_Isotope == "18O")
metadata_other <- dplyr::filter(metadata, metadata$ATTRIBUTE_Sample_Type != "Fecal")

keep_names16 <- c(metadata_16O$filename)
quant16 <- test[test[[1]] %in% keep_names16, ]
# write.csv(quant16, "RP_Fec_norm_intstd_merge_for_batchc16.csv")

keep_names18 <- c(metadata_18O$filename)
quant18 <- test[test[[1]] %in% keep_names18, ]
# write.csv(quant18, "RP_Fec_norm_intstd_merge_for_batchc18.csv")

keep_names_other <- c(metadata_other$filename)
quant_other <- test[test[[1]] %in% keep_names_other, ]
write.csv(quant_other, "RP_Fec_norm_intstd_merge_nosamples.csv")
