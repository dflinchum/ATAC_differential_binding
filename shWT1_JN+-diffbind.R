library(DiffBind)
library(readxl)

samples <- read_excel("JNshWT1_ATAC_samples.xlsx", sheet="Sheet1", col_names=TRUE)

JNshWT1 <- dba(sampleSheet=samples)

JNshWT1 <- dba.count(JNshWT1)

JNshWT1 <- dba.contrast(JNshWT1, categories = DBA_CONDITION, minMembers = 2)
JNshWT1 <- dba.analyze(JNshWT1, method=DBA_ALL_METHODS)
dba.show(JNshWT1, bContrasts = T)

dba.plotBox(JNshWT1)
dba.plotVolcano(JNshWT1)  

hmap <- colorRampPalette(c("red", "blue"))(n=13)
readscores <- dba.plotHeatmap(JNshWT1, contrast=1, correlations=FALSE, sale="row", colScheme=hmap)

JNshWT1_deseq <- dba.report(JNshWT1, method=DBA_DESEQ2, contrast = 1, th=1)
JN_output <- as.data.frame(JNshWT1_deseq)
write.csv(JN_output, file="JNshWT1_Differential_Peak_Binding.csv")


#from diffbind, worked pretty well
dba.plotMA(JNshWT1)


##this needs to be installed for the plot profile
##probably do this before diffbind maybe
BiocManager::install("profileplyr")

##plotprofile


JNshWT1_profiles <- dba.plotProfile(JNshWT1)
dba.plotProfile(JNshWT1_profiles)