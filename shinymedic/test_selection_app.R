## Only run examples in interactive R sessions
if (interactive()) {
  
  # demoing optgroup support in the `choices` arg
  shinyApp(
    ui = fluidPage(
      uiOutput("patients_list"),
      textOutput("result")
    ),
    
    server = function(input, output) {
      
      output$patients_list <- renderUI({
        selectInput(
          inputId = "patient",
          label = "Выберите пациента",
          # Сюда будут передаваться данные из БД
          choices = list("A15832/33" = list("Иванов Иван Иванович"),
                         "А19624/98" = list("Петров Петр Петрович"),
                         "В99531/95" = list("Никитин Никита Никитич"),
                         "Е68315/02" = list("Иванов Иван Иванович"))
          # Здесь будет первый пациент из списка в БД
        )
      })
      
      
      output$result <- renderText({
        paste("You chose", unlist(input$patient))
      })
    }
  )
}