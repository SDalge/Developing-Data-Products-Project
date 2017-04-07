library(shiny)
shinyServer(function(input, output, session) {
  mtype <- reactive({
    ttype <- input$rdtype
    })
  
  mcountry <- reactive({
    tcountry <- input$wcountry

    
  })
 
  output$show <- renderPlot({
    
    cval <- mcountry()
    tval <- mtype()
    gtitle <- paste(tval, " Temperature in ", cval)
    ytext <- paste(tval, " Temperature")
    
    cttemp <- subset(globtemp, country == cval)
    
    pmean <- lm(meanT ~ year, data=cttemp)
    pmax <- lm(maxT ~ year, data=cttemp)
    pmin <- lm(minT ~ year, data=cttemp)
    
    switch(tval,
           mean = {Ti <- as.character(round(pmean$coefficients[1],2))
                    Ts <- as.character(format(pmean$coefficients[2],scientific = TRUE, digits = 3))},
           
           max = {Ti <- as.character(round(pmax$coefficients[1],2))
                    Ts <- as.character(format(pmax$coefficients[2],scientific = TRUE, digits = 3))},
           
           min = {Ti <- as.character(round(pmin$coefficients[1],2))
                    Ts <- as.character(format(pmin$coefficients[2],scientific = TRUE, digits = 3))}
           )
    
    switch(tval,
           mean = plot(cttemp$year, cttemp$meanT, xlab = "Year", ylab = ytext, main = gtitle, type ="l"),
           max = plot(cttemp$year, cttemp$maxT, xlab = "Year", ylab = ytext, main = gtitle, type ="l"),
           min = plot(cttemp$year, cttemp$minT, xlab = "Year", ylab = ytext, main = gtitle, type ="l")
    )
    switch(tval,
           mean = abline(pmean$coefficients, col = "red", lwd = 3),
           max = abline(pmax$coefficients, col = "red", lwd = 3),
           min = abline(pmin$coefficients, col = "red", lwd = 3)
    )

    switch(tval,
           mean = legend("bottomright", c(paste("Intercept = ",Ti),paste("Slope = ",Ts))),
           max = legend("bottomright", c(paste("Intercept = ",Ti),paste("Slope = ",Ts))),
           min = legend("bottomright", c(paste("Intercept = ",Ti),paste("Slope = ",Ts)))
    )
    
    
  })
  
})