shinyUI(fluidPage(
  navbarPage(
    theme = "spacelab",
    "Continuous Output Model",
    
    tabPanel("Home",
             sidebarPanel(
               fileInput("csv1", label = "File Input:", accept = c("text/csv", "text/comma-separated-values,text/plain", ".csv")),
               fileInput("csv2", label = NULL, accept = c("text/csv", "text/comma-separated-values,text/plain", ".csv")),
               fileInput("csv3", label = NULL, accept = c("text/csv", "text/comma-separated-values,text/plain", ".csv")),
               radioButtons("cleanInput", label = "Clean Data?", choices = c("No Thanks", "Remove NA Rows", "Mice")),
               selectInput("modelInput", label = "Select Model", choices = c("Linear", "Random Forest"), selected = "Linear"),
               actionButton("daButton", label = "Go", class = "btn-primary")
             ),
             
             mainPanel(
               fluidRow(
                 dataTableOutput("csv1Table") 
               )
             )

             
))))