#Filter out metadata and then filter associated quant file to match the samples in filtered metadata file.
#Output files still need columns 1-13 adjusted after to match format (remove . from columns 1-13, remove first row, replace NA with "")
library(tidyverse)
library(dplyr)

# (1) Quant table (.csv)
#     Format as that produced by mzmine
# (2) Metadata (.csv)
#     1st col: file names


setwd("C:/Users/Olivia.Schwartz/OneDrive - University of Denver/Projects/Alzheimers NAU/Fecal_RP_202412")

quant <-  read.csv("mzmine/mzmine_09062024_iimn_gnps_quant.csv", sep = ",")
metadata <- read.csv("Fec_RP_md_rem.csv")

output_name_quant <- "quantnosample.csv"
output_name_metadata <-"mdnosample.csv"

#Filter metadata
colnames(metadata)<-gsub("ATTRIBUTE_","",colnames(metadata)) #Remove "ATTRIBUTE_"
colnames(metadata)[1] <- "filename"
metadata <- metadata %>%
  dplyr::filter(metadata$Sample_Type != "Fecal")

#Filter quant table
colnames(quant)<-gsub(".Peak.area","",colnames(quant)) #Remove ".Peak.area."  

setdiff(colnames(quant),metadata$filename) #Check differences in file names

remove_ids <- setdiff(colnames(quant),metadata$filename) 
remove_ids <- remove_ids[-(1:13)]
quant_new <- quant[, !(colnames(quant) %in% remove_ids)]

setdiff(colnames(quant_new),metadata$filename) #Check differences again

colnames(quant_new)<-gsub(".mzML",".mzML Peak area",colnames(quant_new)) #Add back " Peak area"

#Export new files
write.csv(quant_new, file = output_name_quant)
write.csv(metadata, file = output_name_metadata)
