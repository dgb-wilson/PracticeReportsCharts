# Practice reports charts, tables and textfiles preparation
# Dan Wilson

library(openxlsx2)
library(duckdb)
library(scales)
library(stringr)
library(flextable)
library(gridExtra)
library(cowplot)
library(dplyr)
library(tidyr)
library(readr)
library(ggplot2)
library(forcats)

Params <- list(
  ThisPracticeColour = "#fbb457",
  ThisPHNColour = "#aec4a4",
  ThisPHNErrorBarColour = "#6b8e5c",
  NSWColour = "#4395a7",
  NSWErrorBarColour = "#24505b",
  PathToDuckdb = "../PracticeReportsDataPrep/Data/PracticeReportData.duckdb",
  OutputFolder = "./Output",
  TemplateFolder = "./Template",
  
)

sourceR <- function(folder) lapply(list.files(folder, pattern=".*R$"), function(x) source(file.path(folder, x)))

lapply(c("R/General"), sourceR)

con <- connectdb()

PracticeList <-  dbGetQuery(con, 
                            "SELECT * FROM GPEHR_PRACTICE ORDER BY PRACTICE_ID") 

MakeOutputFolders(PracticeList, Params)


b <- Sys.time()

print(b - a)


