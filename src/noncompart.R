if(!require(NonCompart)) {install.packages("NonCompart"); library(NonCompart, quietly = TRUE)}
if(!require(ncar)) {install.packages("ncar"); library(ncar, quietly = TRUE)}
if(!require(dplyr)) {install.packages("dplyr"); library(dplyr, quietly = TRUE)}


# Data preprocessing ------------------------------------------------------
  nca_dat <-  data %>% filter(Time <= 8) %>% rename(conc = Y)
  doses <- unique(as.data.table(data), by=c("ID"))$Dose


# Standardanalyse ---------------------------------------------------------
  
  res <- tblNCA(nca_dat, key = "ID", colTime="Time", colConc = "conc", dose = doses, 
                adm = "Extravascular", 
                dur = 0, doseUnit= "mg", timeUnit = "h", concUnit = "mg/L", down = "Linear")

  if (drucken) print(res[,c("CMAX", "CMAXD", # Cmax (dose normalized)
             "TMAX", "TLAG",
             "LAMZHL", #half-life by lambda z, ln(2)/LAMZ
             "AUCLST", #AUC from 0 to TLST
             #"AUCALL", #AUC using all the given points, including trailing zero concentrations
             #"AUCIFO", #AUC infinity observed
             "AUCIFOD", #AUCIFO / Dose
             #"AUCIFP", #AUC infinity predicted using CLSTP instead of CLST
             #"AUCIFPD", #AUCIFP / Dose
             #"VZO", #volume of distribution determined by LAMZ and AUCIFO, for intravascular administration
             #"VZP", #volume of distribution determined by LAMZ and AUCIFP, for intravascular administration 
             "VZFO", #VZO for extravascular administration, VZO/F, F is bioavailability
             "VZFP", #VZP for extravascular administration, VZP/F, F is bioavailability
             #"CLO", #clearance using AUCIFO, for intravascular administration
             #"CLP", #clearance using AUCIFP, for intravascular administration
             "CLFO", #CLO for extravascular administration, CLO/F, F is bioavailability
             "CLFP" #CLP for extravascular administration, CLP/F, F is bioavailability
)])


  # abspeichern
  save(res, file="results/nca_analysis.RData")
  write.table(res, "results/nca_table.txt", row.names=F, quote=F, sep="\t")
