library(googlesheets)

library(httr)


table <- 'https://docs.google.com/spreadsheets/d/1KDA8_8gnGC221QaymVdTG_74g10TP9l_9Kj0F65KTVE/edit#gid=0'

# saveData <- function(data) {
#   # Grab the Google Sheet
#   sheet <- gs_title(table)
#   # Add the data as a new row
#   gs_add_row(sheet, input = data)
# }

loadData <- function() {
  # Grab the Google Sheet
  read_sheet(table, col_names = FALSE)
}