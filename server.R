
shinyServer(function(input, output, session) {
  load("Data/Dat.RData")
  
  ## Source input and output files;
  source("RScript/myFun.R")
  source("RScript/input.R", local = TRUE)
  source("RScript/output.R", local = TRUE)
  
  p <- reactiveValues()
  ## Record visitor's info;
  observe({
    if (!grepl("Notodden", input$log)) {
      # print(input$log)
      msg <- gsub(".*ipInfo", paste(date(), "ipInfo"), input$log)
      if (nchar(msg) > 20) {
        tmp <- readLines("Data/tmp.txt", n = 1)
        day <- as.Date(tmp, "%a %b %d %H:%M:%S %Y")
        write(msg, "Data/tmp.txt", append  = Sys.Date() == day)
      }  
    }
  })
  
})  
