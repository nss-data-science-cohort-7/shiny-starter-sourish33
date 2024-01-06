library(shiny)

# Define server logic required to draw a histogram
function(input, output, session) {
  # Define selected_countries as a reactive function
  selected_countries <- reactive({
    #req(input$continent) # Make sure input$continent is available
    
    # Filter countries based on selected continent
    gdp_le %>%
      filter(Continent == input$continent) %>%
      pull(Country) %>%
      unique() %>%
      sort()
  })
  correlation <- reactive({
    filtered <- gdp_le |>
      filter(Year == input$year)
    cor(filtered$GDP_Per_capita, filtered$Life_Expectancy)
  }
  )
  
  # Update the country selection based on the continent chosen
  output$countrySelection <- renderUI({
    selectInput(
      "country",
      label = "Select a country",
      choices = selected_countries(),
      selected = selected_countries()[1]
    ) # Set a default country
  })
  
  output$GDPPlot <- renderPlot({
    gdp_le |>
      filter(Country == input$country) |>
      ggplot(aes(x = Year, y = GDP_Per_capita)) + geom_point() +
      labs(x = 'Year',
           title = paste("GDP per capita by Year for", input$country)) +
      theme(plot.title = element_text(hjust = 0.5))
  })
  
  output$LifeExpectancyPlot <- renderPlot({
    gdp_le |>
      filter(Country == input$country) |>
      ggplot(aes(x = Year, y = Life_Expectancy)) + geom_point() +
      labs(x = 'Year',
           title = paste("Life Expectancy by Year for", input$country)) +
      theme(plot.title = element_text(hjust = 0.5))
  })
  
  output$GDP_vs_LE_plot <- renderPlot({
    gdp_le |>
      filter(Year == input$year) |>
      ggplot(aes(x = GDP_Per_capita, y = Life_Expectancy)) + geom_point() +
      geom_text(
        aes(x = Inf, y = -Inf, 
            label = paste("Corr:", round(correlation(), 2))),
        hjust = 1, vjust = 0, size = 5
      )
  })
  
  output$Log_GDP_vs_LE_plot <- renderPlot({
    gdp_le |>
      filter(Year == input$year) |>
      ggplot(aes(x = Log_GDP_Per_capita, y = Life_Expectancy)) + geom_point() + 
      geom_smooth(method = "lm", se = FALSE) + 
      labs(x = 'Log GDP per capita', y = 'Life Expectancy') +
      geom_text(
        aes(x = Inf, y = -Inf, 
            label = paste("Corr:", round(correlation(), 2))),
        hjust = 1, vjust = 0, size = 5
      )
  })
  
}
