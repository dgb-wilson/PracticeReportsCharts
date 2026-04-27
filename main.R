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
  
  # Load spreadsheets for building text files
  textfiles = readxl::read_xlsx("Template/TextFileElements.xlsx", sheet="TextFiles")|> filter(active),
  valuecodes = readxl::read_xlsx("Template/TextFileElements.xlsx", sheet="ValueCodes"),
  datalocations = readxl::read_xlsx("Template/TextFileElements.xlsx", sheet="DataLocations")
  
)

sourceR <- function(folder) lapply(list.files(folder, pattern=".*R$"), function(x) source(file.path(folder, x)))

lapply(c("R/General","R/ChartFunctions","R/ChartFunctions/Charts"), sourceR)

con <- connectdb()

PracticeList <-  dbGetQuery(con, 
                            "SELECT * FROM GPEHR_PRACTICE ORDER BY PRACTICE_ID") 

MakeOutputFolders(PracticeList, Params)

# MakeCharts(practicelist=PracticeList ,
#            params=Params)

MakeTextFiles(practicelist=PracticeList,
              params = Params)


b <- Sys.time()

print(b - a)


