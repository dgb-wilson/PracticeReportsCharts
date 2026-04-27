OutputTextFiles <- function(practicelist,bodytext,filename,params){
  
  for(i in 1:nrow(practicelist)){
    
    OutputPath <- paste0(file.path(params$OutputFolder,
                                   paste0("PHN_",practicelist$AREA_ID[i]),
                                   practicelist$PRACTICE_ID_TRUE[i],
                                   "TextFiles"),
                         "/",
                         filename,
                         ".txt")
    
    writeLines(bodytext |> 
                 filter(PRACTICE_ID == practicelist$PRACTICE_ID[i]) |> 
                 pull(Text),
               OutputPath)
    
  }
}
