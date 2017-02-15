library(dplyr)

###############
#What is a dataframe?
##############

#A variable is a single value, either number, character, or several other datatypes
age <- 1
name <- 'shawn'

#A vector is a collection of variables of the same datatype
all_names <- c('shawn','matt','amanda','rhia')
ages <- c(28,34,12,22)

#A dataframe is a collection of equal length vectors
info <- data.frame(all_names = c('shawn', 'matt','amanda'),
                   ages = c(29,23,12))

#Access individual columns by [] or $
ages <- info$ages
names <- info[,'names']

#Access individual rows by []
matts_info = info[2,]

#########################
#Load the shrub dataset
download.file('sdtaylor.github.io/dplyr/shrub_data.csv', 'shrub_data.csv')
shrubs = read.csv('shrub_data.csv')

shrubs

#########################
#What is dplyr? 
#A package that manipulates data frames using verbs

#Select a single or multiple columns.
select(shrubs, experiment)
select(shrubs, experiment, height)

#Filter on some variable
filter(shrubs, height>2)
filter(shrubs, site=='urban')

#Create a new variable
mutate(shrubs, area=width*length)

#Use the assignment operator to make new dataframes from these
shrubs_area <- mutate(shrubs, area=width*length)

#Multiple new variables can be created
shrubs_area <- mutate(shrubs, area=width*length, radius=width/2)

#Quick exercise
#Make a dataframe of shrubs from experiment A and include the area

#########################################
#Pipes

#The prior two functions take the dataframe as an input, and give
#a modified dataframe as output.

shrubs_area <- mutate(shrubs, area=width*length)
shrubs_A <- filter(shrubs_area, experiment=='A')

shrubs %>% mutate(area=width*length)


shrubs %>% 
    mutate(area=width*length) %>%
    filter(site=='A')


#Execise
#1) Calculate the volume of only shrubs with height greater than 4. 

######################
#Now for something very useful.  summarize data by statistics
#####################

#But what about calculating statistics for each of our sites?
#Pipe it through the group_by() function, and specify the column you want to group by
shrubs %>% 
  group_by(site) %>%
  summarise(height_mean=mean(height))

#Similar to mutate(), multiple variable can be created
shrubs %>% 
  group_by(site) %>%
  summarise(height_mean=mean(height), height_sd=sd(width), width_mean=mean(width), width_sd=sd(width))

#Exercise
# Calculate the mean and standard deviation of height and volume for each experiment group. 


######################
#More complex example using a large dataset
#####################
#The portal dataset is from 25 years of monthly rodent trapping on 24 different plots.
#Each row is a single rodent with information on date, plot number, species, sex, and other characteristics
download.file('sdtaylor.github.io/dplyr/PortalMammals_main.csv', 'PortalMammals_main.csv')
rodents<-read.csv("PortalMammals_main.csv")

#1st a few more tools using summarise()

# n() can be used inside summarise() to count the number of samples inside a group. 
#Example. How many rodents total were caught in each plot in June, 1999
rodents %>%
  filter(yr==1999, mo==6) %>% #Select only entries from June, 1999
  group_by(plot) %>%  #Use group by to 
  summarise(n=n())

#Up until now we've had a small number of rows printed to the screen. Now that there are more than 10
#(the rodent data has 24 plots, so this output has 24 rows), dplyr is trying to be nice with the output
#and not fill up our console. Lets assign this output to a new dataframe to look at it fully.

june1999Counts<-rodents %>%
  filter(yr==1999, mo==6) %>% 
  group_by(plot) %>% 
  summarise(n=n())

#Now for the same period June 1999, I want to know how many of each species was caught. 
june1999Counts<-rodents %>%
  filter(yr==1999, mo==6) %>% 
  group_by(plot, species) %>% 
  summarise(n=n())


# n_distinct() counts the number of distinct values in group.
# How many species were caught at the site in each month in 1999?
species1999 <- rodents %>%
  filter(yr==1999) %>%
  group_by(mo) %>%
  summarize(numSpecies=n_distinct(species))


#Exercises
#1) Whats the average number of rodents caught in each plot in each year?

#2) Whats the average weight of all mice in each year? (the wgt column is the weight of each rodent in grams)

#3) Graph the avgerage mouse weight over all the years of the study


#############################
# tidyr, another useful tool
#############################
#This data is from vegetation transect point counts. Each column is a plot, and 4 transects (each from 1-250dm) were done in each plot.
#Very messy!
veg<-read.csv("~/dplyrLesson/transect_data.csv")

#For easier analysis, we want 1 point per row. As in the following column setup:
# plot, transect, point, species
#
# the tidyr package is made for exactly this.

cleanVeg=veg %>%
  gather(Plot, SpeciesID, -Transect, -Point)

#Here, Plot is a new column that will take on values of the old column names. SpeciesID is a new column that will take on
#values of all the cells. -Transect and -Point tell gather() to keep those columns the same. 

#tidyr can also be used with dplyr
#Here is the most common speciesID on each plot.
mostCommon=veg %>%
  gather(Plot, SpeciesID, -Transect, -Point) %>% 
  group_by(Plot, SpeciesID) %>%
  summarise(n=n()) %>%
  top_n(1, n)

#This uses the top_n() function. which orders each group and gives the highest values of each, in this case just the highest values.
