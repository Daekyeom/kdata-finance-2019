#!/c/Apps/R/R-3.5.3/bin/x64/Rscript
set.seed(1232)
input = data.frame(
  x1 = c(4,4,5,2,3,6,9,7,4,5)
  ,	x2 = c(3,7,5,7,9,5,6,2,2,7)
)
input
# input = matrix(
# 	c(4,4,5,2,3,6,9,7,4,5,3,7,5,7,9,5,6,2,2,7)
# ,		nrow=10
# ,		ncol=2
# )
print(input)
covariance = cov(input)
inverse_covariance = solve(covariance)
inverse_covariance[1:2,1]
x1_diff_from_mean = input[,1] - mean(input[,1])
x2_diff_from_mean = input[,2] - mean(input[,2])
diff_xy = matrix(
  t(c(x1_diff_from_mean,x2_diff_from_mean))
  ,	nrow=10
  ,	ncol=2
)
diff_xy
mahalanobis_distance = c()
for (i in 1:10){
  print(sqrt((t(diff_xy[i,]) %*% inverse_covariance[1:2,])%*%diff_xy[i,])[1])
  mahalanobis_distance[i] = sqrt((t(diff_xy[i,]) %*% inverse_covariance[1:2,])%*%diff_xy[i,])
}
mahalanobis_distance

mean(mahalanobis_distance)*1.5
mahalanobis_diff = mahalanobis_distance - mean(mahalanobis_distance)*1.5
mahalanobis_diff

plot(input)

# names(diff_xy) = c("x1_diff","x2_diff")
diff_xy = data.frame(diff_xy)
names(diff_xy) = c("x1_diff","x2_diff")
diff_xy

df = cbind(input, diff_xy)
df
library(ggplot2)

plot = ggplot(df, aes(x = x1, y = x2)) + 
  geom_point(alpha = .8, color = 'dodgerblue',size = 5) +
  geom_point(data=subset(df, x1_diff >= 4.1 & x2_diff >= 0.7), color = 'red',size = 6) +
  theme(axis.text.x = element_text(size= rel(1.5),angle=90, hjust=1)) +
  ggtitle('Distance Pairs with outliers highlighted in red')
print(plot)
