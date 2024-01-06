#
# This is the user-interface definition of a Shiny web application. You can
# run the application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)

selected_countries = reactive({
  gdp_le |> 
    filter(Continent == input$continent) |>
    pull(Country) |>
    unique() |>
    sort()})

# Define UI for application that draws a histogram
shinyUI(
  navbarPage("GDP/Life Expectancy Dashboard",
             tabPanel(
               "Countries",
               sidebarLayout(
                 sidebarPanel(
                   selectInput("continent", 
                               label = "Select a Continent", 
                               choices = continents, 
                               selected = continents[0]),
                   uiOutput("countrySelection"), # Dynamic UI for country selection
                 ),
                 # GDP plot for country
                 mainPanel(
                   tabsetPanel(
                     tabPanel("GDP", plotOutput("GDPPlot")), 
                     tabPanel("Life Expectancy", plotOutput("LifeExpectancyPlot"))
                   )
                   
                 )
               )
             ),
             tabPanel("Component 2", 
                      sidebarLayout(
                        
                        # Sidebar with a slider input
                        sidebarPanel(
                          sliderInput("obs",
                                      "Number of observations:",
                                      min = 0,
                                      max = 1000,
                                      value = 500)
                        ),
                        
                        # Show a plot of the generated distribution
                        mainPanel(
                          plotOutput("GDP_vs_LE_plot")
                        )
                      )
                      ),
             tabPanel("Component 3")
  )
)
