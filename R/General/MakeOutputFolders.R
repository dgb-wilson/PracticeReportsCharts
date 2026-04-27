MakeOutputFolders <- function(practicelist, Params){
  
  for (iPHN in unique(practicelist$AREA_ID)){
    dir.create(file.path(Params$OutputFolder, paste0("PHN_", iPHN)), recursive=TRUE, showWarnings=FALSE)
    
    iPHN_practices <- practicelist[practicelist$AREA_ID==iPHN,]
    
    for (i in 1:nrow(iPHN_practices)){
      dir.create(file.path(Params$OutputFolder, paste0("PHN_", iPHN), iPHN_practices$PRACTICE_ID_TRUE[i]), 
                 recursive=TRUE, 
                 showWarnings=FALSE)
      dir.create(file.path(Params$OutputFolder, paste0("PHN_", iPHN), iPHN_practices$PRACTICE_ID_TRUE[i],"TextFiles"), 
                 recursive=TRUE, 
                 showWarnings=FALSE)
      
    }
  }
  
}