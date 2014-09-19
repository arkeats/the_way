library(shiny)
library(rCharts)
shinyUI(fluidPage(
    titlePanel("St. James's Way (The French Way)"),
    sidebarLayout(
    sidebarPanel(
    selectInput("var1", label = "Choose a Stage:",choices = s$id,selected = "stage1"),
    selectInput("var2",label = "Choose a Site:", choices = cam$Site, selected = "Saint Jean Pied de Port"),
        br(),
        br(),
        br(),
        br(),
        img(src = "camino.png", height = 72, width = 72),
        span("by Andre", style = "color:blue")
        ),
    mainPanel(
    tabsetPanel(
    tabPanel("Map", tags$style('.leaflet {height: 400px;}'),
    showOutput('mapPlot','leaflet')),
    tabPanel("Altitude", textOutput("text1"),showOutput("plot1", lib = "morris")),
    tabPanel("Distance",textOutput("text2"),tableOutput ("tab2"),tableOutput ("tab1"))
  )))))