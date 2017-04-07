
globtemp <- read.csv("Globaltemp.csv")

names(globtemp) <- c("x", "country","minT", "maxT", "meanT", "year")

Country <-as.vector(names(table(globtemp$country)))
