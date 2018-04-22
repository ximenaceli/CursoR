library(shiny)
library(dplyr)
datos <- read.csv("nacimientos2015.csv", encoding ="UTF-8", sep=";",header = T)

tabla <- datos %>%
group_by(PROVINCIA) %>%
summarize(NACIMIENTOS = sum(TOTAL))

ui <- fluidPage(
  
  img(src="logo.png",width=90, heigth=90),
  
  titlePanel(h1("APLICACION DE PRUEBA")),
  
  
  hr(),
  br(),
  
  navlistPanel(
    "Opciones",
    tabPanel("Datos",dataTableOutput("tabla")),
    tabPanel("Nacimientos",dataTableOutput("nacimientos")),
    tabPanel("Grafico", hcmap("countries/ec/ec-all"))
  )
)

server <- function(input, output) {

  output$tabla <- renderDataTable({datos})
  
  output$nacimientos <- renderDataTable({tabla})
  
  output$grafico<- renderHighchart({
    hchart(nacimientos, colorByPoint =TRUE, name = "provincia")
  })
}

shinyApp(ui, server)
