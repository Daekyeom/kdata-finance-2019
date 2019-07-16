library(gbm)
library(caret)
library(MASS)
boston = MASS::Boston
str(boston)
summary(boston)

indexes = createDataPartition(boston$medv, p = .90, list = F)
train = boston[indexes, ]
test = boston[-indexes, ]
model_gbm = gbm(train$medv ~.,
                data = train,
                distribution = "gaussian",
                cv.folds = 10,
                shrinkage = .01,
                n.minobsinnode = 10,
                n.trees = 500)

print(model_gbm)

test_x = test[, -14] 
test_y = test[, 14] 

pred_y = predict.gbm(model_gbm, test_x)
x_ax = 1:length(pred_y)
plot(x_ax, test_y, col="blue", pch=20, cex=.9)
lines(x_ax, pred_y, col="red", pch=20, cex=.9)

library(gbm)
library(caret)

boston = MASS::Boston
str(boston)
indexes = createDataPartition(boston$medv, p = .90, list = F)
train = boston[indexes, ]
test = boston[-indexes, ]

model_gbm = gbm(train$medv ~.,
                data = train,
                distribution = "gaussian",
                cv.folds = 10,
                shrinkage = .01,
                n.minobsinnode = 10,
                n.trees = 500)

print(model_gbm)

test_x = test[, -14] 
test_y = test[, 14] 

pred_y = predict.gbm(model_gbm, test_x)
caret::R2(test_y, pred_y)
RMSE(test_y, pred_y)

x_ax = 1:length(pred_y)
plot(x_ax, test_y, col="blue", pch=20, cex=.9)
lines(x_ax, pred_y, col="red", pch=20, cex=.9)

# with caret method 
tc = trainControl(method = "cv", number=10)
model = train(medv ~., data=train, method="gbm", trControl=tc)
print(model)
pred_y = predict(model, test_x)
RMSE(test_y, pred_y)

x_ax = 1:length(pred_y)
plot(x_ax, test_y, col="blue", pch=20, cex=.9)
lines(x_ax, pred_y, col="red", pch=20, cex=.9)
