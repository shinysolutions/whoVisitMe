output$uiRegisted <- renderUI({
  dateRangeInput(inputId = "registed", 
                 label   = "Date range:",
                 start   = as.character(Sys.Date()-60),
                 end     = as.character(Sys.Date()))
})



output$uiChart <- renderUI ({
  radioButtons(inputId = "chart", label = "Chart type:",
               choices = c("Normal" = "numb", "Cumulative" = "cumu"))
})


output$uiInterval <- renderUI({
  radioButtons(inputId = "interval", label = "Data unit:",
               choices = c("Day" = "day", "Week" = "week", "Month" = "month"),
               selected = "week")
})

