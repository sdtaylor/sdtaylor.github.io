do quick recap

write on board - 3 tables w/ columns
5 verbs


introduce 3 tables

surveys
plot_info
species_info

before things were combined for us. this is more typical because information isn't repeated.

a quick recap because we'll be using some things from prior weeks

data.frame

%>%

mutate
    math on single column
    math between two columns
    paste different ext columns

select
filter
    drop NA because it's a packrat and we're not interested in the things they eat
    keep only certain species because they compete with eachother ( %in% statement)
    
group_by/summarize

Want: number of species per plot type
To do our analysis though we need to combine them. 

to get information on the plot treatment we have to match the plot column. 
both have a matching column

have left_join group_by example joining them and summarize by plot_type species richness

surveys %>% 
    left_join(plot_info, by='plot_id') %>% 
    group_by(plot_type) %>% 
    summarize(num_species = n_distinct(species_id))

left_join? right_join?
http://r4ds.had.co.nz/diagrams/join-venn.png

###challenge
get a the mean weight by genus
surveys %>% 
    left_join(species_info, by='species_id') %>% 
    group_by(genus) %>% 
    summarize(num_species = n_distinct(species_id))


# joins can be use to tie together different analysis
# for example we want to calculate the weight annomoly, that is the different from the average weight

mean_species_weight = surveys %>%
    group_by(species_id) %>%
    summarize(mean_species_weight = mean(weight))
    
weight_annomoly = surveys %>%
    left_join(mean_species_weight, by='species_id') %>%
    mutate(weight_annomoly = weight - mean_species_weight)
    
# do it also by species, sex to show a join with multiple "bys"


mean_species_weight = surveys %>%
    group_by(species_id, species) %>%
    summarize(mean_species_weight = mean(weight))
    
weight_annomoly = surveys %>%
    left_join(mean_species_weight, by=c('species_id','sex')) %>%
    mutate(weight_annomoly = weight - mean_species_weight)
    
######################################
create surveys_full to use in gather/spread lesson

surveys_full = surveys %>%
    left_join(species_info, by='species_id') %>%
    left_join(plot_info, by='plot_id') 

###############
# Go into lesson 3 gather/spread part
###############

challenge #1. make this dataframe

plot_id, 2000, 2001, 2002
1,         3    5     4    (number of species)
2,
3,

# Use case for gather. plotting different variables
# draw plot

x = surveys_full %>% 
    gather(measurement, value, hindfoot_length, weight)
    
ggplot(x, aes(x=genus, y=value)) + 
    geom_boxplot() + 
    facet_wrap(~measurement, ncol=1, scales='free_y')


