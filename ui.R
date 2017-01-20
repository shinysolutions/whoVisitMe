library(rCharts)

shinyUI(bootstrapPage(
  tagList(
    tags$head(
      tags$link(rel="stylesheet", type="text/css",href="style.css")
    ),
    tags$body(
      tags$script(src = "ipinfo.js")
    )
  ),
  
  div(class = "input",
      div(class = "wPanel", 
          uiOutput("uiRegisted"),
          uiOutput("uiChart"), br(),br(),
          uiOutput("uiInterval"),
          textInput(inputId = "log", label = "", value = "")
      )
      
  ),
  
  
  div(class = "output", 
      tabsetPanel( 
        tabPanel("Map"  , showOutput("myMap", lib = "leaflet")),
        tabPanel("Chart", showOutput("fig", lib = "highcharts"))
      )
  )
  
))


