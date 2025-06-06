

library(tidyverse)

setwd("C:/Users/Olivia.Schwartz/OneDrive - University of Denver/Projects/Alzheimers NAU/20250527_HILIC_BATCH3/20250527_HILIC_BATCH3_FC")

# File Inputs
# (1) Quant table (.csv)
#     As produced by mzmine
# (2) Metadata (.csv)
#     1st col: file names

quant_table <- read.csv("mzmine/20250530_HILIC_BATCH3_FC_batchcorrect_quant.csv", sep = ",") #mzmine output
metadata <- read.csv("20250527_HILIC_BATCH3_FC_md.csv", header = T, check.names = F, sep = ",")

attribute_1 <- "Sample_Type"
condition_1 <- "Frontal Cortex"
scale_ft <- "FT7817"
scale_factor <- 6/5
output_file <- "fc_scale.csv"

#Merge Data
#Metadata
colnames(metadata)<-gsub("ATTRIBUTE_","",colnames(metadata)) #Remove "ATTRIBUTE_"
colnames(metadata)[1] <- "filename"
#Feature Table
colnames(quant_table)<-gsub(".Peak.area","",colnames(quant_table)) #Remove ".Peak.area." 
colnames(quant_table)[1] <- "ID"
quant_table <- quant_table[-c(4:13)] #Retain only ID, mz, RT
colnames(quant_table)[2] <- "mz"
colnames(quant_table)[3] <- "rt"

#QC-Do file names match?
setdiff(metadata$filename, colnames(quant_table))
setdiff(colnames(quant_table), metadata$filename)
quant_ft <- t(quant_table)
quant_ft <- as.data.frame(quant_ft)
colnames(quant_ft) <- quant_ft[1,]

filename <- row.names(quant_ft)
quant_ft <- cbind(filename, quant_ft)
quant_ft <- quant_ft[-c(1:3), ]   # notice the -
data_merge <- inner_join(metadata, quant_ft)
data_merge <- data_merge %>% 
  as.data.frame() %>% 
  mutate_at(c(ncol(metadata)+1), as.numeric)

startcol <- ncol(metadata)+1
colnames(data_merge)[startcol:ncol(data_merge)] <- paste("FT", colnames(data_merge)[startcol:ncol(data_merge)], sep = "")
data_merge <- as.data.frame(data_merge)

#Filter Data
filter_set <- data_merge %>%
  as.data.frame() %>%
  dplyr::filter(data_merge[[attribute_1]] == condition_1)
filter_set[[scale_ft]] <- filter_set[[scale_ft]]*scale_factor
scaled_quant <- filter_set[, c("filename", paste0(scale_ft))]
#Reformat
scaled_quant <- scaled_quant %>%
  t() %>% as.data.frame()
colnames(scaled_quant) <- scaled_quant[1,]
scaled_quant <- scaled_quant[-1, ]

#Reformat for export
colnames(scaled_quant) <- paste0(colnames(scaled_quant), " Peak area")
rownames(scaled_quant) <- sub("^FT", "", rownames(scaled_quant))

#Export
write.csv(file = paste0(output_file), scaled_quant)

#Recombine
# 
# 
# blank <- read.csv("blank_scale.csv")
# QC <- read.csv("qc_scale.csv")
# GABA_Std <- read.csv("gaba_scale.csv")
# sample <- read.csv("fecal_scale.csv")
# 
# merged_df <- merge(blank, QC, by = "X")
# merged_df <- merge(merged_df, GABA_Std, by = "X")
# merged_df <- merge(merged_df, sample, by = "X")
# 
# write.csv(merged_df, file = "scaled_std16840.csv")
