#5 basic rules of database structure
#1. Order doesn’t matter
#2. No duplicate rows
#3. Every cell contains one value
#4. One column per type of information
#5. No redundant information
library(tidyr)

#Read in animals dataset
animals=read.csv('http://sdtaylor.github.io/dplyr/animals.csv')

animals
#Whats wrong with it? Which rules does it break?

#make one colum for sites and one colum for animal info using gather
animals %>% gather(site, count, -animal)

#Look at the gather help page. There are multiple ways of doing this depending
#on the complexity of your columns
animals <- animals %>% gather(site, count, site_1:site_4)


#Now we have the problem of every cell containing more than one value
#fix that with separate.
animals %>% separate(count, c('count', 'juvenile'), sep='-', fill='right')

#The shrub dataset
shrubs=read.csv('http://sdtaylor.github.io/dplyr/shrubs.csv')


#In a decent format, but to do our analysis we need each measurement in it's own column
shrubs %>% spread(measurement, value)
