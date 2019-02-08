#global.r


# Things I want to add ----------------------------------------------------
# refresh button that refreshes the page, maybe need a JS element?
# data inputation method that isn't MICE


# packages needed ---------------------------------------------------------
packages <- c("shiny", "shinythemes", "dplyr", "data.table", "DT")
sapply(packages, require, character.only = T)


# app functions -----------------------------------------------------------
read.data <- function(dat){if(is.null(dat)){return(NULL)}else{fread(dat)}}

data.clean.fun <- function(data, method = "Remove Missing Data"){
  if(method == "Remove Missing Data"){
    out.df <- na.omit(data)
  }else if(method == "No Thanks"){
    out.df <- data
  }else{
    out.df <- data
  }
  return(out.df)
}

model.fun <- function(yvar, xvars, data, model, seed = 12345){
  
  set.seed(seed)
  
  if(model == "Linear"){
    lm.fit <- lm(as.formula(paste(yvar, "~", paste(xvars, collapse = "+"))), data = data)
    output <- list(data.frame(summary(lm.fit)$coef), paste("RMSE:", sqrt(mean(lm.fit$residuals^2))), data.frame(lm.fit$fitted.values))
    
  }else if(model == "Random Forest"){
    rf.fit <- randomForest(as.formula(paste(yvar, "~", paste(xvars, collapse = "+"))), data = data)
    output <- list(data.frame(rf.fit$importance), paste("RMSE:", sqrt(rf.fit$mse[500])), data.frame(rf.fit$predicted))
    
  }else{
    print("Model not yet built.. Check back later")
  }
  
  return(output)
  
}






# SCRATCH WORK. COMMENT THIS OUT B4 RUNNING -------------------------------
# path <- "C:/Users/Trevor/Desktop/"
# list.files(path)
# 
# dat <- fread(paste0(path, "Batting.csv"))
# na.omit(dat)
# 
# library(mice)
# glimpse(dat)
# output <- mice(data = dat, method = "pmm")
# methods(mice)
# 
# 
# 
# cars. <- mtcars
# cars.[1, 2] <- NA
# 
# temp <- mice(cars.)
# temp2 <- data.frame(complete(temp, 1))

#model.fun(yvar = "mpg", xvars = c("cyl", "disp", "hp"), data = mtcars, model = "Linear")[1:2]
