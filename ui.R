library(shiny)

shinyUI(fluidPage(

  
  navbarPage("StockOptim",
    tabPanel("Stock1",
      sidebarPanel(
      helpText("Select a stock to examine. 
        Information will be collected from yahoo finance."),
    
      textInput("symb1", "Symbol", "NFLX"),
    
      dateRangeInput("dates1", 
        "Date range",
        start = "2014-01-01", 
        end = as.character(Sys.Date())),
   
      submitButton("Get Stock"),

      br(),
      
      checkboxInput("log1", "Plot y axis on log scale", 
        value = FALSE),
      
      selectInput("type1", label = "Chart Type", 
                  choices = list("BarChart" = "bars", "Candlesticks" = "candlesticks"
                                 , "Line" = "line", "Matchsticks" = "matchsticks"), 
                  selected = "line"),
      
      selectInput("theme1", label = "Chart Theme", 
                  choices = list("White" = "white", "White2" = "white.mono",
                                 "Black" = "black", "Black2" = "black.mono"
                                 , "Beige" = "beige", "WSJ" = "wsj"
                                 ), 
                  selected = "white"),

      checkboxGroupInput("TA1",label = "Indicators",
                         choices = list("EMA10" = "addEMA(10)",
                                        "EMA50" = "addEMA(50)",
                                        "Volume" = "addVo()",
                                        "MACD" = "addMACD()",
                                        "Bolligner Bands" = "addBBands()",
                                        "Momentum" = "addMomentum()",
                                        "Williams%" = "addWPR()",
                                        "Stop&Reverse" = "addSAR()",
                                        "Stochastic" = "addSMI()",
                                        "RSI" = "addRSI()"
                                        ),
                         selected = "addVo()")

      ),
      mainPanel(plotOutput("plot1"))
    ),
    
    
    tabPanel("Stock2",
             sidebarPanel(
               helpText("Select a stock to examine. 
        Information will be collected from yahoo finance."),
               
               textInput("symb2", "Symbol", "YHOO"),
               
               dateRangeInput("dates2", 
                              "Date range",
                              start = "2014-01-01", 
                              end = as.character(Sys.Date())),
               
               submitButton("Get Stock"),
               
               br(),
               br(),
               
               checkboxInput("log2", "Plot y axis on log scale", 
                             value = FALSE),

              selectInput("type2", label = "Chart Type", 
                          choices = list("BarChart" = "bars", "Candlesticks" = "candlesticks"
                                         , "Line" = "line", "Matchsticks" = "matchsticks"), 
                          selected = "line"),
              
              selectInput("theme2", label = "Chart Theme", 
                          choices = list("White" = "white", "White2" = "white.mono",
                                         "Black" = "black", "Black2" = "black.mono"
                                         , "Beige" = "beige", "WSJ" = "wsj"
                          ), 
                          selected = "white"),
              
              checkboxGroupInput("TA2",label = "Indicators",
                                 choices = list("EMA10" = "addEMA(10)",
                                                "EMA50" = "addEMA(50)",
                                                "Volume" = "addVo()",
                                                "MACD" = "addMACD()",
                                                "Bolligner Bands" = "addBBands()",
                                                "Momentum" = "addMomentum()",
                                                "Williams%" = "addWPR()",
                                                "Stop&Reverse" = "addSAR()",
                                                "Stochastic" = "addSMI()",
                                                "RSI" = "addRSI()"
                   ),
                   selected = "addVo()")
             ),
             mainPanel(plotOutput("plot2"))
          ),  
    
    
    tabPanel("Stock3",
             sidebarPanel(
               helpText("Select a stock to examine. 
        Information will be collected from yahoo finance."),
               
               textInput("symb3", "Symbol", "EBAY"),
               
               dateRangeInput("dates3", 
                              "Date range",
                              start = "2014-01-01", 
                              end = as.character(Sys.Date())),
               
               submitButton("Get Stock"),
               
               br(),
               br(),
               
               checkboxInput("log3", "Plot y axis on log scale", 
                             value = FALSE),
              
              selectInput("type3", label = "Chart Type", 
                          choices = list("BarChart" = "bars", "Candlesticks" = "candlesticks"
                                         , "Line" = "line", "Matchsticks" = "matchsticks"), 
                          selected = "line"),
              
              selectInput("theme3", label = "Chart Theme", 
                          choices = list("White" = "white", "White2" = "white.mono",
                                         "Black" = "black", "Black2" = "black.mono"
                                         , "Beige" = "beige", "WSJ" = "wsj"
                          ), 
                          selected = "white"),
              
              checkboxGroupInput("TA3",label = "Indicators",
                                 choices = list("EMA10" = "addEMA(10)",
                                                "EMA50" = "addEMA(50)",
                                                "Volume" = "addVo()",
                                                "MACD" = "addMACD()",
                                                "Bolligner Bands" = "addBBands()",
                                                "Momentum" = "addMomentum()",
                                                "Williams%" = "addWPR()",
                                                "Stop&Reverse" = "addSAR()",
                                                "Stochastic" = "addSMI()",
                                                "RSI" = "addRSI()"
                   ),
                   selected = "addVo()")
             ),
             mainPanel(plotOutput("plot3"))
          ),
     
    tabPanel("PortOpt",
             sidebarPanel(
               helpText("Select three stock to calculate effective frontier"),
               
               br(),
               
               textInput("symb4", "Symbol1", "SPY"),
               textInput("symb5", "Symbol2", "QQQ"),
               textInput("symb6", "Symbol3", "TLT"),
                   
               
               br(),
               
               dateRangeInput("dates4", 
                              "Date range",
                              start = "2012-01-01", 
                              end = as.character(Sys.Date())),
               br(),
               sliderInput("minmax", label =  "Constraint for for total net position (as % of portfolio)",
                           min = -1,
                           max = 3,
                           value = c(0.9,1.1),
                           step = 0.01),
               
               sliderInput("minmaxasset", label = "Constraint for position on single asset",
                           min = -1,
                           max = 1,
                           value = c(-0.5,0.7),
                           step = 0.01),
               
               numericInput("ret", label = "Target daily return",value = 0.0008),
               
               numericInput("std", label = "Target daily STD",value = 0.005),
               sliderInput("sim", label =  "Total number of Simulations",
                           min = 100,
                           max = 20000,
                           value = 1000,
                           step = 500)
               ),
             mainPanel(plotOutput("plot4"))
             ),
    
        tabPanel("Help",mainPanel("
#             Name of my application: stockVis app.
#             Its created from tutorial 6 on shiny.rstudio.com.
#             Three pages are created for technical analysis of different stocks.
#             Last page creates optimal portfolio using PortfolioAnalytics package.
#             Last page is devoted to simple portfolio optimiser of three stocks. Different constraints and number of simulations can be choosen by user. The portfolio optimiser use past performance in selected date range of three selected stock. Ouptut is figure with mean-variance chart and weights for selected stock of optimal portfolio and closest neighbors.
                                          ")
                )
    
  )
))