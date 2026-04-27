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

# useful function to get the correct ouput folder
fGetOutputFolder <- function(PracticeIDTrue=NULL, PHN){
  if(!is.null(PracticeIDTrue)){
    file.path(Params$OutputFolder, PHN, PracticeIDTrue)
  } else {
    file.path(Params$OutputFolder, PHN)
  }
}
