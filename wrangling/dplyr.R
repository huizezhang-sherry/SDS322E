library(tidyverse)
library(nycflights13)

# People care the most about delay - can we learn something about it from the data?
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

flights |> mutate(gain = dep_delay - arr_delay, .before = 1)
flights |> mutate(gain = dep_delay - arr_delay, .after = day)
flights |> mutate(gain = dep_delay - arr_delay, .keep = "used")

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

