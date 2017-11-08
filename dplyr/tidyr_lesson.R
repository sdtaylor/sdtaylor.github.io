#5 basic rules of data structure

#1. One observation per row
#2. One column per type of information, describing the observation
#3. Every cell contains one value
#4. Order doesn’t matter
#    Your data should not rely on being sorted correctly (for example by time)
#5. No duplicate rows
#    With descriptive column names, and one observation per row,
#    every row should be unique. Have replicates? great! There
#    should be a column describing those.

library(tidyr)
library(dplyr)
#Read in animals dataset
animals=read.csv('http://sdtaylor.github.io/dplyr/animals.csv', stringsAsFactors = FALSE)

animals
#Whats wrong with it? Which rules does it break?
#Note that how you record data does not have to follow the above rules.
#It should be the most convienent way to do it. Tools in R can help
#you convert raw data to something ready for analysis. 

#make one colum for sites and one column for animal info using gather
animals %>% gather(site, count, -animal)

#Look at the gather help page. There are multiple ways of doing this depending
#on the complexity of your columns
animals <- animals %>% 
  gather(site, count, site_1:site_4)

#Now we have the problem of every cell containing more than one value
#fix that with separate.
animals <- animals %>% 
  separate(count, c('count', 'juvenile'), sep='-', fill='right', convert=TRUE)

#Fill in the new juvenile column with a Y or N
animals <- animals %>%
  mutate(juvenile = ifelse(is.na(juvenile), 'N', 'Y'))

#The shrub dataset
shrubs=read.csv('http://sdtaylor.github.io/dplyr/shrubs.csv')


#In a decent format, but to do our analysis we need each measurement in it's own column
shrubs %>% spread(measurement, value)
