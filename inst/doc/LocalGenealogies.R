## ------------------------------------------------------------------------
library("phylodyn")
data("Bottle_20c")

## ------------------------------------------------------------------------
sim<-length(Bottle_20c) 
sim
sim<-50 #For this example, the first 50 genealogies
scaling<-10
tol<-.00001 #tolerance factor to detect difference between branch lengths
D<-read_times(Bottle_20c,sim,scaling)

## ------------------------------------------------------------------------
summary(D[,dim(D)[2]])

## ------------------------------------------------------------------------
window<-max(D)+.0001
grid.size<-100
grid<-seq(0,window,length.out=grid.size)
grid<-c(grid,max(D)+.0002)

## ------------------------------------------------------------------------
info<-find_info2(Bottle_20c,D,sim,tol,scaling)

## ------------------------------------------------------------------------
set.seed(2014)
res_MCMC = smcp_sampling(data = info, nsamp = 50,
                         nburnin = 5,grid)


## ------------------------------------------------------------------------

##Plot results
results<-res_MCMC
plot(results[,1],results[,3],type="l",xlim=c(1,0),ylim=c(-3,3),ylab="log N(t)",xlab="No generations",col="white")
plot_res(results) 

##True trajectory
x<-sort(c(0.299999,0.3,0.49999,0.5,seq(0,4,length.out=100)))
y<-x
y[x<.3]<-log(.5)
y[x>=.3 & x<.5]<-log(.1/2)
y[x>=.5]<-log(.5)
points(x,y,lty=2,type="l",lwd=1.5)


