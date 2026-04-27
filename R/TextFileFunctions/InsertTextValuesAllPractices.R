InsertTextValues <- function(text_table,values,code,type){
  
  out <- text_table |>  
    left_join(values, by="PRACTICE_ID")
  
  if(type=="integer"){
    
    out <- out |> mutate(Text = str_replace(Text,
                                            code,
                                            prettyNum(as.integer(!!sym(code)),
                                                      big.mark = ",")
    )
    )
    
  }else if(type=="percentage"){
    
    out <- out |> mutate(Text = str_replace(Text,
                                            code,
                                            paste0(as.character(round(!!sym(code),digits=1)),"%")
    )
    )
    
  }else if(type=="character"){
    out <- out |> mutate(Text = str_replace(Text,
                                            code,
                                            as.character(!!sym(code))
    )
    )
    
  }else if(type=="float"){
    
    
    out <- out |> mutate(Text = str_replace(Text,
                                            code,
                                            as.character(round(!!sym(code),digits=1))
    )
    )
    
  }else{
    print(paste0("Unrecognised type of ",type))
  }
  return(out |> select(-!!sym(code)))
}


InsertTextValuesAllPractices <- function(practicelist,values,texttemplate,valuecodes){
  
  text_table <- practicelist |> select(PRACTICE_ID)
  text_table["Text"] <- texttemplate
  
  for(j in 1:nrow(valuecodes)){
    code <- valuecodes$valuecode[j]
    ref <- valuecodes$referencevariable[j]
    type <- valuecodes$valuetype[j]
    
    text_table <- InsertTextValues(text_table,
                                   values |> select(PRACTICE_ID,!!code := all_of(ref)) ,
                                   code,
                                   type)
    
    
  }
  return(text_table)
}