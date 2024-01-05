library(shiny)

# Define server logic required to draw a histogram
function(input, output, session) {
  
  output$distPlot <- renderPlot({
    gdp_le |>
      filter(Country == "India") |>
      ggplot(aes(x=Year, y=GDP_Per_capita)) + geom_point() +
      labs(x = 'GDP per capita by Year')
  })
  
}
