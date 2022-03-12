#===============================================================
#                 Basic R programming
#===============================================================
# TITLE   : Hand on day 1; Solution
# SPEAKER : Dr. Palang Chotsiri
# DATE    : 11 Jan 2021
# BY      : Ornrakorn Mekchaiporn
#===============================================================

rm(list = ls())     # clear environment 
.rs.restartR()      # restart R

#------------------------------

setwd("** อย่าลืมใส่ working directory **")


# •	Load the data “gbsg.csv” (read data information at “gbsg data.doc”)
gbsg_data <- read.csv("../data/gbsg.csv", header = TRUE, as.is = TRUE)


# •	Check for the 10 first lines
head(gbsg_data, 10)


# •	Get a summary of each variable
summary(gbsg_data)


# •	Plot a histogram of progesterone level and scaling the x axis as log scale. Do you have any comments?
library(ggplot2)
ggplot(gbsg_data, aes(x=pgr)) + 
  geom_histogram() + 
  scale_x_log10() +
  labs(x = "Progesterone level")


# •	Plot a boxplot the distribution of estrogen level (x-axis) by tumor grade (y-axis). Do you have any comment?
ggplot(gbsg_data, aes(x=er, y=as.factor(grade))) + geom_boxplot() + 
  scale_x_log10() + 
  labs(x = "Estrogen level",
       y = "Tumor grade")


# •	Change the class of variable “status” to factor which labels 0 = “Alive” and 1 = “Dead”.
gbsg_data$status <- factor(gbsg_data$status, labels=c("Alive","Dead"))


# •	Plot a scatter plot between estrogen level (x-axis) and progesterone level (y-axis) and faceting by the status. Also, using a logarithmic scale on both x- and y-axis.
ggplot(gbsg_data, aes(x=er, y=pgr)) + geom_point(shape=1) + 
  scale_x_log10() + scale_y_log10() +
  facet_grid(.~status)+
  labs(x = "Estrogen level",
       y = "Progesterone level")


# •	Change the class of variable “grade” to factor which labels 1 = “Mild”, 2 = “Moderate” and 3 = “Severe”.
gbsg_data$grade <- factor(gbsg_data$grade, labels=c("Mild","Moderate","Severe"))


# •	Plot a scatter plot between estrogen level (x-axis) and progesterone level (y-axis) and faceting by the grade (x-panel) and status (y-panel).
# Apply color of each point by their observed age (variable “age”), and scaling the color from “yellow” for low age to “darkgreen” for high age. 
# Using a logarithmic scale on both x- and y-axis. Add an average trend line using method = “loess”. Save the plot as “hand_on_plot.pdf”.
ggplot(gbsg_data, aes(x=er, y=pgr)) + 
  geom_point(aes(col=age)) + 
  scale_x_log10() + scale_y_log10() +
  scale_color_gradient(low = "yellow", high = "darkgreen")+
  facet_grid(status~grade) +
  geom_smooth(method = "loess", color="red") + 
  labs(x = "Estrogen level",
       y = "Progesterone level") + 
  theme_light()

pdf("hand_on_plot.pdf", width = 8, height = 6)
ggplot(gbsg_data, aes(x=er, y=pgr)) + 
  geom_point(aes(col=age)) + 
  scale_x_log10() + scale_y_log10() +
  scale_color_gradient(low = "yellow", high = "darkgreen")+
  facet_grid(status~grade) +
  geom_smooth(method = "loess", color="red") + 
  labs(x = "Estrogen level",
       y = "Progesterone level") + 
  theme_light()
dev.off()


# •	Export the data of patients who had Tumor grade == “Severe” and estrogen level <= 5 
# to the new dataframe in a *.txt  file format using tab as column separator called High_risk_patients.txt
risk.pt <- gbsg_data[gbsg_data$grade == "Severe" & gbsg_data$er <=5,]

write.table(file = "High_risk_patients.txt",
            risk.pt, row.names = FALSE, sep = "\t")
