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
  
  # Update the country selection based on the continent chosen
  output$countrySelection <- renderUI({
    selectInput("country", 
                label = "Select a country", 
                choices = selected_countries(), 
                selected = selected_countries()[1]) # Set a default country
  })
  
  output$GDPPlot <- renderPlot({
    gdp_le |>
      filter(Country == input$country) |>
      ggplot(aes(x=Year, y=GDP_Per_capita)) + geom_point() +
      labs(x = 'GDP per capita by Year', title = paste("GDP per capita by Year for", input$country))
  })
  
  output$LifeExpectancyPlot <- renderPlot({
    gdp_le |>
      filter(Country == input$country) |>
      ggplot(aes(x=Year, y=Life_Expectancy)) + geom_point() +
      labs(x = 'Life Expectancy by Year', title = paste("Life Expectancy by Year for", input$country))
  })
  
}
