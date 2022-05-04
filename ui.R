
ui <- fluidPage(
  
  dashboardPage(
    
    dashboardHeader(title = '475 Midterm'),
    
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
                h2('Dungeons and Dragons time series analysis'),
                h3('In order to use this application, go to the Time Series tab to see the google search trends for the term Dungeons and Dragons.'),
                h3('In that tab you will be able to view the time series graph, as well as select a date range to view the data in. You will also be able to select different time series graphsbreaking down the data.'),
                h3('The last tab shows a simple forecast of the search trend using the trend.')
        ),
        
        #time series tab
        tabItem(tabName = 'time_series',
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
                h2('A simple forecast of dungeons and dragons google search trends using its trend'),
                fluidPage(
                  box(plotOutput('ts_plot3'))
                )
        )
      )
    )
  )
)
