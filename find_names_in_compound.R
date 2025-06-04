library(tidyverse)

setwd("C:/Users/Olivia.Schwartz/OneDrive - University of Denver/Projects/Alzheimers NAU/202504_HILIC_IntStd_Runs/Frontal Cortex")

library_table <- read.csv("GNPS/HILIC_FC_GNPS_Library_Matches.csv")

matches <- library_table[grepl("indole", library_table$Compound_Name, ignore.case = TRUE), ]

write.csv(matches, file = "GNPS/IndoleMatches.csv")
