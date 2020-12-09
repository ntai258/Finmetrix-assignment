### Estimating DCC model
# Firstly save the standardized residuals (Etas) from the Vol series
StdRes <- DCCPre$sresi
#detach tidyr and dplyr packages to avoid ambiguity between stats::filter and dplyr::filter
detach("package:tidyverse", unload=TRUE)
detach("package:tbl2xts", unload=TRUE)
#run the dccFit to calculate DCC using the starndadised residuals
DCC <- dccFit(StdRes, type="Engle")
#reload packages
pacman::p_load("tidyverse", "tbl2xts", "broom")

##calculating bivariate correlation between pairs

#plot all the bivariate time-varying correlations with BBDXY
Rhot <- DCC$rho.t

#Loop to clean plot by create a renaming function(katzke 2020)
ReturnSeries = xts_rtn
DCC.TV.Cor = Rhot

#To clean the plot 
renamingdcc <- function(ReturnSeries, DCC.TV.Cor) {
  
  ncolrtn <- ncol(ReturnSeries)
  namesrtn <- colnames(ReturnSeries)
  paste(namesrtn, collapse = "_")
  
  nam <- c()
  xx <- mapply(rep, times = ncolrtn:1, x = namesrtn)
  # Now let's be creative in designing a nested for loop to save the names corresponding to the columns of interest.. 
  
  # TIP: draw what you want to achieve on a paper first. Then apply code.
  
  # See if you can do this on your own first.. Then check vs my solution:
  
  nam <- c()
  for (j in 1:(ncolrtn)) {
    for (i in 1:(ncolrtn)) {
      nam[(i + (j-1)*(ncolrtn))] <- paste(xx[[j]][1], xx[[i]][1], sep="_")
    }
  }
  
  colnames(DCC.TV.Cor) <- nam
  
  # So to plot all the time-varying correlations wrt SBK:
  # First append the date column that has (again) been removed...
  DCC.TV.Cor <- 
    data.frame( cbind( date = index(ReturnSeries), DCC.TV.Cor)) %>% # Add date column which dropped away...
    mutate(date = as.Date(date)) %>%  tbl_df() 
  
  DCC.TV.Cor <- DCC.TV.Cor %>% gather(Pairs, Rho, -date)
  
  DCC.TV.Cor
  
}

# Let's see if our function works! Excitement!
Rhot <- 
  renamingdcc(ReturnSeries = xts_rtn, DCC.TV.Cor = Rhot)

head(Rhot %>% arrange(date))

  ## create a plot for all the stocks relative to the other stocks
g1 <- 
    ggplot(Rhot %>% filter(grepl("MXBR_", Pairs ), !grepl("_MXBR", Pairs)) ) + 
    geom_line(aes(x = date, y = Rho, colour = Pairs)) + 
    theme_hc() +
    ggtitle("Dynamic Conditional Correlations: MXBR")
  
print(g1)
  
g2 <- 
    g1 %+% subset(Rhot %>% filter(grepl("BBDXY_", Pairs ), !grepl("_BBDXY", Pairs))) + ggtitle("Dynamic Conditional Correlations: BBDXY")
 
print(g2)
  
  
  
  
  
  
  