library(DiffBind)
library(readxl)

samples <- read_excel("BERshWT1_ATAC_samples.xlsx", sheet="Sheet1", col_names=TRUE)

BERshWT1 <- dba(sampleSheet=samples)

BERshWT1 <- dba.count(BERshWT1)

BERshWT1 <- dba.contrast(BERshWT1, categories = DBA_CONDITION, minMembers = 2)
BERshWT1 <- dba.analyze(BERshWT1, method=DBA_ALL_METHODS)
dba.show(BERshWT1, bContrasts = T)

dba.plotBox(BERshWT1)
dba.plotVolcano(BERshWT1) 

hmap <- colorRampPalette(c("red", "blue"))(n=13)
readscores <- dba.plotHeatmap(BERshWT1, contrast=1, correlations=FALSE, sale="row", colScheme=hmap)

BERshWT1_deseq <- dba.report(BERshWT1, method=DBA_DESEQ2, contrast = 1, th=1)
BER_output <- as.data.frame(BERshWT1_deseq)
write.csv(BER_output, file="BERshWT1_Differential_Peak_Binding.csv")

#from diffbind, worked pretty well
dba.plotMA(BERshWT1)


##this needs to be installed for the plot profile
##probably do this before diffbind maybe
BiocManager::install("profileplyr")

##plotprofile


BERshWT1_profiles <- dba.plotProfile(BERshWT1)
dba.plotProfile(BERshWT1_profiles)