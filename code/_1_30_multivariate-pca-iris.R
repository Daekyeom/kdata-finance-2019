#!/c/Apps/R/R-3.5.3/bin/x64/Rscript

### pca - calculated for the first 4 columns of the data set that correspond to biometric measurements ("Sepal.Length" "Sepal.Width"  "Petal.Length" "Petal.Width")

data(iris)

# split data into 2 parts for pca training (75%) and prediction (25%)
set.seed(1)
samp <- sample(nrow(iris), nrow(iris)*0.75)
iris.train <- iris[samp,]
iris.train
iris.valid <- iris[-samp,]
iris.valid
# conduct PCA on training dataset
pca <- prcomp(iris.train[,1:4], retx=TRUE, center=TRUE, scale=TRUE)
print("===result===")
print(pca)
expl.var <- round(pca$sdev^2/sum(pca$sdev^2)*100) # percent explained variance
print(expl.var)
# prediction of PCs for validation dataset
pred <- predict(pca, newdata=iris.valid[,1:4])
print("prediction")
print(pred)
df=cbind(iris.valid,pred)
write.csv(df, file="iris-valid-pca-output.csv")

###Plot result
COLOR <- c(2:4)
PCH <- c(1,16)

pc <- c(1,2) # principal components to plot
op <- par(mar=c(4,4,1,1), ps=10)
plot(pca$x[,pc], col=COLOR[iris.train$Species], cex=PCH[1], 
     xlab=paste0("PC ", pc[1], " (", expl.var[pc[1]], "%)"), 
     ylab=paste0("PC ", pc[2], " (", expl.var[pc[2]], "%)")
)
points(pred[,pc], col=COLOR[iris.valid$Species], pch=PCH[2])
legend("topright", legend=levels(iris$Species), fill = COLOR, border=COLOR)
legend("topleft", legend=c("training data", "validation data"), col=1, pch=PCH)
par(op)

png("pca_pred.png", units="in", width=5, height=4, res=200)
plot(pca$x[,pc], col=COLOR[iris.train$Species], cex=PCH[1], 
 xlab=paste0("PC ", pc[1], " (", expl.var[pc[1]], "%)"), 
 ylab=paste0("PC ", pc[2], " (", expl.var[pc[2]], "%)")
)
points(pred[,pc], col=COLOR[iris.valid$Species], pch=PCH[2])
legend("topright", legend=levels(iris$Species), fill = COLOR, border=COLOR)
legend("topleft", legend=c("training data", "validation data"), col=1, pch=PCH)
par(op)
dev.off()
browseURL("pca_pred.png")

