# libraries

library(shiny)
library(ggplot2)
library(dplyr)
library(tidyverse)
library(ggplot2)
library(plotly)
library(rsconnect)
library(markdown)
library(maps)

data <- read.csv("https://raw.githubusercontent.com/owid/co2-data/master/owid-co2-data.csv")

# introduction values
co2_data <- data %>%
  select('country', 'year', 'co2') %>%
  mutate_all(~replace(., is.na(.), 0))

co2_data_2021 <- co2_data %>%
  filter(year == 2021)

avg_co2_2021 = sum(co2_data_2021$co2)/nrow(co2_data_2021)

max_co2_2021 = max(co2_data_2021$co2)
max_co2_2021_country <- co2_data_2021 %>%
  filter(co2 == max(co2)) %>%
  pull(country)

min_co2_2021 = min(co2_data_2021$co2)
min_co2_2021_country <- co2_data_2021 %>%
  filter(co2 == min(co2)) %>%
  pull(country)

co2_2011 <- co2_data %>%
  filter(year == 2011) %>%
  filter(country == "World") %>%
  pull(co2)
co2_change_10_yr = max_co2_2021 - co2_2011

intro_panel <- tabPanel(
  "Introduction",
  titlePanel("Introduction"),
  mainPanel(
    h3("Co2"),
    p("One of the main drivers for climate change is co2 emissions. Co2 traps heat in the Earth, causing temperatures 
      to rise which could lead to polar ice loss, ocean warming, sea level rise, and other catastrophic events. As a 
      result of the risk of these global events, I decided to dive deeper into the co2 emissions data that is provided
      by Our World in Data. "),
    h3("Key Values"),
    p("Diving deeper into the dataset, I noticed that the most recent data that was collected was in 2021. As a result, 
      across the entire dataset, the highest co2 value was in 2021 at", max_co2_2021, " million tonnes. This was the 
      co2 emissions value of the entire ", max_co2_2021_country, ". In contrast, the lowest co2 value in 2021 was ",
      min_co2_2021, " million tonnes in the country ", min_co2_2021_country, ". As a comparison, across the entire 
      world in 2021, the average co2 emissions was ", avg_co2_2021, " million tonnes. While these numbers are helpful,
      they also don't really mean anything if there isn't a number to compare it to. So, over the last 10 years, the co2
      emissions has increased by about ", co2_change_10_yr, " million tonnes. This is alarming as you can see that co2
      emissions have definitely been on the rise in pretty large quantities.")
  )
)

ui <- navbarPage(
  "Co2 Emissions",
  intro_panel
)
