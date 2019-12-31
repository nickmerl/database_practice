library(RMySQL)
library(DBI)

#' creact a database connection
#' 
#' @return a database connection object
#' 
#' 
db_connect <- function() {
   
  DBI::dbConnect(
    MySQL(), 
    dbname = "test_schema", 
    host = "127.0.0.1", 
    port = 3306, 
    user = "root", 
    password = "merl1992"
  )
}
