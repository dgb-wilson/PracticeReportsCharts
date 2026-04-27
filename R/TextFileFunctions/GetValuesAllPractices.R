GetValuesAllPractices <- function(practicelist, datalocations_tf){
  
  values_table <- practicelist |> select(PRACTICE_ID)
  
  for(j in 1:nrow(datalocations_tf)){
    
    tableName <- datalocations_tf$tablename[j]
    tableVariable <- datalocations_tf$tablevariable[j]
    referenceVariable <-datalocations_tf$referencevariable[j]
    
    values <- GetValues(tableVariable,
                        tableName,
                        referenceVariable,
                        level = datalocations_tf$level[j],
                        practicelist)
    
    # add new column to the values_table
    values_table <- values_table |> left_join(values, by = "PRACTICE_ID")
    
  }
  
  return(values_table)
  
}

GetValues <- function(variable, table, referencevariable, level, practicelist){
  
  if(level=="practice"){
    
    sql_query = paste0("SELECT PRACTICE_ID, ",variable, " AS ", referencevariable," FROM ", table)
    
    
    out <- dbGetQuery(con, sql_query)
    
  }else if(level=="PHN"){
    
    sql_query = paste0("SELECT PHN_NAME, ",variable, " AS ", referencevariable, " FROM ", table)
    
    phn_data <- dbGetQuery(con, sql_query)
    
    out <- practicelist |> 
      select(PRACTICE_ID,PHN_NAME) |> 
      left_join(phn_data, by="PHN_NAME") |> 
      select(-PHN_NAME)
    
  } else if (level=="NSW"){
    
    sql_query = paste0("SELECT ",variable, " AS ", referencevariable, " FROM ", table)
    nsw_data <- dbGetQuery(con,sql_query)
    
    out <- practicelist |> 
      select(PRACTICE_ID) 
    
    out[[toupper(referencevariable)]] <- nsw_data[[toupper(referencevariable)]]
    
  }
  return(out)
}


