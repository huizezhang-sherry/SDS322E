#
# ## There are other dplyr verbs you should learn
#
# `select()`: choose the variables you want to keep
#
# `arrange()`: sort the data by one or more variables
#
# `rename(NEW_NAME = OLD_NAME)`: rename the variables
#
#
# Too many variables: `select()`?
flights |> select(year:dep_delay)
# select by position
flights |> select(1:4)
# remove certain variables
flights |> select(-year, -month, -day)
flights |> select(starts_with(c("dep", "arr")))
# you can assume there is an `ends_with()`
flights |> select(contains(c("dep", "arr")))
