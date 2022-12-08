#Library
library(shiny)
library(ggplot2)
library(dplyr)
library(tidyverse)
library(plotly)
library(markdown)
library(rsconnect)

#Sources
source("app_server.R")
source("app_ui.R")

#Connection
shinyApp(ui = ui, server = server)
