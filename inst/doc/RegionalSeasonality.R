## ----message=FALSE-------------------------------------------------------
library(phylodyn)

## ------------------------------------------------------------------------
data(regional_flu)

## ------------------------------------------------------------------------
mains <- list(USACanada = "USA / Canada", Europe = "Europe", NorthChina = "NorthChina",
              JapanKorea = "Japan / Korea", India = "India", SouthChina = "South China",
              SouthAmerica = "South America", SoutheastAsia = "Southeast Asia", Oceania = "Oceania")

axlabs <- list(x = seq(1, 0, by=-1/12),
              labs = c("Sep", "Oct", "Nov", "Dec", "Jan", "Feb", "Mar",
                       "Apr", "May", "Jun", "Jul", "Aug", "Sep"))
start <- 8/12

zero_dates <- list(USACanada = 2012.301, Europe = 2011.044, NorthChina = 2011.285,
                   JapanKorea = 2012.29, India = 2010.814, SouthChina = 2011.282,
                   SouthAmerica = 2011.518, SoutheastAsia = 2011.995, Oceania = 2010.964)
years = list(USACanada = 12, Europe = 11, NorthChina = 10,
             JapanKorea = 12, India = 10, SouthChina = 11,
             SouthAmerica = 11, SoutheastAsia = 11, Oceania = 10)

## ------------------------------------------------------------------------
regions <- list("USACanada")

results <- list()
for (region in regions)
{
  results[[region]] <- list(bnpr    = BNPR(data = regional_flu[[region]], lengthout = 100),
                            bnpr_ps = BNPR_PS(data = regional_flu[[region]], lengthout = 100))
}

## ---- fig.width=8.5, fig.height=4.5*length(regions)----------------------
par(mfrow=c(length(regions), 2), cex=1.0, cex.lab=1.4, cex.main=1.5,
    oma=c(2,3,0,0)+0.1, mar=c(3,2,2,1), xpd=NA)
for (region in regions)
{
  plot_seasonality(BNPR_out = results[[region]]$bnpr, zero_date = zero_dates[[region]],
                   start = start, years = years[[region]], ylim = c(0.5, 15), log_y = TRUE,
                   main=mains[[region]], axlabs = axlabs, xlab="Time", 
                   col_years = rgb(0.943, 0.893, 0.769), col_mean = rgb(0.829, 0.680, 0.306),
                   ylab="Effective Population Size", heatmap_labels = TRUE,
                   heatmap_width = 7, heatmap_labels_side = "left", legend = "BNPR")
  plot_seasonality(BNPR_out = results[[region]]$bnpr_ps, zero_date = zero_dates[[region]],
                   start = start, years = years[[region]], ylim = c(0.5, 15), log_y = TRUE,
                   main=mains[[region]], axlabs = axlabs, xlab="Time",
                   col_years = rgb(0.777, 0.828, 0.943), col_mean = rgb(0.330, 0.484, 0.828),
                   ylab="", heatmap_labels = FALSE, heatmap_width = 7,
                   heatmap_labels_side = "left", legend = "BNPR-PS")
}

