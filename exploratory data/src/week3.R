# hierarchical clustering 
set.seed(1234)
par(mar=c (0,0,0,0))
x <- rnorm(12, mean=rep(1:3,each=4),sd=0.2)
x
y <- x <- rnorm(12, mean=rep(c(1,2,1),each=4),sd=0.2)
y
plot(x,y,col="blue",pch=19,cex=2)
text(x+0.05,y+0.05,labels=as.character(1:12))
df <- data.frame(x=x,y=y)
distxy <- dist(df)

hClustering <- hclust(distxy)

par(mar=c (2,4,2,2))
plot(hClustering)

set.seed(143)

dm <- as.matrix(df)[sample(1:12),]
heatmap(dm)

# k-means cluster ---------------------------------------------------------


set.seed(1234)
par(mar=c (0,0,0,0))
x <- rnorm(12, mean=rep(1:3,each=4),sd=0.2)
x
y <- rnorm(12, mean=rep(c(1,2,1),each=4),sd=0.2)
y
plot(x,y,col="blue",pch=19,cex=2)

kmeanObj <- kmeans(df, centers = 3)
names(kmeanObj)
par(mar=rep(0.2,4))
plot(x,y, col=kmeanObj$cluster, pch=19,cex=3)

points(kmeanObj$centers, col=1:3,pch=3, cex=3, lwd=3)

# heatmaps 
dm <- as.matrix(df)[sample(1:12),]
kmeanObj2 <- kmeans(dm, centers = 3)
par(mfrow=c(1,2), mar=c(2,4,0.1,0.1))
image(t(dm)[,nrow(df):1],yaxt="n")
image(t(dm)[,order(kmeanObj$cluster)], yaxt="n")


set.seed(12345)
par(mar=rep(0.2,4))
dm <- matrix(rnorm(400), nrow = 40)
image(1:10, 1:40, t(dm)[,nrow(dm):1])
heatmap(dm)


set.seed(678910)
for ( i in 1:40) { 
    # flip a coin 
    coinFlip <- rbinom(1,size=1,prob = 0.5)
    # if coin is heads add a common pattern to that row
    if (coinFlip){
        dm[i,] <- dm[i,]+rep(c(0,3),each=5)
    }

}

image(1:10, 1:40, t(dm)[,nrow(dm):1])
heatmap(dm)

hh <- hclust(dist(dm))
dm_o <- dm[hh$order, ]
par(mfrow = c(1,3))
par(mar=rep(2,4))
image(t(dm_o)[, nrow(dm_o):1])
plot(rowMeans(dm_o), 40:1, xlab="Row Mean", ylab="Row", pch=19)
plot(colMeans(dm_o), xlab="Col", ylab="Col Mean", pch=19)

# svd 

svd1 <- svd (scale(dm_o))
par(mfrow = c(1,3))
image(t(dm_o)[, nrow(dm_o):1])
plot(svd1$u[,1], 40:1, xlab="Row Mean", ylab="First Left sigular vector", pch=19)
plot(svd1$v[,1], xlab="Row Mean", ylab="First Right sigular vector", pch=19)

par(mfrow = c(1,2))
plot(svd1$d, xlab="Col", ylab="Singular value", pch=19)
plot(svd1$d^2/ sum(svd1$d^2), xlab="Col", ylab="Prop. of variance explained", pch=19)
pca1 <- prcomp(dm_o, scale=TRUE)
plot(pca1$rotation[,1], svd1$v[,1],pch=19, xlab="Principle Component 1", ylab="Right Singular Vector 1")
abline(c(0,1))


# missing values 


dm2 <- dm_o
# randomly insert some missing data
dm2[sample(1:100, size= 40,replace =FALSE)] <- NA
svd1 <- svd(dm2)

library(impute)
dm2 <- impute.knn(dm2)$data
svd1 <-svd(scale(dm_o))
svd2 <- svd(scale(dm2))
par(mfrow=c(1,2)); plot(svd1$v[,1], pch=19);plot(svd2$v[,1],pch=19)




# plots and color ---------------------------------------------------------

# grDevices

colors()
pal <- colorRamp(c("red", "blue"))
pal(0)
pal(1)
pal(0.5)
pal (seq(0,1,len=10))


pal <- colorRampPalette(c("red", "yellow"))
pal(2)
pal(10)

# RcolorBrewer package
# - sequential 
# - diverging
# - Qualitative

library(RColorBrewer)
example(RColorBrewer)
cols <- brewer.pal(3,"BuGn")
cols
pal <- colorRampPalette(cols)

image(volcano, col=pal(20))
x <- rnorm(10000)
y <- rnorm(10000)
smoothScatter(x,y)
par(mfrow=c(1,1))
plot(x,y, col=rgb(0,0,0,0.1), pch=19)




