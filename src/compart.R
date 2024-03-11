
head(nca_dat)

nmlx_dat <-  data %>% filter(Time <= 24) %>% 
  mutate(AMT = case_when(TIME %in% c(0,8,16) ~ as.character(Dose),
                         TIME %ni% c(0,8,16) ~ "."))

# monolix format

#ID	TIME	Y	NAME	II	SS	AMT
#1	0	0.164864222425738	sim_ab an    	12	1	2.5
#1	2	0.220252696923926	sim_ab an    	.	.	.
#1	4	0.228232725218318	sim_ab an    	.	.	.
#1	6	0.217467153032972	sim_ab an    	.	.	.
#1	8	0.200883262735043	sim_ab an    	.	.	.
#1	10	0.183909765542947	sim_ab an    	.	.	.
#1	12	0.168520538279688	sim_ab an    	.	.	.
#1	14	0.155182745426387	sim_ab an    	.	.	.
#1	16	0.143769586069392	sim_ab an    	.	.	.
#1	18	0.133969649251281	sim_ab an    	.	.	.
#1	20	0.125457162838758	sim_ab an    	.	.	.
#1	22	0.117952631706118	sim_ab an    	.	.	.
#1	24	0.111236079048895	sim_ab an    	.	.	.
#2	0	0.240808834507392	sim_ab an    	12	1	2.5