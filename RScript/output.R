observe({
  if (!is.null(input$registed)) {
    drg <- as.Date(input$registed)
    DatS <- Dat[which(Dat$Time >= drg[1] & Dat$Time <= drg[2]), ]
    DatU <- DatS[which(!is.na(DatS$Lon)),]
    p$Dat <- DatU
  }
})



# Generate map;
output$myMap <- renderMap({
      if (!is.null(p$Dat)) {
        Dat <- p$Dat
        if (nrow(Dat) > 0) {
          Map <- Leaflet$new()
          Map$addParams(width="vw", height="800px;", layerOpts = list(maxZoom = 18, zoomControl = FALSE))
          Map$addParams(bounds = list(c(-20, -20), c(50, 40)))
          Points <- lapply(1:nrow(Dat), function(x) {return(c(lat = Dat$Lat[x], lon = Dat$Lon[x], value = paste(Dat$City[x], as.character(Dat$Time[x]), sep = ": ")))})
          Map$addParams(cluster = Points)
          Map
        }
      }

})

## Highcharts
output$fig <- renderChart({
  ## Highchart basic;
  H <- Highcharts$new()
  H$addParams(dom = "fig")
  H$chart(type = "column", zoomType = "xy")
  H$legend(enabled = FALSE)
  
  if (!is.null(p$Dat)) {
    Dat <- p$Dat
    if (nrow(Dat) > 0) {
      # Aggregate week/month;
      if (input$interval == "week") {
        Dat$Time <- d2f(Dat$Time, p = "%w")
      } else if (input$interval == "month") {
        Dat$Time <- d2f(Dat$Time, p = "%d")
      } 
      if (nrow(Dat)>0) {
        print(head(Dat))
      # Aggregate;
      dat <- aggregate(list(Num  = Dat$IP), list(Time = Dat$Time), length) 
      
        ## Cumulative;
        if (input$chart == "cumu") {dat$Num <- cumsum(dat$Num)}
        ## plot time series;
        H$series(data = lapply(1:nrow(dat), FUN = function(x) {c(as.numeric(as.POSIXct(dat[x, 1])) * 1000, dat[x, 2])}),
                 name = "Visitor number")
        if (input$interval == "day") {
          step <- ceiling(as.numeric(diff(as.Date(range(as.character(dat$Time)))))/10)
          H$xAxis(tickLength = 0, type = "datetime", title = "Day",
                  events = list(setExtremes = setExtremes_D),
                  labels = list(format = "{value:%d.%m.%Y}", step = step),
                  tickInterval = 1 * 24 * 36e5)
        } else if (input$interval == "week") {
          step <- ceiling(as.numeric(diff(as.Date(range(as.character(dat$Time)))))/10/7)
          H$xAxis(tickLength = 0, type = "datetime", title = "Week",
                  events = list(setExtremes = setExtremes_W),
                  labels = list(format = "{value:%d.%m.%Y}", step = step),
                  tickInterval = 7 * 24 * 36e5)
        } else if (input$interval == "month") {
          step <- ceiling(as.numeric(diff(as.Date(range(as.character(dat$Time)))))/10/30)
          H$xAxis(tickLength = 0, type = "datetime", title = "Month",
                  events = list(setExtremes = setExtremes_M),
                  labels = list(format = "{value:%d.%m.%Y}", step = step),
                  tickInterval = 30 * 24 * 36e5)
        }
      }

    }
  } 
  H

})