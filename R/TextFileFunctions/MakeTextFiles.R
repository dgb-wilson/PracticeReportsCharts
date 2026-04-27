MakeTextFiles <- function(practicelist,params) {
  
  # Load spreadsheets for building text files
  textfiles <- params$textfiles
  valuecodes <- params$valuecodes
  datalocations <- params$datalocations
  
  # list of strings for every paragraph that requires bodytext
  # same for every practice
  bodytexttemplates <- ReadTemplateText(textfiles)
  
  for(textfile_ID in 1:nrow(textfiles)){
    
    print(paste0("Inserting values into body text file ", textfile_ID,
                 " of ", nrow(textfiles)))
    
    # For each textfile we find the relevant valuecodes, and datalocations
    valuecodes_tf <- valuecodes |> 
      filter(paragraph_ID == textfiles$paragraph_ID[textfile_ID])
    
    
    datalocations_tf <- datalocations |> 
      filter(referencevariable %in% valuecodes_tf$referencevariable)
    
    
    # we create a table of all the variables for a text file for each Practice
    bodytextvalues <- GetValuesAllPractices(practicelist,
                                            datalocations_tf)
    
    # we populate the template for each Practice
    bodytextfilled <- InsertTextValuesAllPractices(practicelist,
                                                   values = bodytextvalues,
                                                   texttemplate = bodytexttemplates[[textfile_ID]],
                                                   valuecodes = valuecodes_tf)
    
    OutputTextFiles(practicelist,
                    bodytextfilled,
                    filename = textfiles$filename[textfile_ID],
                    params)
    
  }
  
}