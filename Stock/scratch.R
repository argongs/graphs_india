x <- runif(12,1,1.5)
y <- runif(12,1,1.5)
z <- runif(12,1,1.5)
m <- letters[1:12]
df <- data.frame(x,y,z,m)

#first of all you need to melt your data.frame
library(reshape2)
#when you melt essentially you create only one column with the value
#and one column with the variable i.e. your x,y,z 
df <- melt(df, id.vars='m')

#ggplot it. x axis will be m, y will be the value and fill will be
#essentially your x,y,z
library(ggplot2)
ggplot(df, aes(x=m, y=value, fill=variable)) + geom_bar(stat='identity')