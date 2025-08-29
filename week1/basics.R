library(tidyverse)
library(gapminder)
library(nycflights13)

# these two are the same PKGNAME::DATASET and DATASET
gapminder::gapminder
gapminder

# read documentation with "?"
?gapminder

################################################################################################
# Categorical variables
# Documentation says "country is a factor with 142 levels" - can we check that
# print all the country with $
gapminder$country

# The countries are repeated - find the unique value with `unique()`
unique(gapminder$country)

# How many unique countries are there?
length(unique(gapminder$country))

# We can repeat that for continent?
gapminder$continent
unique(gapminder$continent)
length(unique(gapminder$continent))

################################################################################################
# Integer variables
# Look at the year variable
gapminder$year

# find the range of years
range(gapminder$year)

# find the unique value
unique(gapminder$year)

# calculate the difference between every other year
# 1957 - 1952 = 5
# 1962 - 1957 = 5
# etc
# notice there are 12 values, so there are 11 differences
diff(unique(gapminder$year))

################################################################################################
# Numerical variables
# calculate summary statistics with min, mean, median, max of a variable
# life Exp is a numerical variable
gapminder$lifeExp
min(gapminder$lifeExp)
mean(gapminder$lifeExp)
median(gapminder$lifeExp)
max(gapminder$lifeExp)
summary(gapminder$lifeExp)


################################################################################################
# The flight data
nycflights13::flights
glimpse(nycflights13::flights)
?dplyr::glimpse
View(flights)

# what is the problem with the output below?
mean(flights$arr_delay)

# print the arrival delay variable - do you see the NAs?
flights$arr_delay
# notice the last line of the output: we didn't print all the values
# "[ reached 'max' / getOption("max.print") -- omitted 335776 entries ]"
# we can see the last few values with `tail()`
tail(flights$arr_delay, n = 10)

# There is also the function to see the first few values: `head()`
head(nycflights13::flights$arr_delay, n = 10)

# test whether those last 10 values are NA with `is.na()`
is.na(tail(flights$arr_delay, n = 10))

# calculate the mean again, but this time remove the NAs with na.rm = TRUE
mean(nycflights13::flights$arr_delay, na.rm = TRUE)
