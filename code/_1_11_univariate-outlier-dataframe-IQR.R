#!/c/Apps/R/R-3.5.3/bin/x64/Rscript

if(FALSE){"
[Title] Univariate Outlier Detection with Data Frame
[Author] Yibeck Lee(yibeck.lee@gmail.com)
"}

setwd("~/dev/dev-R")
df = read.csv("customer-finances.csv",sep=",")
df$TARGET_YN = as.factor(df$TARGET_YN)
df$ON_CHANNEL = as.factor(df$ON_CHANNEL)
df$OFF_CHANNEL = as.factor(df$OFF_CHANNEL)
str(df)
summary(df)

par(mfrow=c(1,1))
boxplot(df$FUND_BOND)
hist(df$FUND_BOND)

boxplot(FUND_BOND~OFF_CHANNEL, df, horizontal=TRUE)

pdf("otulier-dataframe-iqr.pdf")
nf <- layout(mat = matrix(c(1,2),2,1, byrow=TRUE),  height = c(1,3))
par(mar=c(5.1, 4.1, 1.1, 2.1))
boxplot(df$FUND_BOND, horizontal = TRUE)
hist(df$FUND_BOND)
dev.off()
browseURL("otulier-dataframe-iqr.pdf")

#library(ggplot2)
#ggplot(df, aes(x=FUND_BOND)) +
#  geom_histogram(aes(color=OFF_CHANNEL), alpha=0.5, position="identity")
