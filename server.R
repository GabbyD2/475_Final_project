
server <- function(input, output){
  output$ts_plot <- renderPlot({ 
    
    min_date <- input$Selected_date_range[1]
    max_date <- input$Selected_date_range[2]
    
    plot_df <- g_trends[,c('Month','Interest')]
    
    plot_df <- plot_df[plot_df$Month >= min_date,]
    plot_df <- plot_df[plot_df$Month <= max_date,]
    
    autoplot(plot_df, .vars = Interest)
  })
  output$ts_plot2 <- renderPlot({
    
    if(input$radio == '1'){
      gg_season(g_trends, Interest)
    } else
      if(input$radio == '2'){
        gg_subseries(g_trends, Interest)
      } else
        if(input$radio == '3'){
          g_trends %>% 
            ACF(Interest) %>% 
            autoplot()
        } else
          if(input$radio == '4'){
            g_trends %>% 
              model(X_13ARIMA_SEATS(Interest~seats())) %>% 
              components() %>% 
              autoplot()
          } 
    
  })
  output$textout <- renderText({
    
    if(input$radio == '1'){
      'There does not appear to be much seasonality with the search trends for dungeons and dragons'
    } else
      if(input$radio == '2'){
        'There does not appear to be much seasonality with the search trends for dungeons and dragons'
      } else
        if(input$radio == '3'){
          'The search trend data for dungeons and dragons has strong autocorreltion. With the highest predictor being the previous months searches.'
        } else
          if(input$radio == '4'){
            'The search trend for dungeons and dragons has a positive trend upwards, and does not have consistent seasonality trends.'
          } 
    
  })
  
  # output$ts_plot3 <- renderPlot({
  #   fit <- g_trends %>%
  #     model(TSLM(Interest ~ trend()))
  #   
  #   fit %>% 
  #     forecast() %>% 
  #     autoplot(g_trends)
  # })

#simple models 
  output$ts_plot_naive <- renderPlot({ 
    if(input$naive_model){
      fit <- g_trends %>%
        model(NAIVE(Interest))
      
      fit %>% 
        forecast(h = input$horizon) %>% 
        autoplot(g_trends)
    }
 })

  output$ts_plot_snaive <- renderPlot({ 
    if(input$snaive_model){
      fit <- g_trends %>%
        model(SNAIVE(Interest ~ lag()))
      
      fit %>% 
        forecast(h = input$horizon) %>% 
        autoplot(g_trends)
    }
  })
  
  output$ts_plot_mean_model <- renderPlot({ 
    if(input$mean_model){
      fit <- g_trends %>%
        model(MEAN(Interest))
      
      fit %>% 
        forecast(h = input$horizon) %>% 
        autoplot(g_trends)
    }
  })
  
  output$ts_plot_drift_model <- renderPlot({ 
    if(input$drift_model){
      fit <- g_trends %>%
        model(RW(Interest ~ drift()))
      
      fit %>% 
        forecast(h = input$horizon) %>% 
        autoplot(g_trends)
    }
  })

#ETS models
  output$ts_plot_ets_holt <- renderPlot({ 
    if(input$holts_model){
      fit <- g_trends %>%
        model(ETS(Interest ~ error("A") + trend("A") + season("N")))
      
      fit %>% 
        forecast(h = input$horizon) %>% 
        autoplot(g_trends)
    }
  })
  
  output$ts_plot_ets_holt_winter <- renderPlot({ 
    if(input$holts_winter_model){
      fit <- g_trends %>%
        model(ETS(Interest ~ error("A") + trend("A") + season("A")))
      
      fit %>% 
        forecast(h = input$horizon) %>% 
        autoplot(g_trends)
    }
  })
  
#arima models
  
  output$ts_plot_arima_auto <- renderPlot({ 
    if(input$ARIMA_Auto){
      fit <- g_trends %>%
        model(ARIMA(Interest))
      
      fit %>% 
        forecast(h = input$horizon) %>% 
        autoplot(g_trends)
    }
  })
  
  output$ts_plot_arima_man <- renderPlot({ 
    if(input$ARIMA_man){
      fit <- g_trends %>%
        model(ARIMA(Interest ~ pdq(1,1,0) + PDQ(1,1,0)))
      
      fit %>% 
        forecast(h = input$horizon) %>% 
        autoplot(g_trends)
    }
  })
   
}
