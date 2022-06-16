# Define server logic required to draw plots
shinyServer(function(input, output,session) {
  # subset-categorical variables
  output$SummaryA1 <- renderUI({
    print(summarytools::dfSummary(catsdata, varnumbers=TRUE, graph.magnif=0.8),
          method="render",
          heading=FALSE,
          bootstrap.css=FALSE)
  })
  
  output$catsdata <- DT::renderDataTable({DT::datatable(data = as.data.frame(catsdata))})
  
  output$Mosaic <- renderPlot({
    formula <- as.formula(paste("~",paste(input$VariablesA, collapse = " + ")))
    vcd :: mosaic(formula,data = catsdata, main = "Mosaic Plot",shade = TRUE,
                  legend = TRUE)})
  
  output$tableplot1<-renderPlot({
    tabplot::tableplot(catsdata, sortcol="row", decreasing=FALSE, 
                       title="Tabplot of Categorical Data")
  })
  
  # subset - numerical variables
  output$SummaryB1 <- renderUI({
    print(summarytools::dfSummary(numsdata, varnumbers=TRUE, graph.magnif=0.8),
          method="render",
          heading=FALSE,
          bootstrap.css=FALSE)
  })
  
  output$numsdata <- DT::renderDataTable({DT::datatable(data = numsdata)})
  
  output$Boxplot <- renderPlot({
    data <- as.matrix(numsdata)
    data <- scale(data, center = input$standardise, scale = input$standardise)
    car::Boxplot(y = data, ylab = NA, use.cols = TRUE, notch = FALSE, varwidth = FALSE,  
                 horizontal = FALSE, outline = input$outliers, 
                 col = brewer.pal(n = dim(numsdata)[2], name = "RdBu"),
                 range = input$range, main = "Boxplots of Numeric Data", 
                 id = ifelse(input$outliers, list(n = Inf, location = "avoid"), FALSE))})
  
  output$Corrgram <- renderPlot({
    corrgram(numsdata, 
             order = input$Group, 
             abs = input$abs, 
             cor.method = input$CorrMeth,
             text.panel = panel.txt,
             main = "Correlation of Numeric Data")
  })
  
  output$Rising <- renderPlot({
    d <- numsdata
    #setToNA <- d[,"Y"] > -3.8 & d[,"Y"] < 20.3      #for standardise
    #d[setToNA, "Y"] <- NA
    for (col in 1:ncol(d)){
      d[,col] <- d[order(d[,col]),col]    #sort each columnin asceding order
    }
    d <- scale(x=d, center=TRUE, scale=TRUE)
    mypalette <- rainbow(ncol(d))
    matplot(x = seq(1, 100, length.out = nrow(d)), y = d, 
            type = "l", xlab = "Percentile (%)", ylab = "Values", 
            lty = 1, lwd = 1, col = mypalette, main = "Rising Value Chart")
    legend(legend = colnames(d), x = "bottom",  
           lty = 1, lwd = 1, cex=0.65, col = mypalette, ncol = 5)
  })
  
  output$tableplot2<-renderPlot({
    tabplot::tableplot(dat2, sortcol="row", decreasing=FALSE, title="Tabplot of Numeric Data")
  })
  
  # Full data
  output$SummaryC1 <- renderPrint({str(dat)})
  
  output$SummaryC2 <- renderPrint(summary(dat))
  
  output$dat <- DT::renderDataTable({DT::datatable(data = dat)})
  
  output$Missing <- renderPlot({
    vis_miss(dat, cluster = input$cluster) + 
      labs(title = "Missingness of Data")
  })
  
  output$Pairs1 <- renderPlot({
    GGally::ggpairs(data = dat3, title = "Pairs of All Variables")
  })
  
  output$Pairs2 <- renderPlot({
    GGally::ggpairs(data = dat4, title = "Pairs of  Important Variables",
                    progress=FALSE, mapping=aes(colour=Price))
  })
  
  output$MixedPairs <- renderPlot({
    median_survey1to10 <- rowMedians(as.matrix(dat[,15:24]))
    median_survey11to20 <- rowMedians(as.matrix(dat[,25:34]))
    median_survey21to30 <- rowMedians(as.matrix(dat[,35:44]))
    cat_cols <- c(input$VariablesD)
    num_cols <- c(input$VariablesE)
    colour_1 <- c(input$VariablesF)
    data_num <- data.frame( dat[,15:44], dat$Y, median_survey1to10, median_survey11to20, median_survey21to30)
    colnames(data_num) <- c(choicesC)
    data_mixed <- data.frame(dat[,cat_cols], data_num[,num_cols])
    GGally::ggpairs(data = data_mixed,  mapping = ggplot2::aes(colour = dat[,colour_1]), 
                    columnLabels = c(cat_cols, num_cols), 
                    title = "Pairs of Assignment 1 data")
  })
  
})  
 