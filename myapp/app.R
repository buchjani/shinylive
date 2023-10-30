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
library(DT)
library(cranlogs)
library(lubridate)
library(dplyr)

# test for one package
cran_downloads(when = "last-week", packages = c("eatATA"))
dl <- cran_downloads(when = "last-month", packages = c("eatATA")) 
dl %>% 
  mutate(Month=month(date)) %>% 
  group_by(Month) %>% 
  summarise(downloads=sum(count,na.rm=T)) %>% t()

# loop across all eat Packages
eat_packages <- c('eatATA', 'eatDB', 'eatGADS', 'eatRep', 'eatTools')
eat_downloads <- NULL
for (p in eat_packages){
  dl <- cran_downloads(from = "2023-01-01", to = "last-day", packages = p) 
  dl %>% 
    mutate(Month=month(date)) %>% 
    group_by(Month) %>% 
    summarise(downloads=sum(count,na.rm=T)) %>% 
    # pull(downloads) %>%
    rename(!!p := downloads) %>%  
    select(!!p) %>% 
    t() %>% 
    as.data.frame() %>% 
    setNames(paste0(1:10, "/2023")) %>% 
    mutate(`Gesamt 2023` = rowSums(across(where(is.numeric)))) %>% 
    rbind.data.frame(eat_downloads) -> eat_downloads
}



# Define UI for application that draws a histogram
ui <- fluidPage(
  
  # Application title
  # titlePanel("Meine Shiny App via shinylive"),
  titlePanel(fluidRow(column(11, 'Meine Shiny App via shinylive'),
                      column(1,HTML("<a href='https://www.iqb.hu-berlin.de'>",
                                    "<img src='iqb-logo.jpg', height=80, style = 'float:right;'/></a>")))),

  # Sidebar with a slider input for number of bins 
  sidebarLayout(
    sidebarPanel(width=2,
      sliderInput("bins",
                  "Number of bins:",
                  min = 1,
                  max = 50,
                  value = 30)
    ),
    
    # Show a plot of the generated distribution
    mainPanel(
      titlePanel('Downloadzahlen für die eat* Packages 2023'),
      dataTableOutput("downloadTabelle")
    )
  )
)

# Define server logic required to draw a histogram
server <- function(input, output) {
  
  src = "https://www.iqb.hu-berlin.de/system/img/logo_IQB.png"
  output$picture<-renderText({c('<img src="',src,'">')})

  # output$disttable <- renderTable({faithful})

  output$downloadTabelle <- renderDataTable({
    datatable(eat_downloads)
    })
  # output$distPlot <- renderPlot({
  #   # generate bins based on input$bins from ui.R
  #   x    <- faithful[, 2]
  #   bins <- seq(min(x), max(x), length.out = input$bins + 1)
  # 
  #   # draw the histogram with the specified number of bins
  #   hist(x, breaks = bins, col = 'darkgray', border = 'white',
  #        xlab = 'Waiting time to next eruption (in mins)',
  #        main = 'Histogram of waiting times')
  # })
}

# Run the application 
shinyApp(ui = ui, server = server)
