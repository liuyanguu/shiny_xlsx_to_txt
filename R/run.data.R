prepare.data <- function(d1){
  # are the excel file all in one column
  if (ncol(d1) == 1){
    message("Input has only one column. \n")
    names(d1) <- "X1"
    l1 <- cld2::detect_language(unlist(unname(d1[1,1])))
    l2 <- cld2::detect_language(unlist(unname(d1[2,1])))
    message("Language detection: col 1 is ", l1, " col 2 is ", l2)
    d1$index <- rep(1:2, times = ceiling(nrow(d1)/2))
    d2 <- data.frame(V1 = subset(d1, index==1, select = "X1"),
                     V2 = subset(d1, index==2, select = "X1"))

  } else if (ncol(d1) == 2){ 
    # already in two columns? 
    message("Input has two columns. \n")
    l1 <- cld2::detect_language(unlist(unname(d1[1,1])))
    l1_2 <- cld2::detect_language(unlist(unname(d1[2,1])))
    if(l1!=l1_2) stop("Two columns should be one ZH and one EN \n")
    l2 <- cld2::detect_language(unlist(unname(d1[1,2])))
    message("Language detection: col 1 is ", l1, " col 2 is ", l2)
    d2 <- d1
  } else {
    stop("At most 2 columns, one in ZH and one in EN, or 1 column, ZH and EN one by one.")
  }
  names(d2) = c(l1, l2)
  return(d2)
}

  # create txt files --------------------------------------------------------
write.to.txt <- function(data, x, filename = NULL){
    string0 <- paste(data[[x]], collapse = ";")
    if (is.null(filename)) {
      file_name0 <- paste0("Index_", toupper(x), ".txt")
    } else {
      file_name0 <- paste0(filename, toupper(x), ".txt")
    }
    file.create(here::here(file_name0))
    writeLines(string0, here::here(file_name0), useBytes = TRUE)
  }
  

