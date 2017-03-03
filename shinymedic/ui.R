
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
      sidebarPanel(
        # Выбор пациента
        selectInput(
          inputId = "patient",
          label = "Выберите пациента",
          # Сюда будут передаваться данные из БД
          choices = c("1", "2"),
          # Здесь будет первый пациент из списка в БД
          selected = "1"),
        
        uiOutput("patients"),
        
        # Кнопки связи с пациентов
        actionButton(
          inputId = "sendQuestionary",
          label = "Отправить анкету"
        ),
        
        actionButton(
          inputId = "sendMessage",
          label = "Написать сообщение"
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
