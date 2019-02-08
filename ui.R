shinyUI(fluidPage(
  navbarPage(
    theme = "spacelab",
    "Continuous Output Model",
    
    tabPanel("Home",
             sidebarPanel(
               tags$h5(tags$b("File Input:")),
               tags$p("Datasets must be of the same structure"),
               fileInput("csv1", label = NULL, accept = c("text/csv", "text/comma-separated-values,text/plain", ".csv")),
               fileInput("csv2", label = NULL, accept = c("text/csv", "text/comma-separated-values,text/plain", ".csv")),
               fileInput("csv3", label = NULL, accept = c("text/csv", "text/comma-separated-values,text/plain", ".csv")),
               radioButtons("cleanInput", label = "Clean Data?", choices = c("No Thanks", "Remove Missing Data", "Other")),
               selectInput("modelInput", label = "Select Model", choices = c("Linear", "Random Forest"), selected = "Linear"),
               actionButton("daButton", label = "Go", class = "btn-primary"),
               
               tags$h4("Download Predicted Values:"),
               downloadButton("downloadButton", label = "Download", class = "btn-primary")
             ),
             
             mainPanel(

# for testing purposes, delete later: -------------------------------------
               fluidRow(
                 dataTableOutput("csv1Table") 
               ),
               

# var select, dependent on data uploaded ----------------------------------
               fluidRow(
                 column(width = 6,
                        tags$h4("Select Response Variable"),
                        uiOutput("yVarInput")
                 ),
                 column(width = 6,
                        tags$h4("Select Explanatory Variables"),
                        uiOutput("xVarsInput")
                 )
               ),

                fluidRow(
                  verbatimTextOutput("modelOutput")
                )
             )

             
))))