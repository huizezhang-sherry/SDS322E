library(tidyverse)
library(nycflights13)

# `pull()`: extract a single column as a vector
# remember a dplyr verb generally takes a tibble/ data.frame in and returns a tibble/ data.frame out
# but with `pull()`, it returns a vector
flights |> pull(dep_delay)

# Too many variables: `select()`?
flights |> select(year:dep_delay)
# select by position
flights |> select(1:4)
# remove certain variables
flights |> select(-year, -month, -day)
flights |> select(starts_with(c("dep", "arr")))
# you can assume there is an `ends_with()`
flights |> select(contains(c("dep", "arr")))

# rename():
flights |> rename(mth = month)
flights |> rename(mth = month, yr = year)

# distinct(): How many unique origin-dest pair?
flights |> select(origin, dest) |> distinct()

# between(): a convenient way to filter by a range - these two below are the same
flights |> filter(dep_delay >= 60, dep_delay <= 120)
flights |> filter(between(dep_delay, 60, 120))

# `ifelse()` and `case_when()`
# create a label for delay status:
# if the departure delay is less than or equal to 20 minutes, it is "on time"; otherwise, it is "delayed"
flights |> mutate(
  delay_status = ifelse(dep_delay > 20, "delayed", "on time"),
  .keep = "used")

# `ifelse()` is a base R verb, `if_else()` is a dplyr verb - it has better missing value handling
flights |> mutate(
  delay_status = if_else(dep_delay > 20, "delayed", "on time"),
  .keep = "used")


# create a more complex case:
# departure delay <= 20 mins - on time
# 21 <= departure delay <= 60 mins - <1h delay
# 61 <= departure delay <= 120 mins - <2h delay
# else - 2 hr delay

# with ifelse(), you will need to write multiple nested ifelse(), which can be difficult to read
# with case_when(), you can write it in a more readable way
flights |>
  mutate(delay_status = case_when(
    dep_delay <= 20, "on time",
    between(dep_delay, 21, 60), "<1r delayed",
    between(dep_delay, 61, 120), "2r delayed",
    TRUE ~ "more than 2r delayed"
  ),.keep = "used")
