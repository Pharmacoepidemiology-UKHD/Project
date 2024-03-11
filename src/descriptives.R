if(!require(dplyr)) {install.packages("dplyr"); library(dplyr, quietly = TRUE)}

# max Conc nach Dosis & Gewicht
if (drucken) cat("\n Maximum concentration by weight categories: \n", sep="")
if (drucken) print(data %>% group_by(Weight) %>% summarise(max_conc=max(Y)))
if (drucken) cat("\n Maximum concentration at 200 mg dose under 40 kg: \n", sep="")
if (drucken) print(data %>% filter(Dose == 200, Weight<40) %>% summarise(maxi=max(Y)))    
