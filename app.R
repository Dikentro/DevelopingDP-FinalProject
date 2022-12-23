library(shiny)
library(maps)


# Define UI for application that draws a map
ui <- fluidPage(
        titlePanel("Ethnicities % USA counties"),
        sidebarLayout(
                sidebarPanel(
                        helpText("Create demographic maps with information from the 2010 US Census."),
                        selectInput("var", 
                                    label = "Choose a variable to display",
                                    choices = c("Percent White", "Percent Black", "Percent Hispanic", "Percent Asian"),
                                    selected = "Percent White"),
                        sliderInput("range", 
                                    label = "Range of interest:",
                                    min = 0, max = 100, value = c(0, 100))
                ),
                mainPanel(plotOutput("map"))
        )
)

# Define server logic required to draw a map
server <- function(input, output) {
        output$map <- renderPlot({
                countries2 <- switch(input$var, 
                                     "Percent White" = countries$white,
                                     "Percent Black" = countries$black,
                                     "Percent Hispanic" = countries$hispanic,
                                     "Percent Asian" = countries$asian)
                
                percent_map(var = countries2, color = "brown", legend.title = "Ethnicity % of USA counties", max = 100, min = 0)
        })
}

# Run the application 
shinyApp(ui, server)
