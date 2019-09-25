#Script Author: Justine Neville
#Title: Module 5 exercises
#purpose: practice using the dplyr package in R studio
#Last modified: 9/24/19

library(tidyverse)
#Exercise 1----
shrub_vol <- read_csv("data/shrub-volume-data.csv")
names(shrub_vol)
str(shrub_vol)
head(shrub_vol)
#use dplyr functions for this section
shrub_vol %>%
  select("length")
shrub_vol %>%
  select("site","experiment")
filter(shrub_vol,height>5)

shrub_data_w_vols <- mutate(shrub_vol,
                            vol = height*width*length)

#Exercise 2----
#group by site
by_site <- group_by(shrub_vol, site)
avg_height <- summarize(by_site, avg_height = mean(height))
#group by experiment
by_experiment <- group_by(shrub_vol, experiment)
(avg_exp_height <- summarize(by_experiment, avg_height = mean(height)))
#site height max
(max_site_height <- summarize(by_site, max_site_height = max(height)))

#Exercise 3 fix the code----
read_csv("data/shrub-volume-data.csv")
shrub_vol %>%
  mutate(volume = length * width * height) %>%
  group_by(site) %>%
  summarize(mean_site_volume = mean(volume))
shrub_vol %>%
  mutate(volume = length * width * height) %>%
  group_by(experiment) %>%
  summarize(mean_exp_volume = mean(volume))

#Exercise 4 pipes----
#use mutate(), select(),and na.omit() with pipes
surveys <- read_csv("data/surveys.csv")
surveys2 <- surveys %>%
  na.omit() %>%
  mutate(weight_kg = weight/1000) 
new_surveys <- select(surveys2,year,species_id,weight_kg)
# use filter and select to get year, mo, day, species id columns for all rows where species == SH
surveys %>%
  select(year,month,day,species_id) %>%
  filter(species_id == "SH")
#use group_by() and summarize() to get a cound of number of indivs in each species_id
surveys %>%
  group_by(species_id) %>%
  summarise(species_count=n())
#use group_by() and summarize() to get a count of number of indivs in each species ID in each year
surveys %>%
  #na.omit() %>%
  group_by(species_id, year) %>%
  summarise(n())
#use filter(), group_by(), and summarize() to get mean mass of species DO in each year
surveys %>%
  na.omit() %>%
  group_by(species_id,year) %>%
  filter(species_id == "DO") %>%
 summarize(mean_mass=mean(weight))
