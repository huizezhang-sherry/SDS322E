library(tidyverse)
library(nycflights13)

#################################################################################
#################################################################################
#DATAT |> filter(PREDICATE)

# basic
flights |> filter(dep_delay > 120)
# by a single value
flights |> filter(month == 1)
# by multiple value
flights |> filter(month %in% c(1, 3))
# by negation
flights |> filter(month == 1)
flights |> filter(!month %in% c(1, 3))
# by multiple condition
flights |> filter(month == 1 & dep_delay > 120)
flights |> filter(month == 1, dep_delay > 120)
flights |> filter(month == 1 | dep_delay > 120)

# Warm up: how many airport are there in NYC?
flights$origin |> unique()

# What goes wrong here?
flights |> filter(month = 1)

# predicate functions
1 == 1
1 == 2
1 != 2
3 %in% c(1, 2)
!(3 %in% c(1, 2))
(1 == 1) & (1 == 2) # TRUE and FALSE -> FALSE
(1 == 1) | (1 == 2) # TRUE or FALSE -> TRUE


# Your time
# 1) Find the flights that depart from `JFK`
flight |> filter(...)

# 2) Find the flights that depart from `JFK` in January
flight |> filter(...)

# 3) Find the flights that depart from `JFK` or in January
flight |> filter(...)

# 4) Find the flights that depart from `EWR` and `LGA` and not in January
flight |> filter(...)


#################################################################################
#################################################################################
# `mutate()` allows you to
flights |> mutate(gain = dep_delay - arr_delay)
flights |>
  mutate(
    gain = dep_delay - arr_delay,
    speed = distance / (air_time / 60)
  )

flights |>
  mutate(gain = dep_delay - arr_delay) |>
  mutate(speed = distance / (air_time / 60))

# Your time
# Read the documentation of `mutate()` and modify the following code to put the `gain` column:
# * as the first column,
# * after the `day` variable, and
# * keep only the columns used to create the `gain` column
flights |> mutate(gain = dep_delay - arr_delay, ...)
flights |> mutate(gain = dep_delay - arr_delay, ...)
flights |> mutate(gain = dep_delay - arr_delay, ...)

#################################################################################
#################################################################################
# `group_by()` and `summary()`
flights |> group_by(month)
flights |>
  group_by(month) |>
  summarize(avg_dep_delay = mean(dep_delay))
flights |>
  group_by(month) |>
  summarize(avg_dep_delay = mean(dep_delay, na.rm = TRUE))

# you can also do multiple
flights |>
  group_by(month, origin) |>
  summarize(avg_dep_delay = mean(dep_delay, na.rm = TRUE),
            avg_arr_delay = mean(arr_delay, na.rm = TRUE))

# this is not the same as above
flights |>
  group_by(month, origin) |>
  summarize(avg_dep_delay = mean(dep_delay, na.rm = TRUE)) |>
  summarize(avg_arr_delay = mean(arr_delay, na.rm = TRUE))

# Your time
# Apply the `group_by()` + `summarize()` syntax to calculate the average flight distance for each of the three origins.



#################################################################################
#################################################################################
# arrange() by increasing order
flights |>
  group_by(carrier) |>
  summarize(avg_dep_delay = mean(arr_delay, na.rm = TRUE)) |>
  arrange(avg_dep_delay)

# arrange() by decreasing order
flights |>
  group_by(carrier) |>
  summarize(avg_dep_delay = mean(arr_delay, na.rm = TRUE)) |>
  arrange(-avg_dep_delay)

# this would also work
flights |>
  group_by(carrier) |>
  summarize(avg_dep_delay = mean(arr_delay, na.rm = TRUE)) |>
  arrange(desc(avg_dep_delay))

#################################################################################
#################################################################################
flights |>
  mutate(over_2h_delay = dep_delay > 120, .keep = "used")

flights |>
  mutate(over_2h_delay = dep_delay > 120, .keep = "used") |>
  group_by(over_2h_delay) |>
  summarise(n = n())

flights |>
  mutate(over_2h_delay = dep_delay > 120, .keep = "used") |>
  group_by(over_2h_delay) |>
  summarise(n = n()) |>
  mutate(prop = n/ sum(n) * 100)
