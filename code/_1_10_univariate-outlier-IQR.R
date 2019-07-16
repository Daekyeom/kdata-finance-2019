#!/c/Apps/R/R-3.5.3/bin/x64/Rscript
if(FALSE){"
[Title] Univariate Outlier Detection using IQR
[Author] Yibeck Lee(yibeck.lee@gmail.com)
"}

feature_1 = rnorm(1000)
hist(feature_1)
boxplot(feature_1)
# pdf("otulier-iqr.pdf")
# boxplot(feature_1)
# dev.off()
# browseURL("otulier-iqr.pdf")

summary(feature_1)
iqr = IQR(feature_1)
q1 = quantile(feature_1,c(0.25))
q3 = quantile(feature_1,c(0.75))
print(cat(q1,q3))
iqr = q3 - q1
upper_threshold = q3 + iqr*1.5
lower_threshold = q1 - iqr*1.5 
cat(sprintf("[iqr] %f\n",iqr))
cat(sprintf("[upper_threshold] %f\n",upper_threshold))
cat(sprintf("[loser_threshold] %f\n",lower_threshold))

feature_1[feature_1>upper_threshold]

feature_1[feature_1<lower_threshold]

pdf("otulier-iqr.pdf")
nf <- layout(mat = matrix(c(1,2),2,1, byrow=TRUE),  height = c(1,3))
par(mar=c(5.1, 4.1, 1.1, 2.1))
boxplot(feature_1, horizontal=TRUE,  outline=FALSE,ylim=c(-4,4))
hist(feature_1,xlim=c(-4,4))
dev.off()
browseURL("otulier-iqr.pdf")

