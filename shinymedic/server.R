
# This is the server logic for a Shiny web application.
# You can find out more about building applications with Shiny here:
#
# http://shiny.rstudio.com
#

library(shiny)

shinyServer(function(input, output) {

  # Получение информации из БД
  output$patients <- renderUI({
    selectInput(
    inputId = "patient",
    label = "Выберите пациента",
    # Сюда будут передаваться данные из БД
    choices = c("1. Иванов Иван Иванович" = list("other_info"),
                   "2. Петров Петр Петрович" = list("other_info"),
                   "3. Никитин Никита Никитич" = list("other_info"),
                   "4. Иванов Иван Иванович" = list("other_info"))
    # Здесь будет первый пациент из списка в БД
)
  })
    
  
  # Рендеринг информации
  
  ## Выбранное имя пациента для рендера жирным сверху
  output$patient_name <- renderText(input$patient)
  
  ## 
  output$patient_data <- renderDataTable(
    expr = iris,
    options = list(
      pageLength = 10
    )
  )
  
  

})
