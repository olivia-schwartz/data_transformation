directory <-"C:/Users/Olivia.Schwartz/OneDrive - University of Denver/Projects/Alzheimers NAU/20250527_HILIC_BATCH3/20250527_HILIC_BATCH3_FC/"
quant_table <- read.csv(paste(directory,"mzmine/HILIC_FC_BATCH3_normtostd_quant.csv",sep=""), header=T, check.names=F)

new_ft <- quant_table 
colnames(new_ft) <- gsub(' Peak area','',colnames(quant_table)) #Remove peak area
rownames(new_ft) <- paste(new_ft$'row ID',round(new_ft$'row m/z',digits = 3),round(new_ft$'row retention time',digits = 3), sep = '_')
new_ft <- new_ft[,grep('mzML',colnames(new_ft))]
new_ft <- t(new_ft)

write.csv(new_ft, file=paste(directory,"batchc_test/batchc_test_format_for_batchcorrection.csv",sep=""))
