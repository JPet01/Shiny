# server.R

library(quantmod)
library(PortfolioAnalytics)

shinyServer(function(input, output) {

  data1 <- reactive({

    getSymbols(input$symb1, src = "yahoo", 
                  from = input$dates1[1],
                  to = input$dates1[2],
                  auto.assign = FALSE)
  })
  
  output$plot1 <- renderPlot({    
                
    chartSeries(data1(), theme = chartTheme(input$theme1), 
      type = input$type1, log.scale = input$log1
      , TA = paste(input$TA1, collapse = ";")
      ,name = input$symb1)
  }, heigh = 800)
  
  data2 <- reactive({

    getSymbols(input$symb2, src = "yahoo", 
               from = input$dates2[1],
               to = input$dates2[2],
               auto.assign = FALSE)
  })
  
  output$plot2 <- renderPlot({

    chartSeries(data2(), theme = chartTheme(input$theme2), 
                type = input$type2, log.scale = input$log2
                ,TA = paste(input$TA2, collapse = ";")
                ,name = input$symb2)
  }, heigh = 800)
  
  data3 <- reactive({

    getSymbols(input$symb3, src = "yahoo", 
               from = input$dates3[1],
               to = input$dates3[2],
               auto.assign = FALSE)
  })
  
  output$plot3 <- renderPlot({
 
    chartSeries(data3(), theme = chartTheme(input$theme3), 
                type = input$type3, log.scale = input$log3
                ,TA = paste(input$TA3, collapse = ";")
                ,name = input$symb3)
  }, heigh = 800)
  
  #####################-----Port Data  
  
  dataInput4 <- reactive({
    
    data4 <- getSymbols(input$symb4, src = "yahoo", 
                        from = input$dates3[1],
                        to = input$dates3[2],
                        auto.assign = FALSE)
    data5 <- getSymbols(input$symb5, src = "yahoo", 
                        from = input$dates3[1],
                        to = input$dates3[2],
                        auto.assign = FALSE)  
    data6 <- getSymbols(input$symb6, src = "yahoo", 
                        from = input$dates3[1],
                        to = input$dates3[2],
                        auto.assign = FALSE)  
    
    data7 <- cbind(Delt(data4[,6]),Delt(data5[,6]),Delt(data6[,6]))
    
    data7 <- data7[-1]
    
    colnames(data7) <- c(input$symb4, input$symb5, input$symb6)
    
    return(data7)
 
    #############-----------------Port Opt
  })
  
  output$plot4 <- renderPlot({
    
    portf.dn = NULL
    
    portf.dn <- portfolio.spec(colnames(dataInput4()))
    
    portf.dn <- add.constraint(portf.dn, type="weight_sum",
                               min_sum=input$minmax[1], max_sum=input$minmax[2])
    
    portf.dn <- add.constraint(portf.dn, type="box"
                               ,min=input$minmaxasset[1]
                               ,max=input$minmaxasset[2])
    
    portf.dn <- add.constraint(portf.dn, type="position_limit", max_pos=3)
    
    portf.dn.StdDev <- add.objective(portf.dn, type="return", name="mean",
                                     target=input$ret)
    
    portf.dn.StdDev <- add.objective(portf.dn.StdDev, type="risk", name="StdDev",
                                     target=input$std)
    rp <- NULL    
    rp <- random_portfolios(portf.dn, input$sim, "sample", eliminate = TRUE)
    
    opt.dn <- NULL
    opt.dn <- optimize.portfolio(dataInput4(), portf.dn.StdDev,
                                 optimize_method="random", rp=rp,
                                 trace=TRUE)
    
    plot(opt.dn, main="Optimised Portfolio", risk.col="StdDev", neighbors=10)
    
   
  },heigh = 700, width = 700)
  
})