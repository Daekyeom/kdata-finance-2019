#!/c/Apps/R/R-3.5.3/bin/x64/Rscript
if(FALSE){"
[Title] Univariate Abnormal Detedction - Time Series
[Author] Twitter
[References]
	- https://github.com/twitter/AnomalyDetection
"}
 # install.packages("rlang", repos="http://cran.rstudio.com/", dependencies=TRUE)
df = read.csv("customer-finances.csv",sep=",")
# df$TARGET_YN = as.factor(df$TARGET_YN)
# df$ON_CHANNEL = as.factor(df$ON_CHANNEL)
# df$OFF_CHANNEL = as.factor(df$OFF_CHANNEL)
str(df)

library(AnomalyDetection)
library(ggplot2)
data(raw_data)
str(raw_data)
raw_data$timestamp <- as.POSIXct(raw_data$timestamp)
str(raw_data)
res = AnomalyDetectionTs(raw_data, max_anoms=0.02, direction='both', plot=FALSE)
res$anoms$timestamp <- as.POSIXct(res$anoms$timestamp)
ggplot(raw_data, aes(timestamp, count)) + 
  geom_line(data=raw_data, aes(timestamp, count), color='blue') + 
  geom_point(data=res$anoms, aes(timestamp, anoms), color='red')

res = AnomalyDetectionTs(raw_data, max_anoms=0.02, direction='both', only_last="day", plot=TRUE)
res$anoms$timestamp <- as.POSIXct(res$anoms$timestamp)

ggplot(raw_data, aes(timestamp, count)) + 
  geom_line(data=raw_data, aes(timestamp, count), color='blue') + 
  geom_point(data=res$anoms, aes(timestamp, anoms), color='red')


