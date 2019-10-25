#
# This is a Shiny web application. You can run the application by clicking
# the 'Run App' button above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)
library(ggmap)
library(maptools)
library(maps)

mapWorld <- map_data("world")

map1 <- ggplot(mapWorld, aes(x=long, y=lat, group=group))+
    geom_polygon(fill="white", color="black") +
    coord_map(xlim=c(-180,180), ylim=c(-60, 90))

projections <- c("cylindrical", "mercator", "sinusoidal", "gnomonic", "rectangular", "cylequalarea", "cylindrical")


# Define UI for application that draws a histogram
ui <- fluidPage(

    # Application title
    titlePanel("World Map With Different Projections"),

    # Sidebar with a slider input for number of bins 
    sidebarLayout(
        sidebarPanel(
            selectInput("projections",
                        "Please select the projection:",
                        projections)
        ),

        # Show a plot of the generated distribution
        mainPanel(
           plotOutput(outputId = "projections")
        )
    )
)

# Define server logic required to draw a histogram
server <- function(input, output, session) {

    output$projections <- renderPlot({
        # generate bins based on input$bins from ui.R
        map1 + coord_map(input$projections,xlim=c(-180,180), ylim=c(-60, 90))
    })
}

# Run the application 
shinyApp(ui = ui, server = server)
