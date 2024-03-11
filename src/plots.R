if(!require(ggplot2)) {install.packages("ggplot2"); library(ggplot2, quietly = TRUE)}

plot_dat <- nca_dat %>% filter(ID != 1) %>% mutate(ID = as.numeric(as.character(ID)))
save(plot_dat, file="shiny/plot_dat.RData")

# Spaghetti plot ----------------------------------------------------------

p1 <- plot_dat %>% mutate(re_weight=factor(I(floor(Weight/10)*10))) %>% 
  ggplot(aes(Time, conc,group=factor(ID), color=re_weight)) + #, colour=factor(ID)
  geom_line(size = 0.66) + #linetype=factor(ID) facet_wrap(ID~., scales="free_y", ncol=4) +
  #geom_line(data=Fits, aes(time, popPred), colour="red", size = 1.2, alpha=0.5, linetype="dotted") +
  facet_wrap(.~Dose) +
  geom_point(aes(Time, conc), #shape=c(15:19, 0, 1), 
             alpha=0.8, size=2.5)+
  scale_colour_discrete(breaks=seq(20,70,10), labels = c(">= 20 kg", ">= 30 kg", ">= 40 kg",
                                 ">= 50 kg",">= 60 kg",">= 70 kg"), name="Weight class") +
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



tiff(filename =  "results/p1.tiff",
     width = 14, height = 15, units = "cm", compression = "lzw",bg = "white", res = 600)
print(p1)
dev.off()

png(filename =  "results/p1.png",
     width = 14, height = 15, units = "cm", res=600)
print(p1)
dev.off()


# Boxplot -----------------------------------------------------------------


plot_dat2 <- res %>% left_join(covs, by="ID") %>% filter(ID != 1) %>% mutate(ID = as.numeric(as.character(ID)))

p2 <- plot_dat2 %>% mutate(re_weight=factor(I(floor(Weight/10)*10))) %>%
  ggplot(aes(x=factor(Dose), y=AUCLST)) + geom_boxplot(outlier.shape = NA) +
  geom_point(aes(x=factor(Dose), y=AUCLST, color=re_weight), #shape=c(15:19, 0, 1), 
             alpha=0.8, size=2.5, position = position_jitterdodge(dodge.width = 0.25)) +
  scale_colour_discrete(breaks=seq(20,70,10), labels = c(">= 20 kg", ">= 30 kg", ">= 40 kg",
                                                         ">= 50 kg",">= 60 kg",">= 70 kg"), name="Weight class") +
  scale_x_discrete("Dose group [mg]", expand=c(0,0.8)) +
  scale_y_continuous(name="AUC [unit]", limits = c(0,100), breaks=seq(0,100, 10), expand=c(0,0))+#"Proportion of events"
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

tiff(filename =  "results/p2.tiff",
     width = 14, height = 15, units = "cm", compression = "lzw",bg = "white", res = 600)
print(p2)
dev.off()

png(filename =  "results/p2.png",
    width = 14, height = 15, units = "cm", res=600)
print(p2)
dev.off()

# Histogramm --------------------------------------------------------------

p3 <- plot_dat2 %>% mutate(re_weight=factor(I(floor(Weight/10)*10))) %>%
  ggplot(aes(CMAX)) + geom_histogram(aes(fill=re_weight)) + 
  scale_fill_discrete(breaks=seq(20,70,10), labels = c(">= 20 kg", ">= 30 kg", ">= 40 kg",
                                                         ">= 50 kg",">= 60 kg",">= 70 kg"), name="Weight class") +
  scale_x_continuous("Cmax [unit]", expand=c(0,0),limits = c(0,16), breaks=seq(0,15, 5)) +
  scale_y_continuous(name="Frequency", limits = c(0,5), breaks=seq(0,5, 1), expand=c(0,0))+#"Proportion of events"
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

tiff(filename =  "results/p3.tiff",
     width = 14, height = 15, units = "cm", compression = "lzw",bg = "white", res = 600)
print(p3)
dev.off()

png(filename =  "results/p3.png",
    width = 14, height = 15, units = "cm", res=600)
print(p3)
dev.off()