Finassn1.loc.root <- file.path("C:/Users/User/Documents/finassn1")
Finassn1.loc.subdirs <- c("data", "code", "bin")
# Note: using file.path you don't have to remember pasting
# the /...
Finassn <- build_path(glue::glue("{Finassn1.loc.root}/{Finassn1.loc.subdirs}"))
library(rmsfuns)
load_pkg("readr")
df1<- read_rds("C:/Users/User/Documents/Finassn1/data/msci_clean.rds")
# Save it to your data directory:
## let's use grepl to identify the pattern you are interested
## in:
DataLoc <- Finassn[grepl("data", Finassn)]
write_rds(data, path = file.path(DataLoc, "msci_cleaned.rds"))
rm(data)
data <- read_rds(file.path(DataLoc, "msci_clean.rds"))
load_pkg("dplyr")
save(df, file = "msci_clean.rds")
load("msci_clean.rds")
