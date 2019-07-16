library(forecast)
library(TSA)
data(SP)
str(SP)
SP.times <- as.numeric(time(SP))
SP.lm <- lm(SP ~ SP.times)
SP.lm
SP.with.outliers <- SP
SP.with.outliers[113] <- 100
SP.with.outliers[145] <- 200
SP.with.outliers[161] <- 300
str(SP)
#plot(SP.with.outliers,
#     main = "Quarterly S&P Composite Index (with outliers)",
#     xlab = "Quarter", ylab = "Rate S&P")
library(pracma)
SP.hampel <- hampel(SP.with.outliers, 5, 3)
SP.hampel$ind
SP.hampel.outlier.times <- vector()
SP.hampel.outlier.values <- vector()

# Yes, I need to learn how to do functional programming in R. :D
i <- 1
for (ind in SP.hampel$ind) {
  SP.hampel.outlier.times[i] <- SP.times[ind]
  SP.hampel.outlier.values[i] <- SP.with.outliers[ind]
  i <- i + 1
}
SP.hampel.outlier.times
SP.with.outliers
options(repr.plot.width=8, repr.plot.height=4)
plot(SP.with.outliers, col="dodgerblue2")
points(SP.hampel.outlier.times, SP.hampel.outlier.values, pch=4, col="red")
grid()
