# Define UI for application that draws a histogram
shinyUI(
  fluidPage(
    useShinyjs(),
    titlePanel("Shiny - Visualisation"),
    
    tabsetPanel(
      tabPanel("Categorical",
               h3("Subset-Categorical Variables"),
               tabsetPanel(
                 tabPanel("Summary", 
                          htmlOutput(outputId = "SummaryA1")

                  ),
                  tabPanel("Raw Data",
                            DT::dataTableOutput(outputId="catsdata")
                  ),
                  tabPanel("Visualisation",  
                           selectizeInput(inputId="VariablesA",label="Choose Categorical Variables to chart:",
                                          choices=choicesA,multiple=TRUE,selected=choicesA_1),
                           withSpinner(plotOutput(outputId="Mosaic")),
                           hr(),
                           withSpinner(
                             plotOutput(outputId = "tableplot1")
                           )
                  )
              )
        ),
      
      tabPanel("Numeric",
               h3("Subset-Numeric Variables"),
               tabsetPanel(
                 tabPanel("Summary",
                          htmlOutput(outputId = "SummaryB1")
                 ),
                 tabPanel("Raw Data",
                          DT::dataTableOutput(outputId = "numsdata")),
                 tabPanel("Visualisation",
                          withSpinner(
                            plotOutput(outputId = "Boxplot")
                          ),
                          checkboxInput(inputId = "standardise", label = "Show standardized", value = FALSE),
                          checkboxInput(inputId = "outliers", label = "Show outliers", value = TRUE),
                          sliderInput(inputId = "range", label = "IQR Multiplier", min = 0, max = 5, step = 0.1, value = 1.5),
                          hr(),
                          withSpinner(
                            plotOutput(outputId = "Corrgram")
                          ),
                          checkboxInput(inputId = "abs", label = "Uses absolute correlation", value = TRUE),
                          selectInput(inputId = "CorrMeth", label = "Correlation method", choices = c("pearson","spearman","kendall"), selected = "pearson"),
                          selectInput(inputId = "Group", label = "Grouping method", choices = list("none" = FALSE,"OLO" = "OLO","GW" = "GW","HC" = "HC"), selected = "OLO"),
                          hr(),
                          withSpinner(
                            plotOutput(outputId = "Rising")
                          ),
                          hr(),
                          withSpinner(
                            plotOutput(outputId = "tableplot2")
                          )
                          )
                 
              )
      ),
      tabPanel("Full Data",
               h3("Full Data"),
               tabsetPanel(
                 tabPanel("Summary",
                          verbatimTextOutput(outputId = "SummaryC1"),
                          verbatimTextOutput(outputId = "SummaryC2")
                 ),
                 tabPanel("Raw Data",
                          DT::dataTableOutput(outputId = "dat")),
                 tabPanel("Visualisation",
                          withSpinner(
                            plotOutput(outputId = "Missing")
                          ),
                          checkboxInput(inputId = "cluster", label = "Cluster missingness", value = FALSE),
                          hr(),
                          withSpinner(
                            plotOutput(outputId = "Pairs1") #ggpairs for all variabels 
                          ),
                          hr(),
                          withSpinner(
                            plotOutput(outputId = "Pairs2") #ggpairs for important variabels 
                          )
                 ),
                 tabPanel("MixedPairs Numeric- Categorical",
                          selectizeInput(inputId="VariablesD",
                                         label="Choose Categorical Variables to chart:",
                                         choices=choicesA,multiple=TRUE,
                                         selected=choicesD_default),
                          selectizeInput(inputId="VariablesE",
                                         label="Choose Numeric Variables to chart:",
                                         choices=choicesC,multiple=TRUE,
                                         selected=choicesE_default),
                          selectizeInput(inputId="VariablesF",
                                         label="Choose Categorical Variables to colour:",
                                         choices=choicesA,multiple=FALSE,
                                         selected="Speed"),
                          p("median_survey1to10 represents the Row Medians of group
                            survey 1 to survey 10"),
                          p("median_survey11to20 represents the Row Medians of group
                            survey 11 to survey 20"),
                          p("median_survey21to30 represents the Row Medians of group
                            survey 21 to survey 30"),
                          plotOutput(outputId="MixedPairs")
                          )
               )
      )
    )))
        
      
        

    
