library(tidyverse)
library(gapminder)
library(gganimate)

# install.packages("gifski")
# install.packages("av")

p1 <- ggplot(gapminder, aes(x = gdpPercap, lifeExp, size = pop, colour = continent)) +
  geom_point(alpha = 0.7, show.legend = FALSE)
p1

scales::show_col(gapminder::continent_colors)

p2 <- p1 +
  scale_color_manual(values = gapminder::continent_colors) +
  scale_x_log10(
    breaks = c(500, 1000, 2000, 4000, 8000, 16000, 32000, 64000, 128000),
    labels = c("500", "1000", "2000", "4000", "8k", "16k", "32k", "64k", "128k")
  ) +
  scale_y_continuous(breaks = seq(10, 90, by = 10))

p2

p2 + transition_time(year)

p3 <- p2 + transition_time(year) +
  labs(title = 'Year: {frame_time}', x = 'GDP per capita', y = 'life expectancy')

animate(p3, width = 500, height = 300)
anim_save(p3, filename = "animation/anim/gapminder_animation.gif",
           width = 500, height = 300, nframes = 100, fps = 10)



###############################################################################
library(usmap)
read_csv("data/flight_df.csv")
us_map_sf <- us_map(regions = 'states')
first_flight <- flights$tailnum |> head(1)

flights |>
  filter(tailnum == first_flight) |> View()
  ggplot() +
  geom_sf(data = us_map_sf, color = "white", fill = "grey90") +
  geom_point(aes(x = x, y = y, size = size), color = "red") +
  geom_path(aes(x = x, y = y), alpha = 0.1, color = "red") +
  theme_void() +
  facet_wrap(vars(Reporting_Airline), nrow = 5, dir = "v")
