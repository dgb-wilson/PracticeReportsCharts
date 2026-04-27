# function to disconnect from database
disconnectdb <- function(db){
  dbDisconnect(db, shutdown=T)
}

# function to connect to database
connectdb <- function(){
  dbcon <- DBI::dbConnect(
    duckdb::duckdb(),
    Params$PathToDuckdb
  )
  
  
  return(dbcon)
}


