library(shiny)
library(markdown)

shinyUI(fluidPage(
  titlePanel("Global Temperatures"),
  sidebarLayout(
    sidebarPanel(
      selectInput("wcountry", "Country: ", Country),
      radioButtons("rdtype", "Min/Mean/max", c("min", "max", "mean"))
                ),
    mainPanel(
      tabsetPanel(type = "tabs",
                    tabPanel("Documentation",includeMarkdown("doc.Rmd")),
                    tabPanel("Show Graphic", plotOutput("show"))
                  )  
    
            )
    )
))