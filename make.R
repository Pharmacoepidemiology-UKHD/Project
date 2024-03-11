
# dynamischer Pfad --------------------------------------------------------
  if(!require(tidyverse)) {install.packages("tidyverse"); library(tidyverse, quietly = TRUE)}

  getCurrentFileLocation <-  function()
  {
    this_file <- commandArgs() %>%
      tibble::enframe(name = NULL) %>%
      tidyr::separate(col=value, into=c("key", "value"), sep="=", fill='right') %>%
      dplyr::filter(key == "--file") %>%
      dplyr::pull(value)
    if (length(this_file)==0)
    {
      this_file <- rstudioapi::getSourceEditorContext()$path
    }
    return(dirname(this_file))
  }
  hauptpfad <- paste0(getCurrentFileLocation(), "/")
  setwd(hauptpfad)

# Pakete und Funktionen laden ---------------------------------------------
  if(!require(shiny)) {install.packages("shiny"); library(shiny, quietly = TRUE)}
  if(!require(knitr)) {install.packages("knitr"); library(knitr, quietly = TRUE)}
  if(!require(rmarkdown)) {install.packages("rmarkdown"); library(rmarkdown, quietly = TRUE)}
  
  source(paste0(hauptpfad, "lib/data_helpers.R"))  
  
  # Anzeige von allen Dezimalstellen
    options(scipen=9999)
    
# Daten einlesen ----------------------------------------------------------
  source(paste0(hauptpfad, "src/dataloader.R"))  

# Descriptives ------------------------------------------------------------
  drucken <- TRUE
  source(paste0(hauptpfad, "src/descriptives.R")) 

    
# Non-compartmental analysis ----------------------------------------------
  # software validation  
    source(paste0(hauptpfad, "src/validation.R")) 
  # analysis  
    source(paste0(hauptpfad, "src/noncompart.R")) 

# Plots -------------------------------------------------------------------
  source(paste0(hauptpfad, "src/plots.R")) 

# Shiny -------------------------------------------------------------------
  source(paste0(hauptpfad, "shiny/ui.R")) 
  source(paste0(hauptpfad, "shiny/server.R"))  
  shinyApp(ui, server)
    
# Report ------------------------------------------------------------------
  #if(!require(installr)) { install.packages("installr"); require(installr)} #load / install+load installr
  #install.pandoc()
    render(paste0(hauptpfad, "paper/Report.Rmd"), "html_document")
    #render("test.Rmd", "word_document")


# reproducible example code -----------------------------------------------

  # https://stackoverflow.com/questions/5963269/how-to-make-a-great-r-reproducible-example/16532098
  #library(reprex)
  #reprex(mean(rnorm(10))) 

# documentation -----------------------------------------------------------

  # print requirements    
    sink(paste0(hauptpfad,"requirements.txt"))
    sessionInfo()
    #R.version.string
    sink()
    
  # print readme