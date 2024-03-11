## ---- Validation.R


# load packages and functions ---------------------------------------------
  if(!require(NonCompart)) { install.packages("NonCompart"); require(NonCompart)}
  if(!require(ncar)) { install.packages("ncar"); require(ncar)}

  RptCfg = read.csv("data/validation/NonCompart-tests-master/RptCfg.csv", as.is=TRUE)
  Equal = function(Wres, Rres, Tol=0.001)
  {
    Wres[,"ID"] = as.character(Wres[,"Subject"])
    ColName0 = colnames(Rres)
    rownames(RptCfg) = RptCfg[,"PPTESTCD"]
    colnames(Rres) = c(ColName0[1], RptCfg[ColName0[-1],"WNL"])
    Inter = intersect(colnames(Wres), colnames(Rres))
    
    IsSame = TRUE
    for (i in 1:nrow(Wres)) {
      for (j in Inter) {
        R = as.numeric(Rres[i,j])
        W = as.numeric(Wres[i,j])
        if (W != 0) {
          if(abs((R - W)/W) > Tol) {
            print(Wres[i,j])
            print(Rres[i,j])
            IsSame = FALSE
          }
        }
      }
    }
    return(IsSame)
  }


# Data management ---------------------------------------------------------

  Theoph[,"Subject"] = as.numeric(as.character(Theoph[,"Subject"]))
  Indometh[,"Subject"] = as.numeric(as.character(Indometh[,"Subject"]))


# Comparison with literature data -----------------------------------------
  # Wres: results from WinNonlin
  # Rres: results from R
  
  Wres = read.csv(paste0("data/validation/NonCompart-tests-master/Final_Parameters_Pivoted_Theoph_Linear.csv"))
  Rres = tblNCA(concData=Theoph, key="Subject", colTime="Time", colConc="conc", dose=320, concUnit="mg/L")
  if (!Equal(Wres, Rres)) stop("Test Failed!")

  Wres = read.csv(paste0("data/validation/NonCompart-tests-master/Final_Parameters_Pivoted_Theoph_Log.csv"))
  Rres = tblNCA(concData=Theoph, key="Subject", colTime="Time", colConc="conc", dose=320, down="Log", concUnit="mg/L")
  if (!Equal(Wres, Rres)) stop("Test Failed!")

  Wres = read.csv(paste0("data/validation/NonCompart-tests-master/Final_Parameters_Pivoted_Indometh_Linear.csv"))
  Rres = tblNCA(concData=Indometh, key="Subject", colTime="time", colConc="conc", dose=25, adm="Bolus", concUnit="mg/L", R2ADJ=0.8)
  if (!Equal(Wres, Rres)) stop("Test Failed!")
  
  Wres = read.csv(paste0("data/validation/NonCompart-tests-master/Final_Parameters_Pivoted_Indometh_Log.csv"))
  Rres = tblNCA(concData=Indometh, key="Subject", colTime="time", colConc="conc", dose=25, adm="Bolus", down="Log", concUnit="mg/L", R2ADJ=0.8)
  if (!Equal(Wres, Rres)) stop("Test Failed!")
  
  Wres = read.csv(paste0("data/validation/NonCompart-tests-master/Final_Parameters_Pivoted_Indometh_Linear_Infusion.csv"))
  Rres = tblNCA(concData=Indometh, key="Subject", colTime="time", colConc="conc", dose=25, adm="Infusion", dur=0.25, concUnit="mg/L", R2ADJ=0.8)
  if (!Equal(Wres, Rres)) stop("Test Failed!")
  
  Wres = read.csv(paste0("data/validation/NonCompart-tests-master/Final_Parameters_Pivoted_Indometh_Log_Infusion.csv"))
  Rres = tblNCA(concData=Indometh, key="Subject", colTime="time", colConc="conc", dose=25, adm="Infusion", dur=0.25, down="Log", concUnit="mg/L", R2ADJ=0.8)
  if (!Equal(Wres, Rres)) stop("Test Failed!")
  
  Wres = read.csv(paste0("data/validation/NonCompart-tests-master/Final_Parameters_Pivoted_Indometh_Linear_Wrong_Extravascular.csv"))
  Rres = tblNCA(concData=Indometh, key="Subject", colTime="time", colConc="conc", dose=25, concUnit="mg/L", R2ADJ=0.8)
  if (!Equal(Wres, Rres)) stop("Test Failed!")
  
  Wres = read.csv(paste0("data/validation/NonCompart-tests-master/Final_Parameters_Pivoted_Indometh_Log_Wrong_Extravascular.csv"))
  Rres = tblNCA(concData=Indometh, key="Subject", colTime="time", colConc="conc", dose=25, down="Log", concUnit="mg/L", R2ADJ=0.8)
  if (!Equal(Wres, Rres)) stop("Test Failed!")
  
  cat("All validation tests successfully passed\n", sep="")
