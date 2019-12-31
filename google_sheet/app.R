library(googledrive)
library(googlesheets4)
library(dplyr)
library(shiny)

# token <- drive_token()
# saveRDS(token, "my_token.RDS")


# read in the token
token <- readRDS("my_token.RDS")

# authenticate with the token
drive_auth(token = token)


source("googl_sheet.R")

drive_get("practice_database")

# Define the fields we want to save from the form
fields <- c("name", "used_shiny", "r_num_years")

# Shiny app with 3 fields that the user can submit data for

ui <- fluidPage(
  DT::dataTableOutput("responses", width = 300), tags$hr(),
  textInput("name", "Name", ""),
  checkboxInput("used_shiny", "I've built a Shiny app in R before", FALSE),
  sliderInput("r_num_years", "Number of years using R", 0, 25, 2, ticks = FALSE),
  actionButton("submit", "Submit")
)

server <- function(input, output, session) {
    
  # Whenever a field is filled, aggregate all form data
  formData <- reactive({
    data <- sapply(fields, function(x) input[[x]])
    data
  })
    
  # When the Submit button is clicked, save the form data
  observeEvent(input$submit, {
    saveData(formData())
  })
    
  # Show the previous responses
  # (update with current response when Submit is clicked)
  output$responses <- DT::renderDataTable({
    input$submit
    loadData()
  })     
}

shinyApp(ui, server)
