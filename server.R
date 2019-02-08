options(shiny.maxRequestSize=30*1024^2) 
shinyServer(function(input, output){
  

# data stacking, reactive on Go button ------------------------------------

  data.reactive <- eventReactive(input$daButton, {
    df1 <- read.data(input$csv1$datapath)
    df2 <- read.data(input$csv2$datapath)
    df3 <- read.data(input$csv3$datapath)
    DF <- rbind(df1, df2, df3)
    return(DF)
  })
  
  # this is for testing purposes, delete this later:
  # output$csv1Table <- renderDataTable({
  #   dat <- data.reactive()
  #   dat
  # })

# UI Var Select, dependent on 1st data upload ---------------------------------
  output$yVarInput <- renderUI({
    radioButtons(inputId = "radioyVarInput", label = NULL,
                 choices = if(is.null(input$csv1)){
                   "Please Select Data for Upload"
                 }else{
                   names(fread(input$csv1$datapath))
                 }
    )
  })
  
  output$xVarsInput <- renderUI({
    checkboxGroupInput(inputId = "radioxVarsInput", label = NULL,
                       choices = if(is.null(input$csv1)){
                         "Please Select Data for Upload"
                       }else{
                         names(fread(input$csv1$datapath))
                       }
    )
  })
  

# Model output, reactive on go button -------------------------------------
  model.reactive <- eventReactive(input$daButton, {
    
    dat <- data.clean.fun(data = data.reactive(), method = input$cleanInput)
    
    if(is.null(dat)){
      print("Import Data")
    }else{
      model.fun(yvar = input$radioyVarInput, xvars = input$radioxVarsInput, data = dat, model = input$modelInput)[1:2]
    }
  })
  
  output$modelOutput <- renderPrint({
    model.reactive()
  })
  

# Download button, not yet working ----------------------------------------
  output$downloadButton <- downloadHandler(
    filename = function() {paste0('pred_vals-', Sys.Date(), '.csv')},
    content = function(file) {
      preds <- model.fun(yvar = input$yVarInput, xvars = input$xVarsInput, data = fread(input$csv1$datapath), model = input$modelInput)[[3]]
      names(preds) <- c("Predicted_Values")
      write.csv(preds, file, row.names = TRUE)
    },
    contentType = "text/csv"
  )
  

  
})
