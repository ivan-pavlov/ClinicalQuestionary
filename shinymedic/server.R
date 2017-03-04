
# This is the server logic for a Shiny web application.
# You can find out more about building applications with Shiny here:
#
# http://shiny.rstudio.com
#

library(shiny)

shinyServer(function(input, output) {

  patients_list_db <- list("A15832/33" = list("Иванов Иван Иванович"),
                           "А19624/98" = list("Петров Петр Петрович"),
                           "В99531/95" = list("Никитин Никита Никитич"),
                           "Е68315/02" = list("Иванов Иван Иванович"))
  
  patients_list_info <- list("A15832/33" = iris[1:5, ],
                             "А19624/98" = iris[5:10, ],
                             "В99531/95" = iris[10:15, ],
                             "Е68315/02" = iris[15:20, ])
  
  
  # Получение информации из БД
  output$patients_list <- renderUI({
    selectInput(
    inputId = "patient",
    label = "Выберите пациента",
    # Сюда будут передаваться данные из БД
    choices = patients_list_db,
    # Здесь будет первый пациент из списка в БД
    selected = patients_list_db[1]
    )
  })
    
  
  # Рендеринг информации
  
  ## Выбранное имя пациента для рендера жирным сверху
  output$patient_name <- renderText(unlist(input$patient[[1]]))
  
  ## 
  output$patient_data <- renderDataTable(
    # Получаем дататейбл, связанный с историей болезни пациента через лист patients_list_info
    # expr = data.frame(patients_list_info[names(input$patient)][[1]]),
    expr = iris,
    options = list(
      pageLength = 10
    )
  )
  
  

})
