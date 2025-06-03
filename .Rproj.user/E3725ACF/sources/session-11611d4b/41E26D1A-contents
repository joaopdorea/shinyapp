library(plumber)

# Carregar o modelo
modelo <- readRDS("modelo_estudo_vs_nota.rds")

#* Prever nota com base nas horas de estudo
#* @param horas_estudo:numeric Quantidade de horas estudadas por dia
#* @get /prever
function(horas_estudo){
  horas <- as.numeric(horas_estudo)
  if (is.na(horas)) {
    return(list(error = "Parâmetro 'horas_estudo' inválido ou ausente"))
  }
  
  pred <- predict(modelo, newdata = data.frame(study_hours_per_day = horas))
  
  list(
    horas_estudo = horas,
    nota_prevista = round(pred, 2)
  )
}
