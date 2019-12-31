library(RSQLite)
library(DBI)

conn <- db_connect()

dbExecute(
  conn,
  "CREATE TABLE responses(name TEXT, used_shiny TEXT, r_num_years TEXT);"
)

dbListTables(conn)

responses <- dbGetQuery(conn, "SELECT * FROM responses")

dbDisconnect(conn)
