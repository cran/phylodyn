## ------------------------------------------------------------------------

library("phylodyn")

constant<-function(x){
  return (rep(1,length(x)))
}

simulation1<-coalsim(0,10,constant)
tree1<-generate_newick(simulation1)
plot(tree1$newick)
tree1$newick

## ------------------------------------------------------------------------

samp_times = c(0, sort(runif(40, 0, 8)))
n_sampled = c(10, rep(1, 40))

simulation2<-coalsim(samp_times = samp_times, n_sampled = n_sampled, traj = constant)
tree2<-generate_newick(simulation2)
plot(tree2$newick,show.tip.label = F)
tree2$newick


## ------------------------------------------------------------------------

bottleneck_traj<-function(t){
  result=rep(0,length(t))
  result[t<=0.5]<-1
  result[t>0.5 & t<1]<-.1
  result[t>=1]<-1
  return(result)
}

simulation3<-coalsim(samp_times = samp_times, n_sampled = n_sampled, traj = bottleneck_traj,method="thin",val_upper=11)
tree3<-generate_newick((simulation3))
plot(tree3$newick,show.tip.label = F)

