library(tidyverse)

# (1) Quant table (.csv)
#     As produced by mzmine
# (2) Metadata (.csv)
#     1st col: file names
setwd("C:/Users/Olivia.Schwartz/OneDrive - University of Denver/DU/Aron Lab/Experiments/20250106_NAU_HILIC/mzmine")

metadata <- read.csv("20250106_NAU_HILIC_md.csv")
# quant_table <- read.csv("C:/Users/Olivia.Schwartz/OneDrive - University of Denver/DU/Aron Lab/Experiments/20250106_NAU_HILIC/data_cleanup/IMP_clr.csv", header=T, check.names=F)
canopus <- read.csv("canopus_formula_summary.csv")

merge_canopus_quant <- inner_join(quant_table, canopus, by="row.ID")

write.csv(merge_canopus_quant, file="merge_canopus_impclr.csv")
