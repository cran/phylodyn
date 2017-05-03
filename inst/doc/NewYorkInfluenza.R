## ----message=FALSE-------------------------------------------------------
library(phylodyn)

## ------------------------------------------------------------------------
data(NY_flu)

## ------------------------------------------------------------------------
NY_cond = BNPR(data = NY_flu, lengthout = 100)
NY_pref = BNPR_PS(data = NY_flu, lengthout = 100)

## ---- fig.width=8.5, fig.height=3.5--------------------------------------
axlabs = list(x = seq(0, 12*52, by=52) + 10, labs = seq(2005, 1993, by=-1))

par(mfrow=c(1,3), cex=0.9, cex.lab=1.5, cex.main=1.7, oma=c(2.5, 2, 0, 0)+0.1,
    mar=c(2,1.5,2,1), mgp = c(2.5,1,0), xpd=NA,
    fig=c(0, 0.32, 0, 1))
plot_BNPR(NY_cond, main="BNPR", ylim = c(10, 500)/52, yscale = 1/52,
          col = rgb(0.829, 0.680, 0.306), axlabs = axlabs, heatmap_labels_side = "left")

par(fig=c(0.32, 0.64, 0, 1), new=TRUE)
plot_BNPR(NY_pref, main="BNPR-PS", ylim = c(10, 500)/52, yscale = 1/52, ylab = "",
          col = rgb(0.330, 0.484, 0.828), axlabs = axlabs, heatmap_labels = FALSE)

par(mar=c(2,3.5,2,1), fig=c(0.64, 1.0, 0, 1), new=TRUE)
plot_mrw(list(NY_cond, NY_pref), axlabs = axlabs, ylab = "Mean Relative Width",
         cols = c(rgb(0.829, 0.680, 0.306), rgb(0.330, 0.484, 0.828)),
         legends = c("BNPR", "BNPR-PS"), legend_place = "topright", legend_cex = 0.8)

