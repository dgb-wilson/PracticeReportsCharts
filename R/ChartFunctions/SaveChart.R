SaveChart <- function(chart=p,
                      filename=OutputFile,
                      height=height,
                      width=width,
                      PracticeIDTrue=iPracticeTrueID,
                      PHN=iPHN){
  
  OutputFolder <- fGetOutputFolder(PracticeIDTrue, paste0("PHN_",PHN))
  OutputFile <- file.path(OutputFolder, paste0(filename, ".rds"))
  
  print(OutputFile)
  
  # ggsave(paste0(OutputFile, ".svg"), chart, height=height, width=width,units = "cm")
  saveRDS(chart, OutputFile)
}