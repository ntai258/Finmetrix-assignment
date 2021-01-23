## MV contitional Heteroskedasticity test
xts_rtn <- rtn %>% tbl_xts(., cols_to_xts = "dlogret", spread_by = "Tickers")
MarchTest(xts_rtn)
