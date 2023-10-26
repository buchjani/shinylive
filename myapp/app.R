#
# Shiny app for testing shinylive (i.e.: deploying Shiny app on Github Pages)
#

# features of my Shiny app that I want to check:
# - some fancy html formating (colors, font size...)
# - loading data (.RDS) from within the app
# - include an image file from within the app
# - interactive features: subsetting dataframe via shiny input
# - include DT::datatable() object with some conditional formating (significance)
# - csv file export

library(shiny)
# library(DT)
# df31 <- readRDS('data/BT2021-Tab3.1web.RDS')


# Define UI for application that draws a histogram
ui <- fluidPage(

    # Application title
    titlePanel("Deploying my Shiny app on Github Pages"),

    # Sidebar with a slider input for number of bins 
    sidebarLayout(
        sidebarPanel(
            sliderInput("bins",
                        "Number of bins:",
                        min = 1,
                        max = 50,
                        value = 30)
        ),

        # Show a plot of the generated distribution
        mainPanel(
           plotOutput("distPlot"),
             tableOutput('table')
           
        )
    )
)

# Define server logic required to draw a histogram
server <- function(input, output) {

    output$table <- renderTable(iris)
      
    # output$distPlot <- renderPlot({
    #     # generate bins based on input$bins from ui.R
    #     x    <- faithful[, 2]
    #     bins <- seq(min(x), max(x), length.out = input$bins + 1)
    # 
    #     # draw the histogram with the specified number of bins
    #     hist(x, breaks = bins, col = 'darkgray', border = 'white',
    #          xlab = 'Waiting time to next eruption (in mins)',
    #          main = 'Histogram of waiting times')
    # })
}

# Run the application 
shinyApp(ui = ui, server = server)
