library(ggfortify)
df <- iris[c(1, 2, 3, 4)]
autoplot(prcomp(df))
autoplot(prcomp(df), data = iris, colour = 'Species')
autoplot(prcomp(df), data = iris, colour = 'Species', label = TRUE, label.size = 3)
autoplot(prcomp(df), data = iris, colour = 'Species', shape = FALSE, label.size = 3)
autoplot(prcomp(df), data = iris, colour = 'Species', loadings = TRUE)
autoplot(prcomp(df), data = iris, colour = 'Species',
         loadings = TRUE, loadings.colour = 'blue',
         loadings.label = TRUE, loadings.label.size = 3)
autoplot(prcomp(df), scale = 0)
d.factanal <- factanal(state.x77, factors = 3, scores = 'regression')
autoplot(d.factanal, data = state.x77, colour = 'Income')
autoplot(d.factanal, label = TRUE, label.size = 3,
         loadings = TRUE, loadings.label = TRUE, loadings.label.size  = 3)
set.seed(1)
autoplot(kmeans(USArrests, 3), data = USArrests)
autoplot(kmeans(USArrests, 3), data = USArrests, label = TRUE, label.size = 3)
library(cluster)
autoplot(clara(iris[-5], 3))
autoplot(fanny(iris[-5], 3), frame = TRUE)

autoplot(pam(iris[-5], 3), frame = TRUE, frame.type = 'norm')

