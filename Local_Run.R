library("readxl")
library("cld2")
library("data.table")

xlsx_file <- list.files(here::here("test"), pattern = "xlsx", full.names = TRUE)
file.exists(xlsx_file)
dt1 <- setDT(readxl::read_xlsx(xlsx_file[2], sheet = 1, col_names = FALSE, col_types = "text"))

# setnames(dt1, c("v1", "v2"))
# 
# dt1$n1 <- nchar(dt1$v1)
# dt1$n2 <- nchar(dt1$v2)
# setorder(dt1, -n1)
# dt1 <- dt1[,.(v1, v2)]  
# dt1 <- dt1[!duplicated(dt1)]

source("R/run.data.R")
dt2 <- prepare.data(dt1)
invisible(sapply(names(dt2), write.to.txt, data = dt2))
invisible(sapply(names(dt2), write.to.txt, data = dt2[1:10,], filename = "Sample"))


# 

