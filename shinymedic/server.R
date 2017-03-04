
# This is the server logic for a Shiny web application.
# You can find out more about building applications with Shiny here:
#
# http://shiny.rstudio.com
#

library(shiny)

shinyServer(function(input, output) {

  
  patients_list <- list("1. Иванов Иван Иванович" = list("A15832/33"),
                           "2. Петров Петр Петрович" = list("А19624/98"),
                           "3. Никитин Никита Никитич" = list("В99531/95"),
                           "4. Иванов Иван Иванович" = list("Е68315/02"))
  
  patients_list_info <- list("A15832/33" = c(name = "1. Иванов Иван Иванович", db = "data.frame(iris[1:5, ])"),
                             "А19624/98" = c(name = "2. Петров Петр Петрович", db = "data.frame(iris[5:10, ])"),
                             "В99531/95" = c(name = "3. Никитин Никита Никитич", db = "data.frame(iris[10:15, ]"),
                             "Е68315/02" = c(name = "4. Иванов Иван Иванович", db = "data.frame(iris[15:20, ])"))
  
  patients_list_db <- list("A15832/33" = data.frame(iris[1:5, ]),
                           "А19624/98" = data.frame(iris[5:10, ]),
                           "В99531/95" = data.frame(iris[10:15, ]),
                           "Е68315/02" = data.frame(iris[15:20, ]))
  
  
  
  # Получение информации из БД
  output$patients_list <- renderUI({
    selectInput(
      inputId = "patient",
      label = "Выберите пациента",
      # Сюда будут передаваться данные из БД
      choices = patients_list,
      # Здесь будет первый пациент из списка в БД
      selected = patients_list[1]
    )
  })

  # Рендеринг информации
  
  ## Выбранное имя пациента для рендера жирным сверху вместе с номером истории болезни
  output$patient_name <- renderText({
    paste0(patients_list_info[[input$patient]]["name"],
           " (",
           input$patient,
           ")")
    })
  
  ## 
  output$patient_data <- renderDataTable(
    # Получаем дататейбл, связанный с историей болезни пациента через лист patients_list_info
    expr = data.frame(patients_list_db[[input$patient]]),
    options = list(
      pageLength = 10
    )
  )
  
  

})
