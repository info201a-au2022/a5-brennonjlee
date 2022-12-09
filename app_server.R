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

# data dataframe
data <- read.csv("https://raw.githubusercontent.com/owid/co2-data/master/owid-co2-data.csv")

server <- function(input, output) {
  ### Chart
  output$chart <- renderPlotly({
    if(input$inp_var == "co2") {
      #filters data by the state input
      chart_country_data <- data %>%
        filter(country == input$inp) %>%
        group_by(year)
      
      #creates the line chart
      chart <- chart_country_data %>%
        ggplot(mapping = aes_string(x = "year", y = "co2")) +
        geom_line() +
        geom_point() +
        labs(
          title = "Co2 Emissions count by Year",
          x = "Year",
          y = "Co2 Emissions Count"
        ) 
      } else if (input$inp_var == "population") {
        #filters data by the state input
        chart_country_data <- data %>%
          filter(country == input$inp) %>%
          group_by(year)
        
        #creates the line chart
        chart <- chart_country_data %>%
          ggplot(mapping = aes_string(x = "year", y = "population")) +
          geom_line() +
          geom_point() +
          labs(
            title = "Population by Year",
            x = "Year",
            y = "Population"
          ) 
      } else if (input$inp_var == "co2_per_capita") {
        #filters data by the state input
        chart_country_data <- data %>%
          filter(country == input$inp) %>%
          group_by(year)
        
        #creates the line chart
        chart <- chart_country_data %>%
          ggplot(mapping = aes_string(x = "year", y = "co2_per_capita")) +
          geom_line() +
          geom_point() +
          labs(
            title = "Co2 Per Capita by Year",
            x = "Year",
            y = "Co2 Per Capita"
          ) 
      } else if (input$inp_var == "co2_per_gdp") {
        #filters data by the state input
        chart_country_data <- data %>%
          filter(country == input$inp) %>%
          group_by(year)
        
        #creates the line chart
        chart <- chart_country_data %>%
          ggplot(mapping = aes_string(x = "year", y = "co2_per_gdp")) +
          geom_line() +
          geom_point() +
          labs(
            title = "Co2 Per GDP by Year",
            x = "Year",
            y = "Co2 Per GDP"
          ) 
      }
  })
}



