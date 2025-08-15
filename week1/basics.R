library(tidyverse)
library(gapminder)
library(nycflights13)

gapminder::gapminder
?gapminder

# Documentation says country is a factor with 142 levels (countries) - can we check that
gapminder$country |> unique() |> length()

# How about continent?
gapminder$continent |> unique() |> length()

# How about year?
gapminder$year |> range()
gapminder$year |> unique()
gapminder$year |> unique() |> diff()

# What's the min, mean, median, max of lifeExp?
min(gapminder$lifeExp)
mean(gapminder$lifeExp)
median(gapminder$lifeExp)
max(gapminder$lifeExp)
summary(gapminder$lifeExp)


nycflights13::flights
glimpse(nycflights13::flights)
?dplyr::glimpse
View(nycflights13::flights)
