library(DiffBind)
library(readxl)
library(ggplot2)

##reading in this way worked
setwd("D:/5_R_generated_Data/JN/3. 2022 ATAC/Peak Lists")
JNsamples <- read.csv("JNshWT1_NPpeaks.csv")

JN_DSRCTshWT1 <- dba(sampleSheet=JNsamples)
plot(JN_DSRCTshWT1)
JN_DSRCTshWT1 <- dba.count(JN_DSRCTshWT1)

JN_DSRCTshWT1 <- dba.contrast(JN_DSRCTshWT1, categories = DBA_CONDITION, minMembers = 2)
JN_DSRCTshWT1 <- dba.analyze(JN_DSRCTshWT1, method=DBA_ALL_METHODS)
dba.show(JN_DSRCTshWT1, bContrasts = T)

dba.plotBox(JN_DSRCTshWT1)
dba.plotVolcano(JN_DSRCTshWT1)  ###play around with how this looks when we get a chance
dba.plotPCA(JN_DSRCTshWT1, DBA_TISSUE, label=DBA_ID)
dba.plotPCA(JN_DSRCTshWT1, contrast=1, DBA_TISSUE, label=DBA_ID)

 ### dba.plotMA(JN_DSRCTshWT1)

hmap <- colorRampPalette(c("red", "blue"))(n=13)
readscores <- dba.plotHeatmap(JN_DSRCTshWT1, contrast=1, correlations=FALSE, sale="row", colScheme=hmap)

JN_DSRCTshWT1_deseq <- dba.report(JN_DSRCTshWT1, method=DBA_DESEQ2, contrast = 1, th=1)
JN_DSRCT_output <- as.data.frame(JN_DSRCTshWT1_deseq)
write.csv(JN_DSRCT_output, file="JN_DSRCTshWT1_Differential_Peak_Binding_NP.csv")
View(JN_DSRCTshWT1)



TESTERS<-dba.plotVolcano(JN_DSRCTshWT1)  


dba.plotVolcano(JN_DSRCTshWT1, factor = "JN test1")  

sigSites <- dba.plotVolcano(JN_DSRCTshWT1, fold=log2(3))

sigSites <- dba.plotVolcano(JN_DSRCTshWT1, fold=log2(2),bLabels=TRUE)


dba.plotVolcano(JN_DSRCTshWT1 + theme(legend.position="none"))




