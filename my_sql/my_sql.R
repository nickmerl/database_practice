
source("db_connect.R", local = TRUE)
table <- "responses"

saveData <- function(data) {
  # Connect to the database
  db <- db_connect()
  
  # Construct the update query by looping over the data fields
  query <- sprintf(
    "INSERT INTO %s (%s) VALUES ('%s')",
    table, 
    paste(names(data), collapse = ", "),
    paste(data, collapse = "', '")
  )
  # Submit the update query and disconnect
  dbExecute(db, query)
  dbDisconnect(db)
}

loadData <- function() {
  # Connect to the database
  db <- db_connect()
  
  # Construct the fetching query
  query <- sprintf("SELECT * FROM %s", table)
  # Submit the fetch query and disconnect
  data <- dbGetQuery(db, query)
  dbDisconnect(db)
  data
}
