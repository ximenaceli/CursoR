library(shiny)
library(dplyr)
datos <- read.csv("nacimientos2015.csv", encoding ="UTF-8", sep=";",header = T)

tabla <- datos %>%
         group_by(PROVINCIA) %>%
         summarize(NACIMIENTOS = sum(TOTAL))

barplot(tabla$NACIMIENTOS)

ui <- fluidPage(
  titlePanel(h1("TITULO DE LA APLICACION")),
  img(src="calidad.jpg",width=90, heigth=90),
  
  hr(),
  br(),
  br(),

  
  sidebarLayout(
    sidebarPanel (
     
      fluidRow(
        column(3,
               
               numericInput(inputId = "grupos",
                            label = "Numero de grupos",
                            min = 2,
                            max = 20,
                            value = 4)
               
        ),
        
        column(9,"texto"
               
               
        )
      )
      
      
      
    ),
    

    mainPanel(
      
      
      
      tabsetPanel(
        tabPanel("Gráfico", plotOutput("grafico")),
        tabPanel("Tabla",dataTableOutput("tabla")),
        tabPanel("Resultado",dataTableOutput("resultado")),
        tabPanel("Mapa","Colocar el mapa")
      )
    )
    
    
  )
  
)


server <- function(input, output){
  output$grafico <- renderPlot({
    hist(iris$Sepal.Length,
         breaks = input$grupos,
         main = "Histograma")
  })
  output$resultado <- renderDataTable({tabla})
  
  output$tabla <- renderDataTable({datos})
  
}

shinyApp(ui,server)
