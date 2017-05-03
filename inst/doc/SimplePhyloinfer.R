## ----message=FALSE-------------------------------------------------------
set.seed(8675309)
library(phylodyn)

## ------------------------------------------------------------------------
traj = exp_traj

## ------------------------------------------------------------------------
samp_times = 0
n_sampled  = 100

## ------------------------------------------------------------------------
gene = coalsim(samp_times = samp_times, n_sampled = n_sampled, traj = traj, lower_bound = 1/20)

## ------------------------------------------------------------------------
res_BNPR = BNPR(data = gene, lengthout = 100)

## ------------------------------------------------------------------------
nsamp = 500
nburnin = 100

## ----results='hide'------------------------------------------------------
res_MCMC = mcmc_sampling(data = gene, alg = 'splitHMC', nsamp = nsamp,
                         nburnin = nburnin)

## ----fig.width=5, fig.height=5-------------------------------------------
# Plot the results of BNPR
plot_BNPR(BNPR_out = res_BNPR, traj = exp_traj, col = "blue", traj_col = "black")
title("Exponential growth")
  
# plot the results of splitHMC
lines(res_MCMC$med_fun, pch="", col='red', lwd=1)
lines(res_MCMC$low_fun, pch="", col='red', lwd=1, lty=1)
lines(res_MCMC$hi_fun,  pch="", col='red', lwd=1, lty=1)
legend('topleft',c('Truth','BNPR',"splitHMC"),
       col=c('black','blue','red'),lwd=c(1,2.5,2.5),bty='n', lty=c(2,1,1))

