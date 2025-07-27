library(tidyverse)
library(rnaturalearth)
html <- "https://en.wikipedia.org/wiki/List_of_minimum_annual_leave_by_country"
raw <- rvest::read_html(html) |>
  rvest::html_table()
holiday_df <- raw[[2]] |> janitor::clean_names() |> select(1:5)
names(holiday_df) <- c("country", "notes", "paid_vacation",
                       "public_holiday", "total")
holiday_df


## -----------------------------------------------------------------------------------------------------
holiday_df |> filter(row_number() %in% 102:113)


## -----------------------------------------------------------------------------------------------------
holiday_df |> filter(str_detect(paid_vacation, "/"))
holiday_df |> filter(str_detect(paid_vacation, "-"))


## -----------------------------------------------------------------------------------------------------
holiday_df2 <- holiday_df |>
  filter(!row_number() %in% 103:113) |>
  mutate(paid_vacation = str_sub(paid_vacation, 1, 2) |> as.numeric(paid_vacation),
         public_holiday = str_sub(public_holiday, 1, 2) |> as.numeric(),
         total = str_sub(total, 1, 2) |> as.numeric(total),
         paid_vacation = ifelse(is.na(paid_vacation), total - public_holiday, paid_vacation),
         public_holiday = ifelse(is.na(public_holiday), total - paid_vacation, public_holiday),
         total = ifelse(is.na(total), paid_vacation + public_holiday, total))

holiday_df2


## -----------------------------------------------------------------------------------------------------
(country_df <- countries110 |>
  as_tibble() |>
  select(SOVEREIGNT, geometry) |>
  rename(country = SOVEREIGNT))


## -----------------------------------------------------------------------------------------------------
(res <- holiday_df2 |> left_join(country_df, by = "country"))


## -----------------------------------------------------------------------------------------------------
res |> filter(sf::st_is_empty(geometry))


## -----------------------------------------------------------------------------------------------------
nrow(holiday_df2)
nrow(country_df)
nrow(holiday_df2) - nrow(country_df)


## -----------------------------------------------------------------------------------------------------
nrow(res |> filter(sf::st_is_empty(geometry)))


## -----------------------------------------------------------------------------------------------------
countrycode::countryname("United States", "iso3c")
countrycode::countryname("United States of America", "iso3c")


## -----------------------------------------------------------------------------------------------------
holiday_df3 <- holiday_df2 |>
  mutate(code = countrycode::countryname(country, "iso3c"))

country_df2 <- country_df |>
  mutate(code = countrycode::countryname(country, "iso3c"))


## ----warning = TRUE-----------------------------------------------------------------------------------
final_df <- holiday_df3 |> left_join(country_df2, by = "code")


## -----------------------------------------------------------------------------------------------------
holiday_df3 |> filter(row_number() == 44)
country_df2 |> filter(code == "CYP")


## -----------------------------------------------------------------------------------------------------
country_df2 |> filter(row_number() == 168)


## -----------------------------------------------------------------------------------------------------
holiday_df3 |> filter(is.na(code))


## -----------------------------------------------------------------------------------------------------
#| fig.align: center
final_df |>
  ggplot() +
  geom_sf(aes(geometry = geometry, fill = total)) +
  scale_fill_distiller(palette = "YlOrRd", direction = -1) +
  ggthemes::theme_map()


