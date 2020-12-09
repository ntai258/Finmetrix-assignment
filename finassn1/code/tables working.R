library(xtable)
des_names <- c("Brazil", "Canada", "Switzerland", "France", "United Kingdom", "India", "Japan", "South Africa", "Taiwan","Egypt", "Bloomberg US Dollar Spot Index")

des_t <- cbind(colnames(xts_rtn), des_names)
colnames(des_t) <- c("Ticker", "Description")

table <- xtable(des_t, caption = "Returns description Table \\label{tab1}")
print.xtable(table,
             # tabular.environment = "longtable",
             floating = TRUE,
             table.placement = 'H',
             # scalebox = 0.4,
             comment = FALSE,
             caption.placement = 'bottom'
)

pacman::p_load("psych")
rtn_tbl<-rtn
rtn_tbl$Date <- NULL
rtn_tbl$scaledret <- NULL
rtn_tbl$TRI <-NULL
des_table <- psych::describeBy(rtn_tbl, rtn_tbl$Tickers, mat = TRUE)
des_table$item <- NULL
des_table$range <- NULL
des_table$mad <- NULL
des_table$n <- NULL
des_table$Date<-NULL
des_table$vars<-NULL
des_table <- des_table[ -(1:11), ]
table <- xtable(des_table, caption = "Descriptive Statistics Table \\label{tab2}")
print.xtable(table,
             tabular.environment = "longtable",
             floating = TRUE,
             table.placement = 'H',
             scalebox = 0,
             comment = FALSE,
             caption.placement = 'bottom'
)
