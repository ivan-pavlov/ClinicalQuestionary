
# This is the user-interface definition of a Shiny web application.
# You can find out more about building applications with Shiny here:
#
# http://shiny.rstudio.com
#

library(shiny)
library(shinythemes)


shinyUI(
  navbarPage(

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

            # Список пациентов
            uiOutput("patients_list"),

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
          h2(textOutput("patient_name")),
          dataTableOutput("patient_data")
        )
      )
    )
  ),
  
  # Second tab
  tabPanel("Анкеты")

  )
)
