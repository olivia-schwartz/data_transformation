library(tidyverse)

setwd("C:/Users/Olivia.Schwartz/OneDrive - University of Denver/Projects/Alzheimers NAU/202504_HILIC_IntStd_Runs/Fecal")
# sirius <- read.csv ("sirius/canopus_formula_summary_short.csv", header = T, check.names = F, sep = ",")
sirius <- read_tsv("GNPS/HILIC_Fec_16O_GNPSLibrary.tsv")
pvalues <- read.csv("FBMNStats/Kruskal_16O_Wk24_Strain_Treatment_Top.csv")
name <- "Kruskal_16O_Wk24_Strain_Treatment_allsig.csv"

sirius$metabolite <- as.character(sirius$metabolite)
pvalues$metabolite <- as.character(pvalues$metabolite)
df <- full_join(sirius,pvalues, by="metabolite")

write.csv(df, file=paste("GNPS_",name))
