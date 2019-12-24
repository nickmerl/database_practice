library(RMySQL)

options(mysql = list(
  "host" = "127.0.0.1",
  "port" = 3306,
  "user" = "root",
  "password" = "mypassword"
))
databaseName <- "myshinydatabase"
table <- "responses"

saveData <- function(data) {
  # Connect to the database
  db <- dbConnect(MySQL(), dbname = databaseName, host = options()$mysql$host, 
                  port = options()$mysql$port, user = options()$mysql$user, 
                  password = options()$mysql$password)
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
  db <- dbConnect(MySQL(), dbname = databaseName, host = options()$mysql$host, 
                  port = options()$mysql$port, user = options()$mysql$user, 
                  password = options()$mysql$password)
  # Construct the fetching query
  query <- sprintf("SELECT * FROM %s", table)
  # Submit the fetch query and disconnect
  data <- dbGetQuery(db, query)
  dbDisconnect(db)
  data
}

#' library(DBI)
#' library(RMySQL)
#' 
#' #' Database connection module
#' #'
#' #' A regular function that is used to connect to the db.
#' #'
#' #' @return a DBIConnect object that can be used to query the database
#' db_connect <- function(config) {
#'   
#'   if (is.null(config)) {
#'     stop("Missing or invalid config file")
#'   } else {
#'     conn <- DBI::dbConnect(
#'       RMySQL::MySQL(),
#'       dbname =  config$dbname,
#'       user = config$user,
#'       host = config$host,
#'       password = config$password
#'     )
#'     
#'     # make sure we disconnect the database connection when the session ends
#'     try({
#'       shiny::onStop(function() {
#'         DBI::dbDisconnect(conn)
#'       })
#'     })
#'     
#'   }
#'   
#'   return(list(
#'     "conn" = conn
#'   ))
#' }