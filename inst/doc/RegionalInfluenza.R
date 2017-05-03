## ----message=FALSE-------------------------------------------------------
library(phylodyn)

## ------------------------------------------------------------------------
data(regional_flu)

## ------------------------------------------------------------------------
mains <- list(USACanada = "USA / Canada", Europe = "Europe", NorthChina = "NorthChina",
              JapanKorea = "Japan / Korea", India = "India", SouthChina = "South China",
              SouthAmerica = "South America", SoutheastAsia = "Southeast Asia", Oceania = "Oceania")
axlabs <- list(USACanada = list(x = seq(0, 14, by=1), labs = 2012 - seq(0, 14, by=1)),
               Europe = list(x = seq(0, 12, by=1), labs = 2011 - seq(0, 12, by=1)),
               NorthChina = list(x = seq(0, 12, by=1), labs = 2011 - seq(0, 12, by=1)),
               JapanKorea = list(x = seq(0, 13, by=1), labs = 2012 - seq(0, 13, by=1)),
               India = list(x = seq(0, 12, by=1), labs = 2011 - seq(0, 12, by=1)),
               SouthChina = list(x = seq(0, 12, by=1), labs = 2011 - seq(0, 12, by=1)),
               SouthAmerica = list(x = seq(0, 12, by=1), labs = 2012 - seq(0, 12, by=1)),
               SoutheastAsia = list(x = seq(0, 14, by=1), labs = 2012 - seq(0, 14, by=1)),
               Oceania = list(x = seq(0, 12, by=1), labs = 2011 - seq(0, 12, by=1)))

## ------------------------------------------------------------------------
regions <- list("USACanada")

results <- list()
for (region in regions)
{
  results[[region]] <- list(bnpr    = BNPR(data = regional_flu[[region]], lengthout = 100),
                            bnpr_ps = BNPR_PS(data = regional_flu[[region]], lengthout = 100))
}

## ---- fig.width=8.5, fig.height=3.5*length(regions)----------------------
for (region in regions)
{
  par(mfrow=c(1, 3), cex=0.8, cex.lab=1.5, cex.main=1.4,
      oma=c(2.5, 2, 0, 0)+0.1, mar=c(2, 1.5, 2, 1), mgp = c(2.5, 1, 0), xpd=NA,
      fig=c(0, 0.32, 0, 1))
  plot_BNPR(results[[region]]$bnpr, main=paste(mains[[region]], "BNPR"),
            ylim = c(0.1, 30), axlabs = axlabs[[region]], col = rgb(0.829, 0.680, 0.306),
            heatmap_labels_side = "left")
  
  par(fig=c(0.32, 0.64, 0, 1), new=TRUE)
  plot_BNPR(results[[region]]$bnpr_ps, main=paste(mains[[region]], "BNPR-PS"), ylab = "",
            ylim = c(0.1, 30), axlabs = axlabs[[region]], col = rgb(0.330, 0.484, 0.828),
            heatmap_labels = FALSE)
  
  par(mar=c(2, 3.5, 2, 1), fig=c(0.64, 1.0, 0, 1), new=TRUE)
  plot_mrw(BNPR_outs = results[[region]], axlabs = axlabs[[region]], main="",
           cols = c(rgb(0.829, 0.680, 0.306), rgb(0.330, 0.484, 0.828)), ylab = "Mean Relative Width",
           legends = c("BNPR", "BNPR-PS"), legend_place = "topright", legend_cex = 0.8)
}

