library(shiny)
library(ggplot2)

# Carrega o modelo
modelo <- readRDS("modelo_estudo_vs_nota.rds")

 students_habits_performance <- read.csv("student_habits_performance.csv")

# Interface
ui <- fluidPage(
  titlePanel("Previsão de Nota com Base nas Horas de Estudo"),
  sidebarLayout(
    sidebarPanel(
      numericInput("horas_estudo", "Horas de Estudo por Dia:", value = 1.0, step = 0.1),
      actionButton("prever", "Prever Nota")
    ),
    mainPanel(
      verbatimTextOutput("resultado"),
      tabsetPanel(
        tabPanel("Gráfico: Dispersão Simples", plotOutput("grafico_dispersao")),
        tabPanel("Gráfico: Regressão", plotOutput("grafico_regressao")),
        tabPanel("Gráfico: Previsão", plotOutput("grafico_previsao"))
      )
    )
  )
)

# Servidor
server <- function(input, output) {
  # Previsão ao clicar no botão
  valor_previsto <- eventReactive(input$prever, {
    horas <- input$horas_estudo
    if (is.na(horas)) return(NULL)
    predict(modelo, newdata = data.frame(study_hours_per_day = horas))
  })
  
  # Resultado textual
  output$resultado <- renderPrint({
    if (is.null(valor_previsto())) return("Insira um valor e clique em Prever.")
    cat("Horas de Estudo por Dia:", input$horas_estudo, "\n")
    cat("Nota Prevista no Exame:", round(valor_previsto(), 2))
  })
  
  # Gráfico 1: Dispersão simples
  output$grafico_dispersao <- renderPlot({
    ggplot(students_habits_performance, aes(x = study_hours_per_day, y = exam_score)) +
      geom_point(color = "blue") +
      labs(title = "Dispersão: Horas vs Nota",
           x = "Horas de Estudo por Dia",
           y = "Nota no Exame") +
      theme_minimal()
  })
  
  # Gráfico 2: Dispersão + linha de regressão
  output$grafico_regressao <- renderPlot({
    ggplot(students_habits_performance, aes(x = study_hours_per_day, y = exam_score)) +
      geom_point(color = "blue") +
      geom_smooth(method = "lm", color = "red", se = TRUE) +
      labs(title = "Regressão Linear",
           x = "Horas de Estudo por Dia",
           y = "Nota no Exame") +
      theme_minimal()
  })
  
  # Gráfico 3: Previsão com ponto do usuário
  output$grafico_previsao <- renderPlot({
    ggplot(students_habits_performance, aes(x = study_hours_per_day, y = exam_score)) +
      geom_point(color = "gray") +
      geom_smooth(method = "lm", color = "red", se = FALSE) +
      geom_point(aes(x = input$horas_estudo, y = valor_previsto()), color = "darkgreen", size = 4) +
      labs(title = "Previsão Individual",
           x = "Horas de Estudo por Dia",
           y = "Nota no Exame") +
      theme_minimal()
  })
}

# Executar o app
shinyApp(ui, server)
