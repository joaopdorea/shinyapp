# Projeto Previsão de Nota com Horas de Estudo

Este projeto contém dois componentes principais desenvolvidos em R:

1. **Shiny App:** Interface web interativa para previsão da nota de um exame com base na quantidade de horas de estudo por dia.
2. **API com Plumber:** Serviço web simples que recebe a quantidade de horas estudadas e retorna a nota prevista usando o mesmo modelo de regressão.

---

## 1. Shiny App

### Descrição
O Shiny App permite ao usuário inserir o número de horas que estuda por dia e obter uma previsão da nota esperada no exame. Além disso, o app oferece diferentes tipos de gráficos para visualizar a relação entre horas de estudo e nota:

- Gráfico de dispersão simples.
- Gráfico com linha de regressão.
- Gráfico com ponto de previsão baseado na entrada do usuário.

### Como executar

1. Certifique-se de que o arquivo `modelo_estudo_vs_nota.rds` (modelo treinado) esteja na mesma pasta do app.
2. Abra o R/RStudio e defina o diretório para a pasta do app.
3. Execute:

```r
library(shiny)
runApp()
