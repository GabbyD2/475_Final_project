
ui <- fluidPage(
  
  dashboardPage(
    
    dashboardHeader(title = '475 Final'),
    
    dashboardSidebar(
      sidebarMenu(
        menuItem("Overview", tabName = "overview", icon = icon("dashboard")),
        menuItem("Time series", tabName = "time_series", icon = icon("th")),
        menuItem("Forecasting", tabName = "forecasting", icon = icon("chart-line"))
      )
    ),
    
    dashboardBody(
      tabItems(
        
        #overview tab
        tabItem(tabName = 'overview',
                h1('Dungeons and Dragons time series analysis'),
                h2('Gabrielle Doty'),
                h3('In order to use this application, go to the Time Series tab to see the historic google search trends for the term Dungeons and Dragons.'),
                h3('In that tab you will be able to view the time series graph, as well as select a date range to view the data in. You will also be able to select different time series graphsbreaking down the data.'),
                h3('The last tab shows multiple forecasting options.')
        ),
        
        #time series tab
        tabItem(tabName = 'time_series',
                h1('Historic time series patterns of google searches'),
                fluidRow(
                  box(plotOutput('ts_plot')),
                  
                  box(plotOutput('ts_plot2')),
                  
                  box(dateRangeInput(
                    inputId = 'Selected_date_range',
                    label = 'Select date range',
                    min = min(g_trends$Month),
                    max = max(g_trends$Month),
                    start = min(g_trends$Month),
                    end = max(g_trends$Month)
                  ),solidHeader = TRUE, status = 'primary', title = 'Date range'),
                  
                  box(radioButtons("radio", label = h3("Choose time series graph"),
                                   choices = list("seasonality" = 1, "seasonality subseries" = 2, "autocorrelation" = 3, "decomposition" = 4), 
                                   selected = 1),solidHeader = TRUE, status = 'primary', title = 'Time series graph'),
                  
                  box(verbatimTextOutput('textout'),title = 'Interpretation', width = 12, solidHeader = TRUE, status = 'primary')
                  
                )
        ),
        
        #forecasting
        tabItem(tabName = 'forecasting',
                h1('Forecasting option of Dungeons and Dragons google search trends'),
                fluidRow(
                  column(4,h2('Select which forecasting models you would like to see'),
                         fluidRow(column(4,h3('Simple models'))),
                         fluidRow(column(4, checkboxInput("naive_model", label = "Naive model", value = TRUE))),
                         fluidRow(column(4, checkboxInput("snaive_model", label = "Seasonal Naive model", value = FALSE))),
                         fluidRow(column(4, checkboxInput("mean_model", label = "Mean model", value = FALSE))),
                         fluidRow(column(4, checkboxInput("drift_model", label = "Drift model", value = FALSE))),
                         hr(),
                         fluidRow(column(4,h3('Exponential Smoothing Models'))),
                         fluidRow(column(4, checkboxInput("holts_model", label = "ETS Holt's model", value = TRUE))),
                         fluidRow(column(4, checkboxInput("holts_winter_model", label = "ETS Holt's & Winter's model", value = FALSE))),
                         hr(),
                         fluidRow(column(4,h3('ARIMA Models'))),
                         fluidRow(column(4, checkboxInput("ARIMA_Auto", label = "Auto selected ARIMA", value = TRUE))),
                         fluidRow(column(4, checkboxInput("ARIMA_man", label = "Manual ARIMA", value = FALSE))),
                        conditionalPanel("input.ARIMA_man",
                                     h4('Input values for ARIMA model'),
                                         fluidRow(column(2,
                                              numericInput("p", label = h4("p"), value = 1),
                                              numericInput("d", label = h4("d"), value = 1),
                                              numericInput("q", label = h4("q"), value = 0)),
                                          column(2,
                                              numericInput("P2", label = h4("P"), value = 1),
                                              numericInput("D2", label = h4("D"), value = 1),
                                              numericInput("Q2", label = h4("Q"), value = 0)))
                                         ),
                        sliderInput("horizon", label = h3("Select how far out you wish to see forecasted"), min = 12, 
                                    max = 60, value = 24)
                         ),
                  #box(plotOutput('ts_plot3'))
                  column( 8,
                  #simple models        
                  conditionalPanel( "input.naive_model",
                                    box(plotOutput('ts_plot_naive'),h5('Naive model'))),
                  conditionalPanel( "input.snaive_model",
                                     box(plotOutput('ts_plot_snaive'),h5('Seasonal Naive model'))),
                  conditionalPanel( "input.mean_model",
                                     box(plotOutput('ts_plot_mean_model'),h5('Mean model'))),
                  conditionalPanel( "input.drift_model",
                                    box(plotOutput('ts_plot_drift_model'),h5('Drift model'))),
                  #ets models
                  conditionalPanel( "input.holts_model",
                                     box(plotOutput('ts_plot_ets_holt'),h5("ETS Holt's model"))),
                  conditionalPanel( "input.holts_winter_model",
                                    box(plotOutput('ts_plot_ets_holt_winter'),h5("ETS Holt's & Winter's model"))),
                  #arima models
                  conditionalPanel( "input.ARIMA_Auto",
                                    box(plotOutput('ts_plot_arima_auto'),h5('Auto selected ARIMA'))),
                  conditionalPanel( "input.ARIMA_man",
                                    box(plotOutput('ts_plot_arima_man'),h5('Manual ARIMA'))),
                  
                  )
              )
        )
      )
    )
  )
)


