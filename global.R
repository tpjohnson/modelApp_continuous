#global.r

# -----------------------------------------------------------------
# Packages
packages <- c("shiny", "shinythemes", "dplyr", "data.table", "DT")
sapply(packages, require, character.only = T)


#-----------------------------------------------------------------
# app functions

read.data <- function(dat){if(is.null(dat)){return(NULL)}else{fread(dat)}}

data.clean.fun <- function(method){
  #idk yet
}

model.fun <- function(yvar, xvars, data, model, seed = 12345){
  
  set.seed(seed)
  
  if(model == "Linear Model"){
    lm.fit <- lm(as.formula(paste(yvar, "~", paste(xvars, collapse = "+"))), data = data)
    out <- list(data.frame(summary(lm.fit)$coef), paste("RMSE:", sqrt(mean(lm.fit$residuals^2))), data.frame(lm.fit$fitted.values))
    
  }else if(model == "Random Forest"){
    rf.fit <- randomForest(as.formula(paste(yvar, "~", paste(xvars, collapse = "+"))), data = data)
    out <- list(data.frame(rf.fit$importance), paste("RMSE:", sqrt(rf.fit$mse[500])), data.frame(rf.fit$predicted))
    
  }else{
    print("Model not yet built.. Check back later")
  }
  
  out
  
}





#----------------------------------------------------------------
# SCRATCH WORK. COMMENT THIS OUT B4 RUNNING
#scratch work
path <- "C:/Users/Trevor/Desktop/"
list.files(path)

dat <- fread(paste0(path, "Batting.csv"))




