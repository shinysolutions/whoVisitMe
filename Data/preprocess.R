
setwd("/srv/hd/whoVisitMe/Data")

load(file = "Dat.RData")

TMP <- readLines("tmp.txt")
TMP <- TMP[which(nchar(TMP) > 0)]
TMP.split <- strsplit(TMP, ",|ipInfo\\|")
tmp <- data.frame(Time = rep(NA, length(TMP.split)), IP = NA, City = NA, Lat = NA, Lon = NA)
for ( i in 1:length(TMP.split)) { tmp[i, ] <- TMP.split[[i]]}
tmp$Time <- as.Date(tmp$Time, "%a %b %d %H:%M:%S %Y")
tmp$Lat <- as.numeric(tmp$Lat)
tmp$Lon <- as.numeric(tmp$Lon)
tmp <- unique(tmp[, c("Time", "Lon", "Lat", "IP", "City")])

if (nrow(tmp) > 0) {
  Dat <- rbind(Dat, tmp)
  Dat <- unique(Dat)
  save(Dat, file = "Dat.RData")
}




    
