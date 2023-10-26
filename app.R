#        /$$$$$$$  /$$$$$$$$       /$$$$$$$$        /$$                 /$$ /$$                    
#       | $$__  $$|__  $$__/      |__  $$__/       | $$                | $$| $$                    
#       | $$  \ $$   | $$            | $$  /$$$$$$ | $$$$$$$   /$$$$$$ | $$| $$  /$$$$$$  /$$$$$$$ 
#       | $$$$$$$    | $$            | $$ |____  $$| $$__  $$ /$$__  $$| $$| $$ /$$__  $$| $$__  $$
#       | $$__  $$   | $$            | $$  /$$$$$$$| $$  \ $$| $$$$$$$$| $$| $$| $$$$$$$$| $$  \ $$
#       | $$  \ $$   | $$            | $$ /$$__  $$| $$  | $$| $$_____/| $$| $$| $$_____/| $$  | $$
#       | $$$$$$$/   | $$            | $$|  $$$$$$$| $$$$$$$/|  $$$$$$$| $$| $$|  $$$$$$$| $$  | $$
#       |_______/    |__/            |__/ \_______/|_______/  \_______/|__/|__/ \_______/|__/  |__/



### TO DO 
# Dinge, die ich als nächstes noch einbauen möchte:
# 
# - Formatierung nach Signifikanz --> sig helper function
# - besseres kable Beispiel
# - Fußnoten übernehmen für Erkärung von a und wegen fett
# - Idee: "Anmerkdungen" kann verwendet werden um (a) Ende der Tab. zu bestimmen 
#   und (b) evtl, Anmerkungen unter die Tabelle zu schreiben
# - evtl. formattable
# - versuchen, das ganze auf githubpages zu hosten
# 
###

# setup

library(shiny)
library(shinydashboard)
library(DT)
library(dplyr)
library(formattable)
library(kableExtra)

# data

df31 <- readRDS('data/BT2021-Tab3.1web.RDS')
df41 <- readRDS('data/BT2021-Tab4.1web.RDS')

# # needed for kable formating
# cb <- function(x) {
#   range <- max(abs(x))
#   width <- round(abs(x / range * 50), 2)
#   ifelse(
#     x > 0,
#     paste0(
#       '<span style="display: inline-block; border-radius: 2px; ', 
#       'padding-right: 2px; background-color: lightgreen; width: ', 
#       width, '%; margin-left: 50%; text-align: left;">', x, '</span>'
#     ),
#     paste0(
#       '<span style="display: inline-block; border-radius: 2px; ', 
#       'padding-right: 2px; background-color: lightpink; width: ', 
#       width, '%; margin-right: 50%; text-align: right; float: right; ">', x, '</span>'
#     )
#   )
# }


# Define UI --------------

ui <- fluidPage(
  
  # fluidRow(column(width = 12, 
  #                 style = "background-color:#E7F7F5;", 
  #                 HTML("<code>DT::datatable()</code>, Auswahl von Fällen über Shiny Input, einzelne Tabellen z.B. als Reiter möglich </br>
  #                                     ⚠️ Problem beim CSV-Datenexport: Encoding von ∆ in Variablenname (Tab. 4.1.) verursacht Probleme..."))),
  
  # titlePanel(fluidRow(column(11, htmlOutput('BT.title.dt1')),
  #                     column(1,HTML("<a href='https://www.iqb.hu-berlin.de'>",
  #                                   "<img src='iqb-logo.jpg', height=80, style = 'float:right;'/></a>")))),
  
  # tabsetPanel(
  #   id = "panels_kap",
  #   tabPanel('Inhaltsverzeichnis',
  #            HTML('<h3 style="color:rgb(198,0,0)"><b> Inhalt</h3></b>'), 
  #            
  #            HTML('<h4><b> Kapitel 3: Kompetenzstufenbesetzungen in den Ländern </h4></b>'), 
  #            actionLink("link_to_Tab.3.1", 'Tab. 3.1web: Kompetenzstufenbesetzung (Anteile in %) im Trend für den Kompetenzbereich Lesen'), p(),
  #            actionLink("link_to_Tab.3.2", 'Tab. 3.2web: Kompetenzstufenbesetzung (Anteile in %) im Trend für den Kompetenzbereich Zuhören'), p(),
  #            actionLink("link_to_Tab.3.3", 'Tab. 3.3web: Kompetenzstufenbesetzung (Anteile in %) im Trend für den Kompetenzbereich Orthografie'), p(),
  #            HTML('...'),
  #            
  #            HTML('<h4><b> Kapitel 4: Mittelwerte und Streuungen der erreichten Kompetenzen in den Ländern</h4></b>'),
  #            actionLink("link_to_Tab.4.1", 'Tab. 4.1web: Mittelwerte und Streuungen im Trend für den Kompetenzbereich Lesen'), p(),
  #            actionLink("link_to_Tab.4.2", 'Tab. 4.2web: Mittelwerte und Streuungen im Trend für den Kompetenzbereich Zuhören'), p(),
  #            actionLink("link_to_Tab.4.3", 'Tab. 4.3web: Mittelwerte und Streuungen im Trend für den Kompetenzbereich Orthografie'), p(),
  #            HTML('...'),
  #            
  #            HTML('<h4><b> Kapitel 5: Lernbedingungen im Fern- und Welchselunterricht während der Coronavirus-Pandemie</h4></b>'),
  #            HTML('...'),
  #            
  #            HTML('<h4><b> Kapitel 7: Soziale Disparitäten</h4></b>'),
  #            HTML('...'),
  #            
  #            HTML('<h4><b> Kapitel 8: Zuwanderungsbezogene Disparitäten</h4></b>'),
  #            HTML('...'),
  #            
  #            HTML('<h4><b> Kapitel 9: Motivational-emotionale Merkmale von Schüler:innen in Deutsch und Mathematik</h4></b>'),
  #            HTML('...')
  #   ),
  #   
  #   tabPanel('Kapitel 3',
  #            fluidRow(column(12, HTML('<h2>Kapitel 3: Kompetenzstufenbesetzungen in den Ländern</h2>
  #                                     Hier könnte noch ein erläuternder Text stehen. <br/>
  #                                     Man könnte auch <a href=https://www.iqb.hu-berlin.de/bt/BT2022/Bericht/>Links</a> verwenden, 
  #                                     um auf eine Webseite oder sogar ein spezifisches Kapitel im Ergebnisbericht zu verweisen. 
  #                                     Dafür müsste der Bericht allerdings per Online-Reader zugänglich gemacht werden.<br><br>'))),
  #            tabsetPanel(
  #              id = "panels_K3",
  #              tabPanel("Tab. 3.1",
  #                       titlePanel(HTML('<h3> Tab. 3.1web: </br> Kompetenzstufenbesetzung (Anteile in %) im Trend für den Kompetenzbereich Lesen')),
  #                       
  #                       sidebarLayout(
  sidebarPanel(width = 2,
               
               radioButtons('dt1_daten', label = 'Datenauswahl',
                            choices = list("Alle Länder" = 1, "Eigene Auswahl" = 2)),
               
               checkboxGroupInput('dt1_laender', 
                                  HTML('Einzelne Länder auswählen:'), 
                                  unique(df31$Land), #[-which(unique(df31$Land) == 'Deutschland')],
                                  selected = 'Deutschland'),
               
               checkboxGroupInput('dt1_kstufe', 'Kompetenzstufen', 
                                  unique(df31$Kompetenzstufen),
                                  selected = unique(df31$Kompetenzstufen),
                                  inline = TRUE)#,
               # hr(),
               # downloadButton("dt1_download_31", HTML("Aktuelle Auswahl</br> herunterladen (CSV)"),
               #                style="color: #f7f7f7; background-color: #821122")
  ),
  mainPanel(
    DTOutput('dt1_tbl_31')
  )
  #                     )
  #            )#,
  #            tabPanel('Tab. 3.2', '...'),
  #            tabPanel('Tab. 3.3', '...'),
  #            tabPanel('Tab. 3.4', '...'),
  #            tabPanel('Tab. 3.5', '...'),
  #            tabPanel('Tab. 3.6', '...'),
  #            tabPanel('Tab. 3.7', '...'),
  #            tabPanel('Tab. 3.8', '...'),
  #            tabPanel('Tab. 3.9', '...'),
  #            tabPanel('Tab. 3.10', '...'),
  #            tabPanel('Tab. 3.11', '...'),
  #            tabPanel('Tab. 3.12', '...'),
  #            tabPanel('Tab. 3.13', '...'),
  #            tabPanel('Tab. 3.14', '...'),
  #            tabPanel('Tab. 3.15', '...'),
  #            tabPanel('Tab. 3.16', '...'),
  #            tabPanel('Tab. 3.17', '...'),
  #            tabPanel('Tab. 3.18', '...')
  #          )
  # ),
  # tabPanel('Kapitel 4',
  #          fluidRow(column(12, HTML('<h2>Kapitel 4: Mittelwerte und Streuungen der erreichten Kompetenzen in den Ländern'))),
  #          tabsetPanel(
  #            id = "panels_K4",
  #            tabPanel("Tab. 4.1web",
  #                     titlePanel(HTML('<h3>Tab. 4.1web: </br> Mittelwerte und Streuungen im Trend für den Kompetenzbereich Lesen')),
  #                     sidebarLayout(
  #                       sidebarPanel(width = 2,
  #                                    radioButtons('dt2_daten', label = 'Datenauswahl',
  #                                                 choices = list("Alle Länder" = 1, "Eigene Auswahl" = 2)),
  #                                    
  #                                    checkboxGroupInput('dt2_laender', 
  #                                                       HTML('Einzelne Länder auswählen:'), 
  #                                                       unique(df31$Land), #[-which(unique(df31$Land) == 'Deutschland')],
  #                                                       selected = 'Deutschland'),
  #                                    hr(),
  #                                    downloadButton("dt1_download_41", HTML("Aktuelle Auswahl</br> herunterladen (CSV)"),
  #                                                   style="color: #f7f7f7; background-color: #821122")
  #                       ),
  #                       mainPanel(DTOutput('dt1_tbl_41'))
  #                     )
  #            ),
  #            tabPanel("Tab. 4.2web", '...'),
  #            tabPanel("Tab. 4.3web", '...'),
  #            tabPanel("...", '...')
  #          )
  # ),
  # tabPanel('Kapitel 5', '...'),
  # tabPanel('Kapitel 7', '...'),
  # tabPanel('Kapitel 8', '...'),
  # tabPanel('Kapitel 9', '...'),
)
# )

# Define server logic --------------

server <- function(input, output, session) {
  
  #### Inhaltsverzeichnis 
  
  # observeEvent(input$link_to_Tab.3.1, {updateTabsetPanel(session, "panels_kap", "Kapitel 3"); updateTabsetPanel(session, "panels_K3", "Tab. 3.1")})
  # observeEvent(input$link_to_Tab.3.2, {updateTabsetPanel(session, "panels_kap", "Kapitel 3"); updateTabsetPanel(session, "panels_K3", "Tab. 3.2")})
  # observeEvent(input$link_to_Tab.3.3, {updateTabsetPanel(session, "panels_kap", "Kapitel 3"); updateTabsetPanel(session, "panels_K3", "Tab. 3.3")})
  # 
  # observeEvent(input$link_to_Tab.4.1, {updateTabsetPanel(session, "panels_kap", "Kapitel 4"); updateTabsetPanel(session, "panels_K4", "Tab. 4.1web")})
  # observeEvent(input$link_to_Tab.4.2, {updateTabsetPanel(session, "panels_kap", "Kapitel 4"); updateTabsetPanel(session, "panels_K4", "Tab. 4.2web")})
  # observeEvent(input$link_to_Tab.4.3, {updateTabsetPanel(session, "panels_kap", "Kapitel 4"); updateTabsetPanel(session, "panels_K4", "Tab. 4.3web")})
  # 
  
  #### 1. DT#1
  
  # df31_subset <- reactive({
  #   if(input$dt1_daten == 1){
  #     a <- subset(df31, Kompetenzstufen %in% input$dt1_kstufe)    
  #   }else{
  #     a <- subset(df31, Land %in% input$dt1_laender & Kompetenzstufen %in% input$dt1_kstufe)    
  #   }
  #   return(a)
  # })
  # 
  output$dt1_tbl_31 <- renderDataTable(
    datatable(df31,
              class = 'row-border hover'))
    # ,
    #             rownames = FALSE,
    #             options = list(lengthChange = FALSE,
    #                            columnDefs = list(list(className = 'dt-center', targets = 1),
    #                                              list(className = 'dt-right', targets = 2:13)), 
    #                            pageLength = nrow(df31),
    #                            dom = 't',                       # remove top search box in favor of column filters
    #                            search = list(regex = TRUE, caseInsensitive = TRUE)
    #             ),
    #             container = htmltools::withTags(table(
    #               thead(
    #                 tr(
    #                   th(class = 'dt-center', rowspan = 2, 'Land'),
    #                   th(class = 'dt-center', rowspan = 2, 'Kompetenz-\nstufen'),
    #                   th(class = 'dt-center', colspan = 2, '2011'),
    #                   th(class = 'dt-center', colspan = 2, '2016'),
    #                   th(class = 'dt-center', colspan = 2, '2021'),
    #                   th(class = 'dt-center', colspan = 3, 'Differenz 2021-2016'),
    #                   th(class = 'dt-center', colspan = 3, 'Differenz 2021-2011'),
    #                   th(class = 'dt-center', colspan = 3, 'Differenz 2016-2011')
    #                 ),
    #                 tr(
    #                   lapply(c(rep(c('%', 'SE'), 3), rep(c('+/-', 'a', 'SE'),3)), th)
    #                 )
    #               )
    #             ))
    #   ) %>% 
    #     formatRound(3:17, digits=1) %>% 
    #     formatStyle(0:17, valueColumns = "Kompetenzstufen", `border-bottom` = styleEqual('V', "solid 2px")) %>%
    #     formatStyle(0:17, valueColumns = "Land",
    #                 fontWeight = styleEqual('Deutschland', "bold"),
    #                 backgroundColor = styleEqual('Deutschland', rgb(217,217,217, max=255))
    #     )
    # )
    # 
    # df41_subset <- reactive({
    #   if(input$dt2_daten == 1){
    #     a <- df41
    #   }else{
    #     a <- subset(df41, Land %in% input$dt2_laender)    
    #   }
    #   return(a)
    # })
    # 
    # output$dt1_tbl_41 <- renderDataTable(
    #   datatable(df41_subset(),
    #             class = 'row-border hover',
    #             rownames = FALSE,
    #             # filter = list(position = 'top', clear = FALSE, selection='multiple'),
    #             options = list(lengthChange = FALSE,
    #                            columnDefs = list(list(className = 'dt-center', targets = 1),
    #                                              list(className = 'dt-right', targets = 1:23)), 
    #                            pageLength = nrow(df41),
    #                            dom = 't',                       # remove top search box in favor of column filters
    #                            search = list(regex = TRUE, caseInsensitive = TRUE)
    #             ),
    #             container = htmltools::withTags(table(
    #               thead(
    #                 tr(
    #                   th(class = 'dt-center', rowspan = 2, 'Land'),
    #                   th(class = 'dt-center', colspan = 4, '2011'),
    #                   th(class = 'dt-center', colspan = 4, '2016'),
    #                   th(class = 'dt-center', colspan = 4, '2021'),
    #                   th(class = 'dt-center', colspan = 4, 'Differenz 2021-2016'),
    #                   th(class = 'dt-center', colspan = 4, 'Differenz 2021-2011'),
    #                   th(class = 'dt-center', colspan = 4, 'Differenz 2016-2011')
    #                 ),
    #                 tr(
    #                   lapply(c(rep(c('M', 'SE', 'SD', 'SE'), 3), rep(c('∆M', 'SE', '∆SD', 'SE'),3)), th)
    #                 )
    #               )
    #             ))
    #   ) %>% 
    #     formatRound(seq(2,24,by=2), digits=3) %>% 
    #     formatRound(seq(3,25,by=2), digits=1) %>%
    #     formatStyle(0:25, valueColumns = "Land",
    #                 fontWeight = styleEqual('Deutschland', "bold"),
    #                 backgroundColor = styleEqual('Deutschland', rgb(217,217,217, max=255))
    #     )
    # )
    # 
    # output$dt1_download_31 <- downloadHandler(
    #   filename = paste0("BT2021_Tab.3.1.web_Auswahl_",Sys.Date(), '.csv'),
    #   content = function(file) {
    #     write.csv(df31_subset(), file, row.names = F, fileEncoding = 'WINDOWS-1252')
    #   }
    # )
    # 
    # output$dt1_download_41 <- downloadHandler(
    #   filename = paste0("BT2021_Tab.4.1.web_Auswahl_",Sys.Date(), '.csv'),
    #   content = function(file) {
    #     write.csv(df41_subset(), file, row.names = F, fileEncoding = 'WINDOWS-1252')
    #   }
    # )
    # 
    
    # ###### GENERAL
    # 
    # titleText <- function(){
    #   renderText({
    #     paste0('<font size=5>', '<b>', '<p style=color:rgb(198,0,0)>', 'IQB-Bildungstrend 2021', '</p>', 
    #            '<p>', 'Kompetenzen in den Fächern Deutsch und Mathematik am Ende der 4. Jahrgangsstufe im dritten Ländervergleich', '</p>' , '</b>',
    #            '<p>', 'Petra Stanat, Stefan Schipolowski, Rebecca Schneider, Karoline A. Sachse, Sebastian Weirich, Sofie Henschel (Hrsg.)', '</p>', '</font>', 
    #            '<p>', ' ', '</p>',
    #            '<p style=color:rgb(198,0,0)>', '<b>', '<font size=4>', 'Zusatzmaterialien zum Berichtsband: Tabellen', '</b>', '</p>',
    #            '<p>', '<font size=3>', 'Stand: 06.03.2023', '</p>', '</font>'
    #     )
    #   })
    # }
    # output$BT.title.dt1 <- titleText()
    # output$BT.title.dt2 <- titleText()
    
    
    
    
    
    }

# Run the application -----------------------------------------------------
shinyApp(ui = ui, server = server)
