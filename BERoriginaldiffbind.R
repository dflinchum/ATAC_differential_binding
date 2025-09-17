library(DiffBind)
library(readxl)

samples <- read_excel("BERminus_ATAC_samples.xlsx", sheet="Sheet1", col_names=TRUE)

BERminus <- dba(sampleSheet=samples)

BERminus <- dba.count(BERminus)

BERminus <- dba.contrast(BERminus, categories = DBA_CONDITION, minMembers = 2)
BERminus <- dba.analyze(BERminus, method=DBA_ALL_METHODS)
dba.show(BERminus, bContrasts = T)

dba.plotBox(BERminus)
dba.plotVolcano(BERminus)  

hmap <- colorRampPalette(c("red", "blue"))(n=13)
readscores <- dba.plotHeatmap(BERminus, contrast=1, correlations=FALSE, sale="row", colScheme=hmap)

BERminus_deseq <- dba.report(BERminus, method=DBA_DESEQ2, contrast = 1, th=1)
BER_minus_output <- as.data.frame(BERminus_deseq)
write.csv(BER_minus_output, file="BERoriginal_Differential_Peak_Binding.csv")

#from diffbind, worked pretty well
dba.plotMA(BERminus)


##this needs to be installed for the plot profile
BiocManager::install("profileplyr")

##plotprofile


BERprofiles <- dba.plotProfile(BERminus)
dba.plotProfile(BERprofiles)
