library(randomForest)
library(devtools)
#devtools::install_github("MI2DataLab/randomForestExplainer")
library(randomForestExplainer)
library(readxl)
require(ggplot2)
library(data.table)
library(ggrepel)
library(dplyr)
library(magrittr) # needs to be run every time you start R and want to use %>%
library(GGally)
#install.packages("dplyr")
nh3 = read_excel("E:\\OneDrive - HKUST Connect\\Research\\nh3_ml\\Global_EF_2018\\R\\nh3.xlsx",sheet = 1)
#data(Boston, package = "MASS")
#Boston$chas <- as.logical(Boston$chas)
str(nh3)
set.seed(2022)
rf <- randomForest(EF ~ ., data = nh3, localImp = TRUE, ntree=500,mtry=11,nodesize=1,sampsize=2629)


print(rf)
mean(rf$mse)
mean(rf$rsq)


# <- min_depth_distribution(rf)
#save(min_depth_frame, file = "E:\\OneDrive - HKUST Connect\\Research\\nh3_ml\\Global_EF_2018\\R\\rf_min_depth_frame.rda")
load("E:\\OneDrive - HKUST Connect\\Research\\nh3_ml\\Global_EF_2018\\R\\rf_min_depth_frame.rda")
head(min_depth_frame, n = 21)
min_depth_frame[min_depth_frame=="UOA"]='Ftype (U)'
min_depth_frame[min_depth_frame=="manure"]='Ftype (Manure)'
min_depth_frame[min_depth_frame=="others"]='Ftype (Others)'
min_depth_frame[min_depth_frame=="CRF"]='Ftype (EEF)'
min_depth_frame[min_depth_frame=="DPM"]='NP (DPM)'
min_depth_frame[min_depth_frame=="SBC"]='NP (SBC)'
min_depth_frame[min_depth_frame=="Mix"]='NP (Mix)'
min_depth_frame[min_depth_frame=="Rice"]='Ctype (Rice)'
min_depth_frame[min_depth_frame=="Water"]='Water input'


# plot_min_depth_distribution(forest) # gives the same result as below but takes longer
source('E:\\OneDrive - HKUST Connect\\Research\\nh3_ml\\Global_EF_2018\\R\\min_depth_distribution.R')
plot_min_depth <- plot_min_depth_distribution(min_depth_frame,k=15,mean_sample = "all_trees")+
  theme(axis.text.x = element_text(size = 17,color="black"),axis.text.y = element_text(size = 17,color="black")) + #坐标轴字???
  theme(axis.title.x = element_text(size = 18,face = 'bold'),axis.title.y = element_text(size = 18,face = 'bold'),plot.title = element_text(size=18,face = 'bold') )+ #3个title设置
  theme(legend.text=element_text(size=17)) + theme(legend.title = element_text(size = 18,face = 'bold'))+#图例设置
  theme(panel.border = element_rect(fill=NA,color="black", size=3, linetype="solid"))+#边框粗细
  theme(axis.ticks.x=element_line(color="black",size=1,lineend = 1),axis.ticks.y=element_line(color="black",size=1,lineend = 1))#刻度线粗细
plot_min_depth
ggsave('E:\\OneDrive - HKUST Connect\\Research\\nh3_ml\\Global_EF_2018\\R\\plot_min_depth.png',plot_min_depth,dpi = 500, width = 8, height = 8)

#importance_frame <- measure_importance(rf)
#save(importance_frame, file = "E:\\OneDrive - HKUST Connect\\Research\\nh3_ml\\Global_EF_2018\\R\\rf_importance_frame.rda")
load("E:\\OneDrive - HKUST Connect\\Research\\nh3_ml\\Global_EF_2018\\R\\rf_importance_frame.rda")
importance_frame

# plot_multi_way_importance(forest, size_measure = "no_of_nodes") # gives the same result as below but takes longer
plot_multi_way_importance(importance_frame, size_measure = "no_of_nodes")+
  theme(axis.text.x = element_text(size = 14,color="black"),axis.text.y = element_text(size = 14,color="black")) + #坐标轴字???
  theme(axis.title.x = element_text(size = 15,face = 'bold'),axis.title.y = element_text(size = 15,face = 'bold'),plot.title = element_text(size=15,face = 'bold') )+ #3个title设置
  theme(legend.text=element_text(size=14)) + theme(legend.title = element_text(size = 15,face = 'bold')) #图例设置

#importance_frame <- measure_importance(rf)
#save(importance_frame, file = "E:\\OneDrive - HKUST Connect\\Research\\nh3_ml\\Global_EF_2018\\R\\rf_importance_frame.rda")
load("E:\\OneDrive - HKUST Connect\\Research\\nh3_ml\\Global_EF_2018\\R\\rf_importance_frame.rda")
importance_frame$variable <- as.character(importance_frame$variable)
importance_frame[importance_frame=="UOA"]='Ftype (U)'
importance_frame[importance_frame=="manure"]='Ftype (Manure)'
importance_frame[importance_frame=="others"]='Ftype (Others)'
importance_frame[importance_frame=="CRF"]='Ftype (EEF)'
importance_frame[importance_frame=="DPM"]='NP (DPM)'
importance_frame[importance_frame=="SBC"]='NP (SBC)'
importance_frame[importance_frame=="Mix"]='NP (Mix)'
importance_frame[importance_frame=="Rice"]='Ctype (Rice)'
importance_frame[importance_frame=="Water"]='Water input'
source('E:\\OneDrive - HKUST Connect\\Research\\nh3_ml\\Global_EF_2018\\R\\measure_importance.R')
sig <- plot_multi_way_importance(importance_frame, x_measure = "mse_increase", y_measure = "node_purity_increase", size_measure = "p_value", no_of_labels = 10)+
  theme(axis.text.x = element_text(size = 17,color="black"),axis.text.y = element_text(size = 17,color="black")) + #坐标轴字???
  theme(axis.title.x = element_text(size = 18,face = 'bold'),axis.title.y = element_text(size = 18,face = 'bold'),plot.title = element_text(size=18,face = 'bold') )+ #3个title设置
  theme(legend.text=element_text(size=17)) + theme(legend.title = element_text(size = 18,face = 'bold')) +
  theme(legend.position = c(0.002, 0.996),legend.background = element_blank(),legend.key = element_blank(),
        legend.box.background = element_rect(fill=NA, color = "black",linetype = 1,size=1))+ theme(legend.justification = c("left", "top"))+ #图例设置
  theme(panel.border = element_rect(color="black", size=3, linetype="solid"))+#边框粗细
  theme(axis.ticks.x=element_line(color="black",size=1,lineend = 1),axis.ticks.y=element_line(color="black",size=1,lineend = 1))+#刻度线粗细 
  xlab("MSE increase")+ylab("Node purity increase")
  #geom_point(aes_string(color = 'p_value'), size = 10)
sig
ggsave('E:\\OneDrive - HKUST Connect\\Research\\nh3_ml\\Global_EF_2018\\R\\sig.png',sig,dpi = 500, width = 6.5, height = 6)


importance <- plot_multi_way_importance(importance_frame, x_measure = "mse_increase", y_measure = "node_purity_increase", size_measure = "mean_min_depth", no_of_labels = 15)+
  theme(axis.text.x = element_text(size = 14,color="black"),axis.text.y = element_text(size = 14,color="black")) + #坐标轴字???
  theme(axis.title.x = element_text(size = 15,face = 'bold'),axis.title.y = element_text(size = 15,face = 'bold'),plot.title = element_text(size=15,face = 'bold') )+ #3个title设置
  theme(legend.text=element_text(size=14)) + theme(legend.title = element_text(size = 15,face = 'bold'))+ #图例设置
  theme(panel.border = element_rect(fill=NA,color="black", size=3, linetype="solid"))+#边框粗细
  theme(axis.ticks.x=element_line(color="black",size=1,lineend = 1),axis.ticks.y=element_line(color="black",size=1,lineend = 1))#刻度线粗细
importance
ggsave('E:\\OneDrive - HKUST Connect\\Research\\nh3_ml\\Global_EF_2018\\R\\importance.png',importance,dpi = 1000, width = 8, height = 6)


#plot_importance_ggpairs(forest) # gives the same result as below but takes longer
pair_imp <- plot_importance_ggpairs(importance_frame,measures = c("mean_min_depth", "no_of_nodes", "times_a_root", "node_purity_increase", "mse_increase"))+
  theme(axis.text.x = element_text(size = 8,color="black"),axis.text.y = element_text(size = 8,color="black")) + #坐标轴字???
  theme(axis.title.x = element_text(size = 15,face = 'bold'),axis.title.y = element_text(size = 15,face = 'bold'),plot.title = element_text(size=15,face = 'bold') )+ #3个title设置
  theme(legend.text=element_text(size=14)) + theme(legend.title = element_text(size = 15,face = 'bold')) #图例设置
levels(pair_imp$data)[levels(pair_imp$data) == "mean_min_depth"] = "M"
pair_imp
ggsave('E:\\OneDrive - HKUST Connect\\Research\\nh3_ml\\Global_EF_2018\\R\\pair_imp.png',pair_imp,dpi = 1000, width = 8, height = 6)




# plot_importance_rankings(forest) # gives the same result as below but takes longer
source('E:\\OneDrive - HKUST Connect\\Research\\nh3_ml\\Global_EF_2018\\R\\measure_importance.R')
pair_ranking <- plot_importance_rankings(importance_frame,measures = c("mean_min_depth", "no_of_nodes", "times_a_root", "node_purity_increase", "mse_increase"))+
  theme(axis.text.x = element_text(size = 8,color="black"),axis.text.y = element_text(size = 8,color="black")) + #坐标轴字???
  theme(axis.title.x = element_text(size = 15,face = 'bold'),axis.title.y = element_text(size = 15,face = 'bold'),plot.title = element_text(size=15,face = 'bold') )+ #3个title设置
  theme(legend.text=element_text(size=14)) + theme(legend.title = element_text(size = 15,face = 'bold')) #图例设置
pair_ranking
pair_ranking[3,1] 
ggsave('E:\\OneDrive - HKUST Connect\\Research\\nh3_ml\\Global_EF_2018\\R\\pair_ranking.png',pair_ranking,dpi = 1000, width = 8, height = 6)


# (vars <- important_variables(forest, k = 5, measures = c("mean_min_depth", "no_of_trees"))) # gives the same result as below but takes longer
(vars <- important_variables(importance_frame, k = 10, measures = c("mean_min_depth", "mse_increase", "node_purity_increase")))

#interactions_frame <- min_depth_interactions(rf, vars)
#save(interactions_frame, file = "E:\\OneDrive - HKUST Connect\\Research\\nh3_ml\\Global_EF_2018\\R\\rf_interactions_frame.rda")
load("E:\\OneDrive - HKUST Connect\\Research\\nh3_ml\\Global_EF_2018\\R\\rf_interactions_frame.rda")
interactions_frame[interactions_frame=="UOA"]='U'
interactions_frame[interactions_frame=="manure"]='Manure'
interactions_frame[interactions_frame=="others"]='Others'
interactions_frame[interactions_frame=="Tem:UOA"]='Tem:U'
interactions_frame[interactions_frame=="Tem:CRF"]='Tem:EEF'
interactions_frame[interactions_frame=="Tem:others"]='Tem:Others'
interactions_frame[interactions_frame=="Tem:Water"]='Tem:Water input'
interactions_frame[interactions_frame=="DPM:Water"]='DPM:Water input'
interactions_frame[interactions_frame=="CEC:Water"]='CEC:Water input'
interactions_frame[interactions_frame=="Clay:Water"]='Clay:Water input'
interactions_frame[interactions_frame=="BD:Water"]='BD:Water input'
source('E:\\OneDrive - HKUST Connect\\Research\\nh3_ml\\Global_EF_2018\\R\\min_depth_interactions.R')
names(interactions_frame)[4] <- "Occurrences"
head(interactions_frame[order(interactions_frame$Occurrences, decreasing = TRUE), ])

# plot_min_depth_interactions(forest) # calculates the interactions_frame for default settings so may give different results than the function below depending on our settings and takes more time
interactions <- plot_min_depth_interactions(interactions_frame,k=30)+scale_fill_gradient(low="#66CC00",high="#FF6633", space ="Lab" )+
  theme(axis.text.x = element_text(size = 10,color="black"),axis.text.y = element_text(size = 12,color="black")) + #坐标轴字???
  theme(axis.title.x = element_text(size = 15,face = 'bold'),axis.title.y = element_text(size = 15,face = 'bold'),plot.title = element_text(size=15,face = 'bold') )+ #3个title设置
  theme(legend.text=element_text(size=14)) + theme(legend.title = element_text(size = 15,face = 'bold'))  + ylab("Mean minimal depth")+ xlab("Interactions")+
  theme(panel.border = element_rect(fill=NA,color="black", size=2, linetype="solid"))+#边框粗细
  theme(axis.ticks.x=element_line(color="black",size=1,lineend = 1),axis.ticks.y=element_line(color="black",size=1,lineend = 1)) + 
  theme(panel.grid.major=element_blank(),panel.grid.minor=element_blank())#刻度线粗细

interactions
ggsave('E:\\OneDrive - HKUST Connect\\Research\\nh3_ml\\Global_EF_2018\\R\\interactions.png',interactions,dpi = 1000, width = 10, height = 6)

source('E:\\OneDrive - HKUST Connect\\Research\\nh3_ml\\Global_EF_2018\\R\\explain_forest.R')
source('E:\\OneDrive - HKUST Connect\\Research\\nh3_ml\\Global_EF_2018\\R\\measure_importance.R')
source('E:\\OneDrive - HKUST Connect\\Research\\nh3_ml\\Global_EF_2018\\R\\min_depth_distribution.R')
source('E:\\OneDrive - HKUST Connect\\Research\\nh3_ml\\Global_EF_2018\\R\\min_depth_interactions.R')
install.packages("GGally")
x = c(4, 1, 4, NA, 1, NA, 4)
# NAs are considered identical (unlike base R)
# default is average
frankv(x) # na.last=TRUE

#plot_predict_interaction(rf, nh3, "DPM", "Nrate")
#plot_predict_interaction(rf, nh3, "BD", "Nrate")
#plot_predict_interaction(rf, nh3, "BD", "Water")
#plot_predict_interaction(rf, nh3, "Tem", "Nrate")
#plot_predict_interaction(rf, nh3, "BD", "Tem")
#plot_predict_interaction(rf, nh3, "Tem", "Water",grid = 100)
#plot_predict_interaction(rf, nh3, "DPM", "Nrate",grid = 20)
#plot_predict_interaction(rf, nh3, "DPM", "Tem")
#
#
#
#
#
#
#
#
#source('/Users/rickon/Desktop/randomForestExplainer-master/R/measure_importance.R')
#source('/Users/rickon/Desktop/randomForestExplainer-master/R/min_depth_distribution.R')
#source('/Users/rickon/Desktop/randomForestExplainer-master/R/min_depth_interactions.R')
#library(dplyr)
#library(magrittr)
#library(ggplot2)
#vars <- c('FAT', 'STP', 'Water', 'Tem', 'SOC', 'TN', 'pH', 'BD', 'Clay', 'CEC', 'Nrate', 'UOA', 'others', 'CRF', 'manure', 'SBC', 'Mix', 'DPM', 'Rice', 'Wheat', 'Maize')
#vars
#min_depth_interactions_values_ori <- min_depth_interactions_values(rf,vars)
#min_depth_interactions_values_frame <- data.frame(min_depth_interactions_values_ori[1])  #列是root variable
#save(min_depth_interactions_values_frame, file = "/Users/rickon/Desktop/min_depth_interactions_values_frame.rda")
