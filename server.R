options(shiny.maxRequestSize=30*1024^2) 
shinyServer(function(input, output){
  
  data.reactive <- eventReactive(input$daButton, {
    df1 <- read.data(input$csv1$datapath)
    df2 <- read.data(input$csv2$datapath)
    df3 <- read.data(input$csv3$datapath)
    DF <- rbind(df1, df2, df3)
    return(DF)
  })
  
  output$csv1Table <- renderDataTable({
    data.reactive()
  })

  
})
