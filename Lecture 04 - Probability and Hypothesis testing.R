#===============================================================
#                 Basic R programming
#===============================================================
# TITLE   : Lecture 04 - Probability and Hypothesis testing
# SPEAKER : Dr. Palang Chotsiri
# DATE    : 12 Jan 2021
# BY      : Ornrakorn Mekchaiporn
#===============================================================


##========##
## Part 1 ## One-sample test of population proportion
##========##

?binom.test
?prop.test


## Questions
# Suppose a public health practitioner wanted to see if the prevalence of
# smoking among Thai youths aged 15 to 19 years in 2004 is different
# from 1999 which is reported to be 6.3%.

# He then conducted a large-scale survey and found that 812 out of the
# 8037 youths he sampled smokes.

# Are his estimates of smoking prevalence in 2004 different from the
# reported prevalence in 1999 (let's assume the true prevalence is 6.3% in 1999)?

# H0: p = 0.063, H1: p!= 0.063

binom.test(x = 812,n = 8037,p=0.063,alternative ="two.sided",conf.level=0.95)
binom.test(x = 812,n = 8037,p=0.063,alternative ="two.sided",conf.level=0.99)


prop.test(x = 812,n = 8037,p=0.063,alternative = "two.sided",conf.level=0.95)
prop.test(x = 812,n = 8037,p=0.063,alternative = "two.sided",conf.level=0.99)



##========##
## Part 2 ## One sample test for population mean
##========##

# Questions
# Suppose normal patients have the progesterone receptor (pgr)
# greater 10 fmol/L. Can the patients in this study consider to be normal?

# H0: μ = 10, H1: μ > 10
# mu = average of the population

setwd("** อย่าลืมใส่ working directory **")
gbsg_data <- read.csv("../data/gbsg.csv", header = TRUE, as.is = TRUE)


## Parametric test
?t.test
t.test(gbsg_data$pgr, mu = 10, alternative = "greater")


## Non-parametric test
# Sign Test
binom.test(sum(gbsg_data$pgr>10,na.rm=T),length(gbsg_data$pgr))

# Signed-rank Test - นิยมแบบนี้
wilcox.test(gbsg_data$pgr,mu = 10, alternative = "greater")



##========##
## Part 3 ## Testing the difference of population proportions
##========##

## Questions
# Thailand's National Statistics Office found that the smoking prevalence
# among vocational school students was higher at 16.0% compared to
# secondary school students at 5.1%.

# Suppose a public health practitioner wanted to see if the prevalence of
# smoking among vocational school and secondary school students in
# Thailand is the same.

# In his survey, he found that 324 out of 4987 secondary school students
# smoke and 488 out of 3050 vocational school students smoke. 

# H0: p1 - p2 = 0, H1: p1 - p2 != 0


# Parametric z-test
z.prop = function(x1,x2,n1,n2){
  numerator = (x1/n1) - (x2/n2)
  p.common = (x1+x2) / (n1+n2)
  denominator = sqrt(p.common * (1-p.common) * (1/n1 + 1/n2))
  z.prop.ris = numerator / denominator
  return(z.prop.ris)
}

z.prop(324, 488, 4987,3050)


# Non-parametric Chi-square Test
prop.test(x = c(324, 488), n = c(4987, 3050))




##========##
## Part 4 ## Testing the difference of population means
##========##

# Suppose 299 patients from the total of 689 patients was died after hormonal therapy.
# To determine the outcome of hormone receptor level as the main risk factor of the hormonal therapy.
# Are the estrogen receptor level (er) are the same in the patients who died and survived?


# Let's explore the data first

# In the dataset, Death = 1 refers to patients who died. Death = 2 refers to patients who survived. 

# Plot a histogram
hist(gbsg_data$er[gbsg_data$status==1])
hist(gbsg_data$er[gbsg_data$status==0])

# Plot the distribution 
dens_died = density(gbsg_data$er[gbsg_data$status==1],na.rm=T)
dens_survived=density(gbsg_data$er[gbsg_data$status==0],na.rm=T)
plot(dens_died$x,dens_died$y,type = 'l')
lines(dens_survived$x,dens_survived$y,lty='dotted')

# Using ggplot
gbsg_data$status <- factor(gbsg_data$status, labels = c("Alive","Dead"))
ggplot(gbsg_data, aes(x=er, y=..density.., group=status, col=status)) + 
  geom_density(size=1.0) + 
  labs(x = "Estrogen receptor (fmol/l)")+
  theme_bw(base_size = 20)

# Check the equality of variance before proceeding with t-test
var.test(gbsg_data$er[gbsg_data$status=="Alive"], gbsg_data$er[gbsg_data$status=="Dead"])

# Parametric Test
t.test(gbsg_data$er[gbsg_data$status=="Alive"], gbsg_data$er[gbsg_data$status=="Dead"],
       var.equal = TRUE)

# Non-parametric Test
wilcox.test(gbsg_data$er[gbsg_data$status=="Alive"], gbsg_data$er[gbsg_data$status=="Dead"])


