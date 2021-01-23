library(rmsfuns)
pacman::p_load("MTS", "robustbase")
pacman::p_load("tidyverse", "devtools", "rugarch","rmgarch", "forecast", "tbl2xts", "lubridate", "PerformanceAnalytics", "Texevier", "ggthemes")

data<- read_rds("C:/Users/User/Documents/finassn1/data/msci_clean.rds")
rtn <- data %>% gather(Tickers, TRI, -Date) %>% group_by(Tickers) %>%
  mutate(dlogret = log(TRI) - log(lag(TRI))) %>% mutate(scaledret = (dlogret -
                                                                       mean(dlogret, na.rm = T))) %>% filter(Date > first(Date)) %>%
  ungroup()
Tidyrtn <- rtn

g <-
ggplot(Tidyrtn) + geom_line(aes(x = Date, y = TRI, colour = Tickers,
                                alpha = 0.5)) + ggtitle("MSCI Returns Series:  EM  & DM Returns") +
  facet_wrap(~Tickers, scales = "free_y") + guides(alpha = FALSE) +
  theme_bw() + scale_color_hue(l = 20) + scale_x_date(labels = scales::date_format("'%y"),
                                                      date_breaks = "2 years") + theme(axis.text = element_text(size = 7))

print(g)