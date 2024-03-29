mittelwert <- function(x) mean(x, na.rm=TRUE)

summarise.by.group <- function(response, group, func) {
  response.split <- split(response, group)
  sapply(response.split, func)
}

detachAllPackages <- function(keep = NULL, keep.basic = TRUE, unload = FALSE,
                              force = FALSE) {
  # function for detaching all attached packages (except basic ones)
  basic.packages <- c("package:stats","package:graphics","package:grDevices",
                      "package:utils","package:datasets","package:methods",
                      "package:base")
  package.list <- search()[ifelse(unlist(gregexpr("package:", search())) == 1,
                                  TRUE, FALSE)]
  if (!is.null(keep)){
    package.list <- setdiff(package.list, paste("package", keep, sep = ":"))
  }
  if (keep.basic){
    package.list <- setdiff(package.list, basic.packages)
  }
  if (length(package.list) > 0) {
    for (package in package.list) detach(package, character.only = TRUE, unload = unload)
  }
}