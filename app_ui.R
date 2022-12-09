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

min_co2_2021 <- co2_data_2021 %>%
  filter(co2 != 0) %>%
  filter(co2 == min(co2)) %>%
  pull(co2)
min_co2_2021_country <- co2_data_2021 %>%
  filter(co2 != 0) %>%
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
      co2 emissions value of the entire ", max_co2_2021_country, ". In contrast, the lowest co2 value in 2021 above 0 was ",
      min_co2_2021, " million tonnes in the country ", min_co2_2021_country, ". As a comparison, across the entire 
      world in 2021, the average co2 emissions was ", avg_co2_2021, " million tonnes. While these numbers are helpful,
      they also don't really mean anything if there isn't a number to compare it to. So, over the last 10 years, the co2
      emissions has increased by about ", co2_change_10_yr, " million tonnes. This is alarming as you can see that co2
      emissions have definitely been on the rise in pretty large quantities."),
    h3("Aims"),
    p("Through the creation of these charts I am to find patterns that could explain co2 emissions and how they have changed
      over the years. This report will be exploring how co2, population, co2 per capita, and co2 per gdp have changed
      over the years and what patterns can be found based off these charts. ")
  )
)

chart_var_input <- selectInput(
  inputId = "inp_var",
  label = "Select a variable",
  choice = c("co2",
             "population",
             "co2_per_capita",
             "co2_per_gdp"),
  selected = "co2"
)

chart_country_input <- selectInput(
  inputId = "inp",
  label = "Select a country",
  choice = unique(co2_data["country"]),
  selected = "World"
)

chart_panel <- tabPanel(
  "Interactive Visuals",
  titlePanel("Interactive Visuals From the Data"),
  sidebarLayout(
    sidebarPanel(
      p("Please select an input variable and an input country to view the data."),
      chart_var_input,
      chart_country_input
    ),
    mainPanel(
      plotlyOutput("chart"),
      h3("Why this chart?"),
      p("These charts show the data over the years until 2021 for every country. Through these charts you are able to visually see
        how the co2 emissions, population, co2 per capita, and co2 per gdp have risen or fallen for each country. As shown, the 
        co2, population, and co2 per capita have risen pretty drastically. Starting around 1950, these numbers start to increase at a 
        drastic rate. However, for co2 per gdp has risen drastically until about 1940 where it has started to drop. Basesd off these graphs
        we can tell that for while population has been rising, the co2 per each person has risen even more, yet in recent years, the co2 per 
        dollar of a country hasn't risen as much. This is still pretty alarming as if something doesn't happen, co2 will continue to rise 
        drastically at these rates.")
    )
  )
)

ui <- navbarPage(
  "Co2 Emissions",
  intro_panel,
  chart_panel
)
