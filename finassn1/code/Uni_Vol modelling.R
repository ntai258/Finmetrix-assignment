## Volatility series modelling

#Firstly for the individual series, a standard univariate GARCH(1,1) modelled to give the H_t (used interchangeably with Sigma for plotting) process to be used in calculating the standardized residual. This are then used in  DCC calculations after.
#dccPre fits the univariate GARCH models to each series of returns
DCCPre <- dccPre(xts_rtn, include.mean = T, p = 0)
names(DCCPre)

Vol_series <- DCCPre$marVol
colnames(Vol_series) <- colnames(xts_rtn)
library(dplyr)
Vol_series <-
  data.frame( cbind( date = index(xts_rtn), Vol_series)) %>% # Add date column which dropped away...
  mutate(date = as.Date(date)) %>%  tbl_df()  # make date column a date column...
TidyVol <- Vol_series %>% gather(Tickers, Sigma, -date)
g2 <-
ggplot(TidyVol) + geom_line(aes(x = date, y = Sigma, colour = Tickers))

print(g2)