## Cleaning data solutions

## Step 1: Load packages

## Start by installing the required packages. Install and load tidyverse, skimr, and janitor

install.packages("tidyverse")
install.packages("skimr")
install.packages("janitor")


## load it by running the library() function:


library(tidyverse)
library(skimr)
library(janitor)

## Step 2: Import data
## The data in this example is originally from the article Hotel Booking Demand Datasets (https://www.sciencedirect.com/science/article/pii/S2352340918315191), written by Nuno Antonio, Ana Almeida, and Luis Nunes for Data in Brief, Volume 22, February 2019.
## The data was downloaded and cleaned by Thomas Mock and Antoine Bichat for #TidyTuesday during the week of February 11th, 2020 (https://github.com/rfordatascience/tidytuesday/blob/master/data/2020/2020-02-11/readme.md).

## Use the `read_csv()` function to import data from a .csv in the project folder called "hotel_bookings.csv" and save it as a data frame called `bookings_df`:

bookings_df <- read_csv("hotel_bookings.csv")

## Step 3: Getting to know your data

## Explore your data using `head()` function:

head(bookings_df)

## Summarize and preview the data with the `str()` and `glimpse()` functions

str(bookings_df)
glimpse(bookings_df)

## Use `colnames()` to check the names of the columns in your data set.
colnames(bookings_df)

## Use the `skim_without_charts()` function from the `skimr` package 

skim_without_charts(bookings_df)

## Step 4: Cleaning your data

## We are primarily interested in the following variables: hotel, is_canceled, lead_time. Create a new data frame with just those columns, calling it `trimmed_df`.


trimmed_df <- bookings_df %>% 
  select(hotel, is_canceled, lead_time)

## Rename the variable 'hotel' to be named 'hotel_type' to be crystal clear on what the data is about:

trimmed_df %>% 
  select(hotel, is_canceled, lead_time) %>% 
  rename(hotel_type = hotel)

## Combine the arrival month and year into one column using the unite() function:

new_df <- bookings_df %>%
  select(arrival_date_year, arrival_date_month) %>% 
  unite(arrival_month_year, c("arrival_date_month", "arrival_date_year"), sep = " ")


## Step 5: Another way of doing things

## Use the`mutate()` function to make changes to your columns. Create a new column that summed up all the adults, children, and babies on a reservation for the total number of people.

new_df <- bookings_df %>%
  mutate(guests = adults + children + babies)

head(new_df)


## Calculate the total number of canceled bookings and the average lead time for booking - you'll want to start your code after the %>% symbol. Make a column called 'number_canceled' to represent the total number of canceled bookings. Then, make a column called 'average_lead_time' to represent the average lead time. Use the `summarize()` function to do this in the code chunk below:

new_df <- bookings_df %>%
  summarize(number_canceled = sum(is_canceled),
            average_lead_time = mean(lead_time))

head(new_df)

