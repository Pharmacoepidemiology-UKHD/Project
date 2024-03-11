
#------------------------------------------------------------------------------------
# No need to setwd() bc I am working using a .Rproj 
# the working directory points to the root folder where that .Rproj file is saved
#------------------------------------------------------------------------------------

#------------------------------------------------------------------------------------
# Packages and function
#------------------------------------------------------------------------------------

  if(!require(shiny)) {install.packages("shiny"); library(shiny, quietly = TRUE)}
  if(!require(knitr)) {install.packages("knitr"); library(knitr, quietly = TRUE)}
  #if(!require(rmarkdown)) {install.packages("rmarkdown"); library(rmarkdown, quietly = TRUE)}
  
  source("lib/data_helpers.R")  
  
# Set decimals
    options(scipen=9999)
    
# Read data
  source("src/dataloader.R")  

# Descriptives ------------------------------------------------------------
  drucken <- TRUE
  source("src/descriptives.R")

    
# Non-compartmental analysis ----------------------------------------------
  # software validation  
    source("src/validation.R") 
# analysis  
    source("src/noncompart.R") 

# Plots -------------------------------------------------------------------
  source("src/plots.R") 

# Shiny -------------------------------------------------------------------
  source("shiny/ui.R") 
  source("shiny/server.R")  
  shinyApp(ui, server)
    
# Report ------------------------------------------------------------------
  #if(!require(installr)) { install.packages("installr"); require(installr)} #load / install+load installr
  #install.pandoc()
  rmarkdown::render("paper/Report.Rmd", "html_document")
    #render("test.Rmd", "word_document")


# reproducible example code -----------------------------------------------

  # https://stackoverflow.com/questions/5963269/how-to-make-a-great-r-reproducible-example/16532098
  #library(reprex)
  #reprex(mean(rnorm(10))) 

# documentation -----------------------------------------------------------

  # print requirements    
    sink("requirements.txt")
    sessionInfo()
    #R.version.string
    sink()
    
  # print readme