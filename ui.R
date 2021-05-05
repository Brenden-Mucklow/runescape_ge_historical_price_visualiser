library(httr)
library(anytime)
library(tidyr)
library(dplyr)
library(shiny)
library(ggplot2)
library(jsonlite)
#================================================================

tradeable_items = read.csv("all_items_tradeable.csv")

ui <- fluidPage(
    titlePanel(title = h4("Runescape Grand Exchange Prices", align = "center")),
    sidebarLayout(
        sidebarPanel(
            selectInput(inputId = "item_name", 
                        label = "Item Name: ",
                        choices = tradeable_items),
    
            dateRangeInput(inputId = "date_range", 
                           label = "Date Range", 
                           start = "2008-01-01", end = NULL,
                           min = "2008-01-01", max ="2030-12-31"),
    
            submitButton(),
        ),
        mainPanel(plotOutput("ge_item_plot")
    )))

#================================================================
