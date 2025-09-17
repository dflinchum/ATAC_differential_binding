library(DiffBind)
library(readxl)

setwd("D:/5_R_generated_Data/BER/3. 2022 ATAC/Peak Lists")
BERsamples <- read.csv("BERshWT1_NPpeaks.csv")

BER_DSRCTshWT1 <- dba(sampleSheet=BERsamples)
BER_DSRCTshWT1 <- dba.count(BER_DSRCTshWT1)

BER_DSRCTshWT1 <- dba.contrast(BER_DSRCTshWT1, categories = DBA_CONDITION, minMembers = 2)
BER_DSRCTshWT1 <- dba.analyze(BER_DSRCTshWT1, method=DBA_ALL_METHODS)
dba.show(BER_DSRCTshWT1, bContrasts = T)

dba.plotBox(BER_DSRCTshWT1)
dba.plotVolcano(BER_DSRCTshWT1)  
dba.plotPCA(BER_DSRCTshWT1, DBA_TISSUE, label=DBA_ID)
dba.plotPCA(BER_DSRCTshWT1, contrast=1, DBA_TISSUE, label=DBA_ID)

hmap <- colorRampPalette(c("red", "blue"))(n=13)
BERreadscores <- dba.plotHeatmap(BER_DSRCTshWT1, contrast=1, correlations=FALSE, sale="row", colScheme=hmap)

BER_DSRCTshWT1_deseq <- dba.report(BER_DSRCTshWT1, method=DBA_DESEQ2, contrast = 1, th=1)
BER_DSRCT_output <- as.data.frame(BER_DSRCTshWT1_deseq)
write.csv(BER_DSRCT_output, file="BER_DSRCTshWT1_Differential_Peak_Binding_NP_10.31test.csv")
View(BER_DSRCTshWT1)



