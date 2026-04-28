# PracticeReportsCharts
Creates charts and textfiles with practice-level inputs for every practice report. 

## Overview

Entire pipeline can be run end to end. The repo should be stored in the same directory as PracticeReportsDataPrep for the paths to the synthetic dataset to be correct.

### Making charts

Assuming the table with the correct data has been created in PracticeReportsDataPrep, creating a chart is simple. Follow the steps below:

+ Navigate to any of the R scripts in R/ChartFunctions/Charts and use this as a template (in the demo there is only one).
+ Save a copy and change all the function names to include a description of your plot. 
+ Change the tables queried in the functions at the top of the script that look like e.g. GetAgeSexData().
+ The next function ending in ...Plot() assumes data inputs for a single practice and produces the formatted plot.
+ The following function starting with Plot...() filters the data to each practice, and relevant PHN, produces the plot and saves it an RDS object. If the plot does not require any PHN or statewide components this script can be simplified by removing these steps.
+ Finally the Make{chart-description}Charts() can generally be left as is (or remove phndata and nswdata as needed). This function must be called in R/ChartFunctions/MakeCharts.R

### Making text files

Any inline text in the report that requires a statistic or a unique input per practice is created in R/TextFileFunctions/MakeTextFiles.R

To include a new textfile follow these steps:

+ create a .txt file to act as a template and save it in Template/TextFiles.
+ Populate it with all the text that does not change per practice, and instead of the changing values use placeholders #01, #02 etc.
  + e.g. "There were #01 patients that attended your practice in the most recent 12 months"   
+ The file once finished must be stored in a single line, no matter how long.
  + you may draft this text on multiple lines and then delete
+ For bold text surround the words that you wish to be in bold with <'b'> <'/b'> without the apostraphies.
+ Open the spreadsheet Template/TextFileElements.xlsx
  + Use previous examples as a guide.
  + This spreadsheet maps the placeholders you created in the template file to the correct table and variable locations where the data is stored.

### Outputs

All charts and textfiles are stored in a directory for each practice within a directory for the corresponding PHN (Primary Health Network)
