## ----message=FALSE-------------------------------------------------------
set.seed(8675309)
library(phylodyn)

## ------------------------------------------------------------------------
traj = logistic_traj

## ------------------------------------------------------------------------
samp_end = 48
nsamps   = 500

## ------------------------------------------------------------------------
Cprop      = nsamps/integrate(traj_beta, 0, samp_end, traj=traj, beta=1)$value
samp_times = pref_sample(traj, c=Cprop, lim=c(0,samp_end), beta=1)

## ------------------------------------------------------------------------
gene = coalsim(samp_times = samp_times, n_sampled = rep(1, length(samp_times)),
               traj = traj, lower_bound = 10)

## ------------------------------------------------------------------------
res_BNPR    = BNPR(data = gene, lengthout = 100)
res_BNPR_PS = BNPR_PS(data = gene, lengthout = 100)

## ---- fig.width=8.5, fig.height=5----------------------------------------
par(mfrow=c(1,2))
plot_BNPR(res_BNPR, traj = traj, main="BNPR", ylim = c(1, 700))
plot_BNPR(res_BNPR_PS, traj = traj, main="BNPR-PS", ylim = c(1, 700))

