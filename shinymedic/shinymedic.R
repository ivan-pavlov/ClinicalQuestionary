## Only run examples in interactive R sessions
if (interactive()) {
  
  # demoing optgroup support in the `choices` arg
  shinyApp(
    ui = navbarPage(
      
      # theme = shinytheme("flatly"),
      
      # Application title
      title = "Clinical Questionary",
      
      # First tab
      tabPanel(
        title = "Пациенты",
        
        sidebarLayout(
          # Боковая панель
          sidebarPanel(
            tabsetPanel(
              
              # Вкладка выбора пациента
              tabPanel(
                title = "База данных",
                # selectInput(
                #   inputId = "patient",
                #   label = "Выберите пациента",
                #   # Сюда будут передаваться данные из БД
                #   choices = list("A15832/33" = list("Иванов Иван Иванович"),
                #                                           "А19624/98" = list("Петров Петр Петрович"),
                #                                           "В99531/95" = list("Никитин Никита Никитич"),
                #                                           "Е68315/02" = list("Иванов Иван Иванович"))
                #   # Здесь будет первый пациент из списка в БД
                # ),
                # Список пациентов
                uiOutput("patients_list"),
                selectInput("state", "Choose a state:",
                            list(`East Coast` = c("NY", "NJ", "CT"),
                                 `West Coast` = c("WA", "OR", "CA"),
                                 `Midwest` = c("MN", "WI", "IA"))
                ),
                
                actionButton(
                  inputId = "select_patient",
                  label = "Выбрать пациента",
                  width = '100%'
                ),
                
                # Кнопки связи с пациентом
                actionButton(
                  inputId = "send_questionary",
                  label = "Отправить анкету",
                  width = '100%'
                ),
                
                actionButton(
                  inputId = "send_message",
                  label = "Написать сообщение",
                  width = '100%'
                )
              ),
              
              # Вкладка добавления пациента
              tabPanel(
                title = "Добавить пациента",
                textInput(
                  inputId = "patient_id",
                  label = "Регистрационный номер"
                ),
                textInput(
                  inputId = "patient_name",
                  label = "ФИО"
                ),
                selectInput(
                  inputId = "patient_sex",
                  label = "Пол",
                  choices = c("М", "Ж"),
                  selected = "М"
                ),
                dateInput(
                  inputId = "patient_date_of_birth",
                  label = "Дата рождения",
                  format = "dd-mm-yyyy",
                  language = "ru"
                ),
                dateInput(
                  inputId = "operation_date",
                  label = "Дата ТГСК",
                  format = "dd-mm-yyyy",
                  language = "ru"
                ),
                dateInput(
                  inputId = "discharge_date",
                  label = "Дата выписки",
                  format = "dd-mm-yyyy",
                  language = "ru"
                ),
                selectInput(
                  inputId = "patient_relapce",
                  label = "Прогрессия заболевания после ТГСК",
                  choices = c("нет" = 0, "есть" = 1),
                  selected = 0
                ),
                textAreaInput(
                  inputId = "patient_comments",
                  label = "Комментарии"
                ),
                actionButton(
                  inputId = "add_to_db",
                  label = "Добавить в базу"
                )
              )
            )
            
          ),
          
          # Show a plot of the generated distribution
          mainPanel(
            fluidPage(
              textOutput("result"),
              h2(textOutput("patient_name"))
              # dataTableOutput("patient_data")
            )
          )
        )
      ),
      
      # Second tab
      tabPanel("Анкеты")
      
    ),
    
    server = function(input, output) {
      
      patients_list_db <- list("A15832/33" = list("Иванов Иван Иванович"),
                               "А19624/98" = list("Петров Петр Петрович"),
                               "В99531/95" = list("Никитин Никита Никитич"),
                               "Е68315/02" = list("Иванов Иван Иванович"))
      
      # patients_list_db <- c("A15832/33" = "Иванов Иван Иванович",
      #                       "А19624/98" = "Петров Петр Петрович",
      #                       "В99531/95" = "Никитин Никита Никитич",
      #                       "Е68315/02" = "Иванов Иван Иванович")
      
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
      
      output$result <- renderText({
        paste("You chose", input$state)
      })
      
      observeEvent(
        input$select_patient,
        {
          print(input$patient)
          output$result <- renderText({
            paste("You chose", input$state)
          })
        }
      )
      
      
      # Рендеринг информации
      
      ## Выбранное имя пациента для рендера жирным сверху
      output$patient_name <- renderText(unlist(input$patient))
      
      ## 
      output$patient_data <- renderDataTable(
        # Получаем дататейбл, связанный с историей болезни пациента через лист patients_list_info
        # expr = data.frame(patients_list_info[names(input$patient)][[1]]),
        expr = iris,
        options = list(
          pageLength = 10
        )
      )
      
      
      
    }
  )
}