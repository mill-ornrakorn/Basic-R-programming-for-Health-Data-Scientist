#===============================================================
#                 Basic R programming
#===============================================================
# TITLE   : Lecture 02 - Data exploration and ggplot
# SPEAKER : Dr. Palang Chotsiri
# DATE    : 11 Jan 2021
# BY      : Ornrakorn Mekchaiporn
#===============================================================

rm(list = ls())     # clear environment 
.rs.restartR()      # restart R


##========##
## Part 1 ##  Library
##========##

install.packages("ggplot2")

library(ggplot2)  # initialize the pkg 'ggplot2'
require(ggplot2)  # another way to initialize
library()     # see list of all installed packages


## Getting help! There are several ways to get help in R:
## Type ? then the function name (if you know the function) eg

library(help="ggplot2")  # see info about 'car' pkg

?sin    # ถามเกี่ยวกับ function sin
??sin   # ถามเกี่ยวกับทุกที่ ที่มีคำว่า  sin

## Or use the help() function

help(log)
?log

## If you don't know the function name:

help.search('chi square') # -> it suggests chisq.test
??'chi square'
  
## Use autocomplete. If you hit tab after you have input the name of the function, it gives hints on what the arguments could be, eg
#chisq.<<hit TAB here please!>>
## Use google!  As R is a common letter in the alphabet as well as our favorite stats package, you may need to add CRAN into your search term. Note that some of the people who help on these sites can be a bit terse in their answers...

## Where we are?
getwd()         # gets the working directory

dirname <- "** อย่าลืมใส่ working directory **"
setwd(dirname)  # set the working directory to dir name

##========##
## Part 2 ## Import and Export file
##========##

# Gestation.csv เป็นข้อมูลที่เกี่ยวกับอายุครรภ์

gestation <- read.csv("../data/Gestation.csv", header = TRUE, na.strings = "NA") 
# header = TRUE เก็บ header มาด้วย 
# na.strings = "NA" ถ้าเจอ NA ในไฟล์นี้จะแปลว่า missing data

head(gestation)
head(gestation, n = 15)

tail(gestation)
tail(gestation, n = 15)

View(gestation)

class(gestation)

### Write out a file (จะไปอยู่ใน working directory)
write.csv(file = "Gestation_out.csv", gestation[gestation$id>1000,], row.names = FALSE) # เลือกเฉพาะid>1000 
 

##========##
## Part 3 ## Dataframe
##========##

states <- state.x77 # state.x77 เป็น data ที่มีอยู่ใน R อยู่แล้ว
head(states)

View(states)
summary(states)

## structure of the data
str(states) 

##========##
## Part 4 ## Creating a dataframe
##========##

days <- c('Mon','Tue','Wed','Thu','Fri')
temp <- c(22.2,21,23,24.3,25)
rain <- c(TRUE , TRUE , FALSE , FALSE , TRUE)

df <- data.frame(days, temp, rain)
df

# data frame โล่ง ๆ 
empty.df <- data.frame()
empty.df


c1 <- 1:10
c1
c2 <- letters[1:10]
c2
df <- data.frame(number = c1, letters = c2) # Column ที่1 ชื่อ number ส่วน Column ที่ 2 ชื่อ letters
df


##========##
## Part 5 ## Basic data exploration
##========##

gestation <- read.csv("../data/Gestation.csv", header = TRUE, na.strings = "NA")

### Exploring the data
names(gestation) # แต่ละ Column ชื่ออะไรบ้าง
head(gestation)
tail(gestation)

summary (gestation)

nrow(gestation) # จำนวน row
ncol(gestation) # จำนวน Column
rownames(gestation)
colnames(gestation)

View(gestation)

gestation[1,]     # แสดง row ที่1
gestation[,5]     # แสดง column ที่5 
gestation[,"wt"]  # แสดง column wt

gestation$age     # แสดง column age
gestation[gestation$id==6254,] # แสดง column id ที่ 6254

gestation[18:50,] # แสดง row ที่18 ถึง 50


##========##
## Part 6 ## Basic ploting
##========##

# histogram
hist (gestation$wt)
hist (gestation$wt, breaks = 20) # breaks = ความถี่


attach(gestation)   ## จะทำให้เราไม่ต้องมาพิมพ์ gestation data ใหม่อีกเรียกใช้ได้เลย
hist (wt)
hist (wt, breaks = 20)

plot (wt~ht) # มีแกน y เป็น wt แล้วแกน x เป็น ht
plot (wt~ht, main = "Weight-height") # main = ชื่อกราฟ

plot (wt~ht, main = "Weight-height",
      xlab = "Height (inches)", # ชื่อแกน x
      ylab = "Weight (pound)") # ชื่อแกน y


##========##
## Part 6 ## ggplot
##========##

### Basic R Graphics
rm(list = ls()) # clear environment 

data(iris) # เป็น data ที่มีอยู่ใน R อยู่แล้ว
head(iris)

summary(iris)
#par(mfrow=c(1,1))


# 1 Variable - Histograms
hist(iris$Sepal.Width)

# Use relative frequency
hist(iris$Sepal.Width, freq=FALSE)   

hist(iris$Sepal.Width, freq=FALSE, breaks=30)

# 1 variables - Boxplots
boxplot(iris$Petal.Length)
boxplot(iris$Petal.Length~iris$Species)
boxplot(iris$Petal.Length~iris$Species,notch=TRUE)

# 2 variables - Plots
plot(iris$Petal.Width,iris$Petal.Length)
plot(y = iris$Petal.Width, x = iris$Petal.Length)
plot(iris$Petal.Width~iris$Petal.Length)

# เพิ่มเติม: จะใช้ , หรือ ~ ในการขั้นระบุแกนก็ได้ แต่..
# การใช้ , จะมีรูปแบบ คือ แกนx, แกนy (ถ้าเราไม่ได้กำหนดแบบ y= และ x=)
# การใช้ ~ จะมีรูปแบบ คือ แกนy~ แกนx




# Creating the outbreak dataset
outbreak=data.frame("days"=1:15,"deaths"=c(0,2,5,23,21,15,10,6,5,2,3,2,1,1,0))
outbreak

attach(outbreak)

plot(days,deaths)
plot(days,deaths,type="b")
plot(days,deaths,type="l", lwd=5) # lwd มาจาก line width


# Plot with one qualitative variable
plot(iris$Species, iris$Petal.Length)
plot(iris$Species, iris$Petal.Length,notch=T)


# 3 variables or more - Pair-wise graphs
plot(iris[1:4]) # column 1 ถึง 4 โดยplot แบบ correlation หรือ Pair-wise graphs


# Labels - Title
plot(iris$Petal.Length, iris$Petal.Width, 
     main="Petal Width as a function of Petal Length",
     xlab = "Petal Length")


hist(iris$Sepal.Width, freq=F,breaks=30, 
     main="Frequencies of Sepal Width")

# Labels - Axis labels
plot(iris$Petal.Length, iris$Petal.Width, xlab = "Petal length in centimeters", 
     ylab = "Petal width in centimeters also!!!")

# Dimension of the axis
pdf(width = 3, height = 3,  
    file = "output_plot.pdf")
plot(days,deaths,type="l",lwd=3,
     xlim=c(0,30),ylim=c(0,30))
dev.off()

# Colors
hist(iris$Sepal.Width, breaks=20, col= "darkblue")
plot(iris$Species, iris$Petal.Length, xlab="Esp?ce", ylab="longueur des P?tales (en cm)", 
     col="yellow")
plot(days,deaths,type="l",lwd=3, col= "red")


# Low level plotting commands
# Creating the dataset
incidence=c(3,40,25,20,17,12,6,5,3,2,1,0,1,1,0)
outbreak = cbind(outbreak,incidence)

attach(outbreak)
# Add a line to an existing plot
plot(days,deaths,type="l",lwd=3,col="red",ylim=c(0,40))
lines(days,incidence,lwd=2,lty=2,col="blue")
points(days,incidence,col="black", pch = 1, cex=2)


# Add a legend to an existing graph
legend("topright",legend=c("Number of death","Incidence"), lty=c(1,2),lwd=c(3,2), col=c("red","blue"))


# Split the graph window
par(mfrow=c(1,2)) # par มาจาก แบ่งเป็นส่วน ๆ (Partition)
plot(iris$Petal.Width,iris$Petal.Length,col='purple')
plot(iris$Petal.Width,iris$Petal.Length,col='red')

par(mfrow=c(1,1))




### Basic ggplot
library(ggplot2)

ggplot(data = iris) + geom_histogram(aes(x=Sepal.Length)) # เหมือนกับการใช้ hist(iris$Sepal.Length) เลย แต่ต่างตรง Design ของการ plot

# มี 2 กราฟทับกัน
ggplot(data = iris) + 
  geom_histogram(aes(x=Sepal.Length, y=..density..)) +
  geom_density(aes(x=Sepal.Length), col ='red')

ggplot(iris) + geom_density(aes(x=Sepal.Length))

ggplot(iris) + geom_boxplot(aes(y= Petal.Length, x=Species))

ggplot(iris) + geom_boxplot(aes(y= Petal.Length, x=Species), notch = T)

ggplot(iris) + geom_boxplot(aes(y= Petal.Length, x=Species),
                            outlier.colour = "red", 
                            outlier.size = 5,
                            fill = "forestgreen",
                            color = "blue")



ggplot(outbreak) + geom_point(aes(x = days, y = deaths), 
                              col = "red", size=3)

ggplot(outbreak, aes(x = days, y = deaths)) + 
  geom_line(col="blue", size=2) +
  geom_point(col = "red", size=3) 

ggplot(outbreak, aes(x = days)) +
  geom_point(aes(y=deaths), col="red") +
  geom_line(aes(y=incidence), col="blue")

ggplot(outbreak, aes(x = days, y = deaths)) + geom_point(size = 2, colour="red") + 
  geom_line(linetype=2, size=1, colour="blue")



ggplot(iris) + geom_boxplot(aes(x=Species, y=Petal.Width))
ggplot(iris) + geom_point(aes(x=Species, y=Petal.Width))

ggplot(iris) + geom_jitter(aes(x=Species, y=Petal.Width)) # geom_jitter จะเป็นจุดแบบกระจาย ๆ ออกไปจากจุดกึ่งกลางหน่อย ๆ 

ggplot(iris) + 
  geom_jitter(aes(x=Species, y=Petal.Width)) + 
  geom_boxplot(aes(x=Species, y=Petal.Width))

ggplot(iris, aes(x=Species, y=Petal.Width)) + 
  geom_jitter() + geom_boxplot()

ggplot(iris, aes(x=Species, y=Petal.Width)) + 
  geom_jitter(width = 0.1) + 
  geom_boxplot(fill='salmon', 
               alpha=0.5, 
               colour="red", 
               size=0.75)


#label
ggplot(iris, aes(x=Species, y=Petal.Width)) + 
  geom_jitter(width = 0.2) + 
  geom_boxplot(fill='salmon', 
               alpha=0.5, 
               colour="red", 
               size=0.75) +
  labs(x = "Species", 
       y = "Petal Width (cm)",
       title = "Petal Width ~ Species",
       tag = "(A)", 
       caption = "#species vs. petal width") +
  # กำหนด theme 
  theme_bw(base_size = 15) # theme_bw คือ White background and gray grid lines

#  theme(axis.title.x = element_text(colour = "green"),
#        axis.ticks = element_line(color = "orange", size = 1), 
#        panel.background = element_blank(), 
#        panel.border = element_rect(colour = "yellow"),
#        panel.grid = element_blank())



## Gestational data --------------------
gestation <- read.csv("../data/Gestation.csv", header = TRUE, na.strings = "NA")

head(gestation)
summary(gestation)

ggplot(gestation) + geom_histogram(aes(x=age))
ggplot(gestation) + geom_histogram(aes(x=age), fill = "salmon", color = "red")
ggplot(gestation) + geom_histogram(aes(x=age), fill = "salmon", color = "red", alpha=0.5) 

ggplot(gestation) + geom_histogram(aes(x=age), fill = "salmon", color = "red") +
  facet_grid(.~smoke) # facet_grid แบ่งเป็นหน้าต่าง ๆ 

ggplot(gestation) + geom_histogram(aes(x=age), fill = "salmon", color = "red") +
  facet_grid(marital~smoke)

ggplot(gestation, aes(y=wt, x=smoke)) + geom_boxplot()

ggplot(gestation, aes(y=wt, x=smoke)) + geom_jitter(shape=3)
ggplot(gestation, aes(y=wt, x=smoke)) + geom_violin()

ggplot(gestation, aes(x=wt, y=smoke)) + geom_boxplot()
ggplot(gestation, aes(x=wt, y=ed)) + geom_boxplot()

ggplot(gestation) + geom_point(aes(x=dwt, y=dht))

ggplot(gestation) + geom_point(aes(x=dwt, y=dht), color="forestgreen", shape=1)

ggplot(gestation, aes(x=dwt, y=dht)) + 
  geom_point(color="forestgreen", shape=1) +
  geom_smooth(method = "lm", color="red") # geom_smooth เพิ่ม statistics โดย method = "lm" คือ linear models

ggplot(gestation, aes(x=dwt, y=dht)) + 
  geom_point(color="forestgreen", shape=1) +
  geom_smooth(method = "lm", color="red", se = FALSE) # se = FALSE คือไม่เอาเส้น error คือ 95% confidence interval of slope

ggplot(gestation, aes(x=dwt, y=dht, shape=smoke)) + 
  geom_point(color="forestgreen", size=3) +
  geom_smooth(method = "lm", color="red", se = FALSE)

ggplot(gestation, aes(x=dwt, y=dht)) + 
  geom_point(aes(shape=smoke, color=ed), size=3) +
  geom_smooth(method = "lm", color="red", se = FALSE)

ggplot(gestation, aes(x=dwt, y=dht)) + 
  geom_point(color="forestgreen", shape=1) +
  geom_smooth(method = "lm", color="red") + 
  scale_y_continuous(limits = c(65,75)) # ให้แกน y เริ่มต้นที่ 65 ถึง 75

ggplot(gestation, aes(x=dwt, y=dht)) + 
  geom_point(aes(shape=smoke, color=ed), size=3) +
  geom_smooth(method = "lm", color="red", se = FALSE) + 
  scale_y_continuous(limits = c(65, 75))

ggplot(gestation, aes(x=dwt, y=dht)) + 
  geom_point(aes(shape=smoke, color=ed), size=3) +
  geom_smooth(method = "lm", color="red", se = FALSE) + 
  scale_y_continuous(limits = c(65, 75)) +
  theme_classic() # กำหนด theme

ggplot(gestation, aes(x=dwt, y=dht)) + 
  geom_point(color="forestgreen", shape=1) +
  geom_smooth(method = "lm", color="red") + 
  scale_y_continuous(limits = c(65,75)) + 
  theme_minimal()

ggplot(gestation, aes(x=dwt, y=dht)) + 
  geom_point(color="forestgreen", shape=1) +
  geom_vline(aes(xintercept = 175), linetype=2)  # geom_vline คือ vertical lines

ggplot(gestation, aes(x=dwt, y=dht)) + 
  geom_point(color="forestgreen", shape=1) +
  geom_vline(aes(xintercept = 175), linetype=2) +
  geom_hline(aes(yintercept = 70), linetype=3, color="darkblue")  # geom_hline คือ horizontal lines

ggplot(gestation, aes(x=dwt, y=dht)) + 
  geom_point(color="forestgreen", shape=1) +
  geom_vline(aes(xintercept = 175), linetype=2) +
  geom_hline(aes(yintercept = 70), linetype=3, color="darkblue") + 
  facet_grid(.~smoke)

ggplot(gestation, aes(x=dwt, y=dht)) + 
  geom_point(color="forestgreen", shape=1) +
  geom_vline(aes(xintercept = 175), linetype=2) +
  geom_hline(aes(yintercept = 70), linetype=3, color="darkblue") + 
  geom_smooth(method = "lm", color="red", se=FALSE)

ggplot(gestation, aes(x=dwt, y=dht)) + 
  geom_point(color="forestgreen", shape=1) +
  geom_vline(aes(xintercept = 175), linetype=2) +
  geom_hline(aes(yintercept = 70), linetype=3, color="darkblue") + 
  facet_grid(.~smoke) +
  geom_smooth(method = "lm", color="red", se=FALSE)

ggplot(gestation, aes(x=dwt, y=dht)) + 
  geom_point(color="forestgreen", shape=1) +
  geom_vline(aes(xintercept = 175), linetype=2) +
  geom_hline(aes(yintercept = 70), linetype=3, color="darkblue") + 
  facet_grid(.~smoke) +
  geom_smooth(method = "lm", color="red", se=FALSE) + 
  scale_x_log10() + scale_y_log10() 

ggplot(gestation, aes(x=dwt, y=dht)) + 
  geom_point(color="forestgreen", shape=1) +
  geom_vline(aes(xintercept = 175), linetype=2) +
  geom_hline(aes(yintercept = 70), linetype=3, color="darkblue") + 
  geom_smooth(method = "lm", color="red", se=FALSE) +
  theme_classic()

ggplot(gestation, aes(x=dwt, y=dht)) + 
  geom_point(color="forestgreen", shape=1) +
  geom_vline(aes(xintercept = 175), linetype=2) +
  geom_hline(aes(yintercept = 70), linetype=3, color="darkblue") + 
  geom_smooth(method = "lm", color="red", se=FALSE) +
  theme_minimal()

ggplot(gestation, aes(x=dwt, y=dht)) + 
  geom_point(color="forestgreen", shape=1) +
  geom_vline(aes(xintercept = 175), linetype=2) +
  geom_hline(aes(yintercept = 70), linetype=3, color="darkblue") + 
  geom_smooth(method = "lm", color="red", se=FALSE) +
  labs(x = "Dad bodyweight (pounds)", 
       y = "Dad height (inches)") + 
  theme_minimal()

## save out graph
# pdf
pdf("plot1.pdf", width = 10, height = 8)
ggplot(gestation, aes(x=dwt, y=dht)) + 
  geom_point(color="forestgreen", shape=1) +
  geom_vline(aes(xintercept = 175), linetype=2) +
  geom_hline(aes(yintercept = 70), linetype=3, color="darkblue") + 
  geom_smooth(method = "lm", color="red", se=FALSE) +
  labs(x = "Dad bodyweight (pounds)", 
       y = "Dad height (inches)") + 
  theme_bw(base_size = 20)
dev.off()

# png
png("plot1.png", width = 10, height = 8, units = "in", res = 300)
ggplot(gestation, aes(x=dwt, y=dht)) + 
  geom_point(color="forestgreen", shape=1) +
  geom_vline(aes(xintercept = 175), linetype=2) +
  geom_hline(aes(yintercept = 70), linetype=3, color="darkblue") + 
  geom_smooth(method = "lm", color="red", se=FALSE) +
  labs(x = "Dad bodyweight (pounds)", 
       y = "Dad height (inches)") + 
  theme_bw(base_size = 20)
dev.off()




##========##
## Part 6 ## Basic statistics
##========##

gestation <- read.csv('../data/Gestation.csv', header = T, as.is = T, na.strings = "NA")

summary(gestation)

attach(gestation)
mean(age) # จะหาไม่ได้เพราะในข้อมูลมี NA อยู่ จึงต้องลบ NA โดย..บรรทัดต่อมา

mean(age, na.rm = TRUE) # na.rm = TRUE ลบค่า NA ออก แล้วค่อยหาค่า mean
median(age, na.rm = TRUE)

Modes <- function(x) {
  ux <- unique(x)
  tab <- tabulate(match(x, ux))
  ux[tab == max(tab)]
}

Modes(age)

# Measure of spread
max(age, na.rm = TRUE) - min(age, na.rm = TRUE) # จะได้ Range

Q3 <- quantile(age, 0.75, na.rm = TRUE)
Q1 <- quantile(age, 0.25, na.rm = TRUE)
Q3-Q1 # จะได้ IQR หรือจะใช้แบบบรทัดล่างก็ได้

IQR(age, na.rm = TRUE)

sd(age, na.rm = TRUE)

ggplot(gestation) + geom_point(aes(x = dht, y = dwt))

# Variance 
var(age,na.rm = TRUE)
var(wt, na.rm = TRUE)

# covariance 
cov(age, wt, method = "pearson", use = "complete.obs")

# correlation
cor(age, wt, method = "pearson", use = "complete.obs")

