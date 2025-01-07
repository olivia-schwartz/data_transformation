library(tidyverse)
library(dplyr)

# (1) Quant table (.csv)
#     As produced by mzmine
# (2) Metadata (.csv)
#     1st col: file names
setwd("C:/Users/Olivia.Schwartz/OneDrive - University of Denver/Projects/Proteus Proteobactin/mzMINE/pos")

with_blanks <- read.csv("C:/Users/Olivia.Schwartz/OneDrive - University of Denver/DU/Aron Lab/Experiments/20241213_NAU_GABA/20241217_mzmine/20241217_nau_gaba_iimn_gnps_quant.csv")
quant_table <- read.csv("Normalised_Quant_table_pos.csv", sep = ",") #normalized table

colnames(with_blanks)[1] <- "row ID"
colnames(with_blanks)[2] <- "row m/z"
colnames(with_blanks)[3] <- "row retention time"

#separate id, mz, rt
quant_table[c('row ID', 'row m/z', "row retention time")] <- str_split_fixed(quant_table$X, '_', 3)
new_quant <- quant_table[,c((ncol(quant_table)-2):ncol(quant_table),(2:(ncol(quant_table)-3)))]
rm(quant_table)

#remove rows to match both tables
setdiff(with_blanks$`row ID`, new_quant$`row ID`)        
remove_ids <- setdiff(with_blanks$`row ID`, new_quant$`row ID`)    

with_blanks <- with_blanks[ ! with_blanks$`row ID` %in% remove_ids, ]
with_blanks3 <- with_blanks[,c(1:13)]


with_blanks3 <- as.data.frame(with_blanks3)
# with_blanks3 <- with_blanks3 %>% mutate_at(c('row ID', 'row m/z', "row retention time"), as.character())
# with_blanks3 <- with_blanks3 %>% mutate_at(1:3, as.numeric)
# new_quant2 <- new_quant2 %>% mutate_at(1:3, as.numeric)
# new_quant2 <- left_join(with_blanks3,new_quant)


write.csv(new_quant, file="new_quant.csv")
write.csv(with_blanks3, file="originalmzmine.csv")
