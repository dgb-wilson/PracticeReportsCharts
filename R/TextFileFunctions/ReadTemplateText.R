ReadTemplateText <- function(textfiles){
  list_templates = list()
  for(j in 1:nrow(textfiles)){
    
    text <- data.table::fread(file.path(Params$TemplateFolder, 
                                        paste0("TextFiles/",textfiles$filename[j],".txt")),
                              sep="\t",
                              header=FALSE)
    
    list_templates[[textfiles$paragraph_ID[j]]] <- c(list_templates[[textfiles$paragraph_ID[j]]],text[[1]])
    
  }
  return(list_templates)
}