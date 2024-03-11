if(!require(data.table)) {install.packages("data.table"); library(data.table, quietly = TRUE)}
if(!require(dplyr)) {install.packages("dplyr"); library(dplyr, quietly = TRUE)}

# Daten einlesen ----------------------------------------------------------
  conc <- read.table("data/Caffeine_conc.csv", header=TRUE, sep=";")
  covs <- read.table("data/Caffeine_covs.csv", header=TRUE, sep=";")

  # alternativ:
    conc_dt <- fread("data/Caffeine_conc.csv", header=TRUE, sep=";", data.table=TRUE)
    covs_dt <- fread("data/Caffeine_covs.csv", header=TRUE, sep=";", data.table=TRUE)

# Daten umformen (Preprocessing) ------------------------------------------

  # Messwerte reduzieren: ganze Stunden
    conc <- conc[which(conc$Time %in% c(0.5,  1.5, seq(min(conc$Time), max(conc$Time), 1))),]

  # oder mit Pipe-Syntax
    conc <- conc %>% filter(Time %in% c(0.5,  1.5, seq(min(conc$Time), max(conc$Time), 1)))

  # variable umbennen  
    conc <- conc %>% rename(ID = Subject, Y = Conc) 
    # umstaendlich: names(conc)[which(names(conc) == "Subject")] <- "ID"


# Daten verbinden (Merge/Join) --------------------------------------------
  # mit Kovariateninfo vereinigen  
    data <- conc %>% left_join(covs, by="ID")
    # oder 
    # data <- left_join(x=conc, y=covs, by = "ID")
    

  write.table(data, "data/data.csv", row.names=F, quote=F, sep=";")
    
