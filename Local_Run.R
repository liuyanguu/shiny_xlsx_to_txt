library("readxl")
library("cld2")

xlsx_file <- list.files(here::here(), pattern = "xlsx", full.names = TRUE)
d1 <- readxl::read_xlsx(xlsx_file, sheet = 1, col_names = FALSE, col_types = "text")

source("R/run.data.R")
d2 <- prepare.data(d1)
invisible(sapply(names(d2), write.to.txt, data = d2))
invisible(sapply(names(d2), write.to.txt, data = d2[1:10,], filename = "Sample"))
