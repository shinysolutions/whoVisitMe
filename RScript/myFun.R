## Convert date to the first day of weeks, months;
d2f <- function(x, p = "%w") {
  d <- as.numeric(format(as.Date(x), p))
  d[which(d == 0)] <- 7
  return(as.Date(x)-d+1)
}


## setExtremes;

setExtremes_D <- "#! 
function(event) {  
if (event.max) {    
var f = Math.ceil((event.max - event.min)/10/1/24/36e5);    
this.options.labels.step = f;  
} else {  
var max = this.chart.xAxis[0].dataMax
var min = this.chart.xAxis[0].dataMin
var f = Math.ceil((max - min)/10/1/24/36e5);    
this.options.labels.step = f;  
};
} !#"

setExtremes_W <- "#! 
function(event) {  
if (event.max) {    
var f = Math.ceil((event.max - event.min)/10/7/24/36e5);    
this.options.labels.step = f;  
} else {  
var max = this.chart.xAxis[0].dataMax
var min = this.chart.xAxis[0].dataMin
var f = Math.ceil((max - min)/10/7/24/36e5);    
this.options.labels.step = f;  
};
} !#"

setExtremes_M <- "#! 
function(event) {  
if (event.max) {    
var f = Math.ceil((event.max - event.min)/10/30/24/36e5);    
this.options.labels.step = f;  
} else {  
var max = this.chart.xAxis[0].dataMax
var min = this.chart.xAxis[0].dataMin
var f = Math.ceil((max - min)/10/30/24/36e5);    
this.options.labels.step = f;  
};
} !#"


