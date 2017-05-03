## ----message=FALSE-------------------------------------------------------
set.seed(8675309)
library(phylodyn)

## ------------------------------------------------------------------------
traj = list(logistic_traj,exp_traj,boombust_traj,bottleneck_traj)
lower_bounds = c(10, 0.01, 0.1, 0.1)

## ------------------------------------------------------------------------
samp_times = c(0, sort(runif(40, 0, 8)))
n_sampled = c(10, rep(1, 40))

## ------------------------------------------------------------------------
gene = list()
for (i in 1:4)
{
  gene[[i]] = coalsim(samp_times = samp_times, n_sampled = n_sampled, traj = traj[[i]], lower_bound = lower_bounds[i])
}

## ------------------------------------------------------------------------
res_BNPR = list()
for (i in 1:4)
{
  res_BNPR[[i]] = BNPR(data = gene[[i]], lengthout = 100, prec_alpha = 0.01, prec_beta = 0.01)
}

## ------------------------------------------------------------------------
nsamp = 500
nburnin = 100
alg = c("HMC", "splitHMC", "MALA", "aMALA", "ESS")

## ----results='hide'------------------------------------------------------
res_MCMC = list()
for (i in 1:4)
{
  res_MCMC[[i]] = list()
  data = list(samp_times=samp_times, n_sampled=n_sampled, coal_times=gene[[i]]$coal_times)
  for (j in 1:5)
  {
    res_MCMC[[i]][[j]] = mcmc_sampling(data = data, alg = alg[j],
                                       nsamp = nsamp, nburnin = nburnin)
  }
}

## ----fig.width=12, fig.height=10, dpi=60---------------------------------
par(mfrow=c(4,5))
traj_title = c("Logistic", "Exponential", "Boombust", "Bottleneck")
color = c("green", "red", "pink", "purple", "cyan")
for (i in 1:4)
{
  for (j in 1:5)
  {
    plot_BNPR(res_BNPR[[i]], traj[[i]])
    title(traj_title[i])
    
    lines(res_MCMC[[i]][[j]]$med_fun, pch="", col=color[j], lwd=2.5)
    lines(res_MCMC[[i]][[j]]$low_fun, pch="", col=color[j], lwd=2, lty=3)
    lines(res_MCMC[[i]][[j]]$up_fun,  pch="", col=color[j], lwd=2, lty=3)
    legend('bottomright',c('Truth','BNPR',alg[j]),col=c('black','blue',color[j]),lwd=c(1,2.5,2.5),bty='n')
  }
}

