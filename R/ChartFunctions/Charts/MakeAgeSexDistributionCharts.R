GetAgeSexData <- function(){
  
  dbGetQuery(con, "SELECT * FROM CHARTS_AGE_SEX_DISTRIBUTION") 
}

GetAgeSexphndata <- function(data, practicelist){
  
  dbGetQuery(con, "SELECT * FROM CHARTS_AGE_SEX_DISTRIBUTION_PHN")
}

GetAgeSexnswdata <- function(data){
  dbGetQuery(con, "SELECT * FROM CHARTS_AGE_SEX_DISTRIBUTION_NSW")
}


AgeSexDistributionPlot <- function(plotdata, plotphndata, plotnswdata, params){
  
  # add spaces to labels to try and center them -- (is there a better solution?)
  plotdata$TEN_AGE_CAT[which(plotdata$TEN_AGE_CAT=="0-9")] = "  0-9"
  plotphndata$TEN_AGE_CAT[which(plotphndata$TEN_AGE_CAT=="0-9")] = "  0-9"
  plotnswdata$TEN_AGE_CAT[which(plotnswdata$TEN_AGE_CAT=="0-9")] = "  0-9"
  plotdata$TEN_AGE_CAT[which(plotdata$TEN_AGE_CAT=="90+")] = "  90+"
  plotphndata$TEN_AGE_CAT[which(plotphndata$TEN_AGE_CAT=="90+")] = "  90+"
  plotnswdata$TEN_AGE_CAT[which(plotnswdata$TEN_AGE_CAT=="90+")] = "  90+"
  
  
  ordered_categories <- c("  0-9",
                          "10-19",
                          "20-29",
                          "30-39",
                          "40-49",
                          "50-59",
                          "60-69",
                          "70-79",
                          "80-89",
                          "  90+")
  
  factor(plotdata$TEN_AGE_CAT)
  plotdata$TEN_AGE_CAT <- factor(plotdata$TEN_AGE_CAT,levels = ordered_categories)
  factor(plotphndata$TEN_AGE_CAT)
  plotphndata$TEN_AGE_CAT <- factor(plotphndata$TEN_AGE_CAT,levels = ordered_categories)
  factor(plotnswdata$TEN_AGE_CAT)
  plotnswdata$TEN_AGE_CAT <- factor(plotnswdata$TEN_AGE_CAT,levels = ordered_categories)
  
  
  maxy <- ceiling(max(max(plotdata$PATIENTS_PERCENT, plotphndata$PATIENTS_PERCENT,plotnswdata$PATIENTS_PERCENT)+5)/5)*5 # adds 5 for room for labels and then rounds up to the nearest multiple of 5
  
  mplot <- plotdata |>
    filter(SEX=="Male") |>
    ggplot()+
    aes(x=TEN_AGE_CAT, y=-1*PATIENTS_PERCENT, label=round(PATIENTS_PERCENT,digits=1))+
    geom_col(data=plotphndata |> filter(SEX=="Male"),
             aes(x=TEN_AGE_CAT,y=-1*PATIENTS_PERCENT),
             position="stack",
             fill=params$ThisPHNColour)+
    geom_col(fill=params$ThisPracticeColour,
             width=0.4)+
    geom_text(y=-maxy+4,hjust=1,size=2.5)+
    stat_summary(
      data = plotnswdata |> filter(SEX=="Male"),
      aes(x = TEN_AGE_CAT, y = -1*PATIENTS_PERCENT),
      fun = identity,
      geom = "tile",
      width = 0.6,
      height = 0.25,
      colour = params$NSWColour,
      fill = params$NSWColour
    )+
    coord_flip()+
    labs(x=NULL,
         y="Percent of patients", 
         title="Male")+
    scale_y_continuous(labels=abs,
                       limits=c(-maxy,0))+
    scale_x_discrete(position = "top")+
    theme_classic()+
    theme(plot.title = element_text(hjust = 0.5, size=9),
          axis.line.y=element_blank(),
          axis.ticks.y=element_blank(),
          axis.title.y=element_blank(),
          axis.text.x=element_text(size=8),
          axis.text.y=element_text(size=8),
          axis.title.x=element_text(size=9)
    )
  
  fplot <- plotdata |>
    filter(SEX=="Female") |>
    ggplot()+
    aes(x=TEN_AGE_CAT, y=PATIENTS_PERCENT, label=round(PATIENTS_PERCENT,digits=1))+
    
    geom_col(data=plotphndata |> filter(SEX=="Female"),
             aes(x=TEN_AGE_CAT,y=PATIENTS_PERCENT),
             position="stack",
             fill=params$ThisPHNColour)+
    geom_col(fill=params$ThisPracticeColour,
             width=0.4)+
    geom_text(y=maxy-1,hjust=1,size=2.5)+
    stat_summary(
      data = plotnswdata |> filter(SEX=="Female"),
      aes(x = TEN_AGE_CAT, y = PATIENTS_PERCENT),
      fun = identity,
      geom = "tile",
      width = 0.6,
      height = 0.25,
      colour = params$NSWColour,
      fill = params$NSWColour
    )+
    scale_x_discrete(position="top") +
    scale_y_continuous(labels=abs,
                       limits=c(0,maxy))+
    coord_flip()+
    labs(x=NULL,
         y="Percent of patients",
         title="Female")+
    theme_classic()+
    theme(plot.title = element_text(hjust = 0.5, size=9),
          axis.line.y=element_blank(),
          axis.text.y=element_blank(),
          axis.ticks.y=element_blank(),
          axis.title.y=element_blank(),
          axis.text.x=element_text(size=8),
          axis.title.x=element_text(size=9)
    )
  
  
  
  patplot1 <- plot_grid(mplot,fplot,rel_widths = c(5.85,5))
  
  mvisplot <- plotdata |>
    filter(SEX=="Male") |>
    ggplot()+
    aes(x=TEN_AGE_CAT, y=-1*ENCOUNTERS_PERCENT, label=round(ENCOUNTERS_PERCENT,digits=1))+
    geom_col(data=plotphndata |> filter(SEX=="Male"),
             aes(x=TEN_AGE_CAT,y=-1*ENCOUNTERS_PERCENT),
             position="stack",
             fill=params$ThisPHNColour)+
    geom_col(fill=params$ThisPracticeColour,
             width=0.4)+
    geom_text(y=-maxy+4,hjust=1,size=2.5)+
    stat_summary(
      data = plotnswdata |> filter(SEX=="Male"),
      aes(x = TEN_AGE_CAT, y = -1*ENCOUNTERS_PERCENT),
      fun = identity,
      geom = "tile",
      width = 0.6,
      height = 0.25,
      colour = params$NSWColour,
      fill = params$NSWColour
    )+
    coord_flip()+
    labs(x=NULL,
         y="Percent of visits", 
         title="Male")+
    scale_y_continuous(labels=abs,
                       limits=c(-maxy,0))+
    scale_x_discrete(position = "top")+
    theme_classic()+
    theme(plot.title = element_text(hjust = 0.5, size=9),
          axis.line.y=element_blank(),
          axis.ticks.y=element_blank(),
          axis.title.y=element_blank(),
          axis.text.x=element_text(size=8),
          axis.text.y=element_text(size=8),
          axis.title.x=element_text(size=9)
    )
  
  fvisplot <- plotdata |>
    filter(SEX=="Female") |>
    ggplot()+
    aes(x=TEN_AGE_CAT, y=ENCOUNTERS_PERCENT, label=round(ENCOUNTERS_PERCENT,digits=1))+
    
    geom_col(data=plotphndata |> filter(SEX=="Female"),
             aes(x=TEN_AGE_CAT,y=ENCOUNTERS_PERCENT),
             position="stack",
             fill=params$ThisPHNColour)+
    geom_col(fill=params$ThisPracticeColour,
             width=0.4)+
    geom_text(y=maxy-1,hjust=1,size=2.5)+
    stat_summary(
      data = plotnswdata |> filter(SEX=="Female"),
      aes(x = TEN_AGE_CAT, y = ENCOUNTERS_PERCENT),
      fun = identity,
      geom = "tile",
      width = 0.6,
      height = 0.25,
      colour = params$NSWColour,
      fill = params$NSWColour
    )+
    scale_x_discrete(position="top") +
    scale_y_continuous(labels=abs,
                       limits=c(0,maxy))+
    coord_flip()+
    labs(x=NULL,
         y="Percent of visits",
         title="Female")+
    theme_classic()+
    theme(plot.title = element_text(hjust = 0.5, size=9),
          axis.line.y=element_blank(),
          axis.text.y=element_blank(),
          axis.ticks.y=element_blank(),
          axis.title.y=element_blank(),
          axis.text.x=element_text(size=8),
          axis.title.x=element_text(size=9)
    )
  
  
  
  patplot2 <- plot_grid(mvisplot,fvisplot,rel_widths = c(5.85,5))
  
  patplots <- plot_grid(patplot1, patplot2, ncol=2)
  
  
  title <- ggdraw() + draw_label("Age and Sex", fontface='bold',size = 12)
  # 
  subtitle1 <- ggdraw() + draw_label("By percent of patients", size=10)
  subtitle2 <- ggdraw() + draw_label("By percent of all visits", size=10)
  subtitle <- plot_grid(subtitle1, subtitle2, ncol=2)
  
  out <- plot_grid(title,subtitle, patplots,ncol=1,rel_heights = c(.1,.1,1))
  
  return(out)
}

PlotAgeSexDistribution <- function(i, 
                                   data,
                                   phndata,
                                   nswdata,
                                   practicelist,
                                   params,
                                   filename, 
                                   height=11.01, 
                                   width=9.48){
  
  print(paste0("Making age sex distribution chart for practice ", i,
               " of ", max(practicelist$PRACTICE_ID)))
  iPractice <- i
  
  iPracticeTrueID <- practicelist$PRACTICE_ID_TRUE[which(practicelist$PRACTICE_ID == iPractice)]
  iPHN <- practicelist$AREA_ID[which(practicelist$PRACTICE_ID == iPractice)]
  
  tmp <- data |> 
    filter(PRACTICE_ID == iPractice)
  
  tmp_phn <- phndata |>
    filter(AREA_ID==iPHN)
  
  
  p <- AgeSexDistributionPlot(tmp, tmp_phn, nswdata, params)
  
  SaveChart(chart=p,
            filename=filename,
            height=height,
            width=width,
            PracticeIDTrue=iPracticeTrueID,
            PHN=iPHN)
  
}


TMakeAgeSexDistributionCharts <- function(practicelist, 
                                         params, 
                                         filename){
  
  
  practicedata <- GetAgeSexData()
  
  phndata <- GetAgeSexphndata()
  
  nswdata <- GetAgeSexnswdata()
  
  purrr::map(unique(practicelist$PRACTICE_ID), 
             PlotAgeSexDistribution, 
             data=practicedata,
             phndata,
             nswdata,
             practicelist=practicelist,
             params=params,
             filename=filename)
  
  
}

