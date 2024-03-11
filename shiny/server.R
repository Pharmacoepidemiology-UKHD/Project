#Define server for Flip-Flop Kinetics Application
#Load shiny and ggplot2 packages
  list.of.packages <- c("shiny", "ggplot2", "dplyr", "Rmisc")
  new.packages <- list.of.packages[!(list.of.packages %in% installed.packages()[,"Package"])]
  if(length(new.packages)) install.packages(new.packages)
	library(shiny)
	library(ggplot2)
  library(dplyr)
  library(Rmisc)

#Code for functions and variables which are not reactive (not dependent on "input$X")	
#ggplot2 theme	
	#theme_custom <- theme_set(theme_grey(18))

	legend_sub <- function(x) {
	  for (i in 1:length(x)) {
	    if(grepl("prop_", x[i])) {
	      x[i] <- gsub("prop_", "" ,x[i])
	    } 
	    if(grepl("\\.", x[i])) {
	      x[i] <- gsub("\\.", " * " ,x[i])
	    } 
	    if (grepl("_", x[i])) {
	      x[i] <- gsub("_", " " ,x[i])
	    }
	  }
	  return(x)
	}
	

#----------------------------------------------------------------------------------------
#Define user-input dependent functions for output
	server <- shinyServer(function(input, output) {# shinyServer(function(input, output) {

#Generate a plot of the data
#Also uses the inputs to build the plot (ggplot2 package)
	  plotInput = function() {
	   
	    load("shiny/plot_dat.RData") # online dann nur im gleichen Verzeichnis lassen 
	    
	    #Collect input from user-widgets
	    data_subset <- plot_dat %>% filter(between(Dose, input$dose_range[1], input$dose_range[2])) %>%
	      filter(between(Weight, input$weight_range[1], input$weight_range[2]))
	                                                
	    index_sum <- summarySE(data_subset, measurevar = "conc", groupvars = c("Time"), na.rm = TRUE)
	    
	    plotobj <- data_subset %>% ggplot(aes(Time, conc)) + #, colour=factor(ID)
	      geom_line(data=data_subset, mapping=aes(group=ID, color=factor(Dose)), size = 0.66) + #linetype=factor(ID) facet_wrap(ID~., scales="free_y", ncol=4) +
	      geom_errorbar(data=index_sum, mapping=aes(x=Time, ymin=conc-se, ymax=conc+se), width=0.1, size=1, color="black") + # x=Time, ymin=mean-sd, ymax=mean+sd
	      
	      stat_summary(fun=mean,geom="line",lwd=2,aes(group=1)) + 
	      scale_x_continuous("Time [hours]", breaks=0:8, limits = c(0,9), expand=c(0,0)) +
	      scale_y_continuous(name="Concentration [unit]", limits = c(0,15), breaks=seq(0,15, 5), expand=c(0,0))+#"Proportion of events"
	      theme_minimal() +
	      theme(legend.position = "bottom",
	            axis.line = element_line(size = 1, colour = "black", linetype = "solid"),
	            axis.ticks.x = element_line(size = 0.8),
	            axis.ticks.y = element_line(size = 0.8),
	            axis.ticks.length = unit(.1, "cm"),
	            axis.text.x = element_text(colour="black", size=15,angle=0, vjust=0.15, hjust=0.0),
	            axis.text.y = element_text(colour="black", size=14),
	            axis.title.y =  element_text(colour="black", size=18, face="bold"),#
	            axis.title.x =  element_text(colour="black", size=18, face="bold"),#
	            strip.text= element_text(colour="black", size=12),
	            plot.title = element_text(hjust = 0.25, size=18),
	            panel.spacing = unit(2, "lines"),
	            plot.margin = unit(c(20,5,5,5), "pt")) 
	      

	    print(plotobj)
	    
	  }
	  output$foo = downloadHandler(
	    filename = 'test.png',
	    content = function(file) {
	      device <- function(..., width, height) {
	        grDevices::png(..., width = width, height = height,
	                       res = 300, units = "in")
	      }
	      ggsave(file, plot = plotInput(), device = "png")
	    })
	  
	output$plotCT <- renderPlot({
	  
	 
	  load("shiny/plot_dat.RData") # online dann nur im gleichen Verzeichnis lassen 
	  
	  #Collect input from user-widgets
	  
	  
	  data_subset <- plot_dat %>% filter(between(Dose, input$dose_range[1], input$dose_range[2])) %>%
	    filter(between(Weight, input$weight_range[1], input$weight_range[2]))
	  
	  
	  index_sum <- summarySE(data_subset, measurevar = "conc", groupvars = c("Time"), na.rm = TRUE)
	  
	  plotobj <- data_subset %>% ggplot(aes(Time, conc)) + #, colour=factor(ID)
	    geom_line(data=data_subset, mapping=aes(group=ID, color=factor(Dose)), size = 0.66) + #linetype=factor(ID) facet_wrap(ID~., scales="free_y", ncol=4) +
	    geom_errorbar(data=index_sum, mapping=aes(x=Time, ymin=conc-se, ymax=conc+se), width=0.1, size=1, color="black") + # x=Time, ymin=mean-sd, ymax=mean+sd
	    
	    stat_summary(fun=mean,geom="line",lwd=2,aes(group=1)) + 
	    scale_x_continuous("Time [hours]", breaks=0:8, limits = c(0,9), expand=c(0,0)) +
	    scale_y_continuous(name="Concentration [unit]", limits = c(0,15), breaks=seq(0,15, 5), expand=c(0,0))+#"Proportion of events"
	    theme_minimal() +
	    theme(legend.position = "bottom",
	          axis.line = element_line(size = 1, colour = "black", linetype = "solid"),
	          axis.ticks.x = element_line(size = 0.8),
	          axis.ticks.y = element_line(size = 0.8),
	          axis.ticks.length = unit(.1, "cm"),
	          axis.text.x = element_text(colour="black", size=15,angle=0, vjust=0.15, hjust=0.0),
	          axis.text.y = element_text(colour="black", size=14),
	          axis.title.y =  element_text(colour="black", size=18, face="bold"),#
	          axis.title.x =  element_text(colour="black", size=18, face="bold"),#
	          strip.text= element_text(colour="black", size=12),
	          plot.title = element_text(hjust = 0.25, size=18),
	          panel.spacing = unit(2, "lines"),
	          plot.margin = unit(c(20,5,5,5), "pt")) 

		
		print(plotobj)
		#print(cumsum(vec1*dose1))
		#print(cumsum(vec2*dose2))
		#print(cumsum(vec3*dose3))
	})	#Brackets closing "renderPlot"
	
})	#Brackets closing "shinyServer"
