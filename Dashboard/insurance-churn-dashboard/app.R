# This is a mockup for a dashboard for case handlers.
# The goal is to give them an easy access to informations about insurance customer churn data.
# In a real world scenario this dashboard would be integrated into existing applications of companies.
# The data is taken from a classification model found here:
# https://github.com/NicoHenzel/Insurance-Churn-Prediction

# OFFEN
# Tabelle mit Predictions übernehmen
# Abbildungen: 
# 1. Pie Chart Customer Churn distribution übernehmen auf neuem Datenset
# 2. VIP Features darstellen
# 3. Interaktive Bar graphs für 2 wichtigsten Features um Werte anzuschauen

library(shiny) 
library(shinydashboard)
# library(tidyverse)

# Set name of dashboard and header elements  
header <- dashboardHeader(
    title = "Insurance churn",
    # Specify menu items on the right
    dropdownMenu(
      type = "notifications",
      notificationItem(
        text = "New contract data available",
        icon("file")
        )
      ),
    dropdownMenu(
      type = "tasks",
      badgeStatus = "success",
      taskItem(
        value = 50,
        color = "blue",
        "Contact clients"
        )
      )
    )
# Set different "pages" of dashboard
sidebar <-  dashboardSidebar(
    sidebarMenu(
      # needs a counterpart in body
      menuItem(
        "Dashboard",
        tabName = "dashboard",
        icon = icon("dashboard")
        ),
      # needs a counterpart in body
      menuItem(
        "Charts",
        tabName = "charts",
        icon = icon("chart-bar")
        ),
      # no counterpart needed
      menuItem(
        "Source code", 
        icon = icon("file-code-o"), 
        href = "https://github.com/NicoHenzel/Insurance-Churn-Prediction/tree/main/Dashboard/insurance-churn-dashboard")
    )
  )

# Set content of dashboard pages
body <- dashboardBody(
    tabItems(
      # First tab content
      tabItem(
        tabName = "dashboard",
        h2("Overview of contract churn data"),
        fluidRow(
          box(
            title = "Controls",
            status = "primary",
            width = 8,
            sliderInput(
              "slider",
              "Number of observations:", 1, 100, 50)
          ),
          # Dynamic valueBoxes
          valueBoxOutput("clientBox"),
          # Clicking this will increment the progress amount
          box(width = 4, actionButton("count", "Increment progress"))
        ),
        fluidRow(
          box(
            title = tagList( shiny::icon("file"),"Table of contract data"),
            status = "primary",
            width = 12,
            plotOutput("plot1", height = 250)
          )
        )
      ),
      # Second tab content
      tabItem(
        tabName = "charts",
        h2("Charts of contract data"),
        fluidRow(
          box(
            title = tagList( shiny::icon("chart-pie"),"Total churn distribution"),
            status = "primary",
            width = 12,
            plotOutput("plot2", height = 250)
          ),
          box(
            title = tagList(shiny::icon("exclamation"),"Most important features"),
            status = "primary",
            width = 12,
            plotOutput("plot3", height = 250)
          ),
          tabBox(
            # Title can include an icon
            title = tagList( "Bar charts", shiny::icon("chart-bar")),
            width = 12,
            tabPanel("Feature 1","Tab content 1"),
            tabPanel("Feature 2","Tab content 2")
          )
        )
      )
    )
  )


ui <- 
  dashboardPage(
    skin = "blue",
    header, 
    sidebar, 
    body
    )
# set the dynamic input
server <- function(input, output) {
  set.seed(42)
  # use the data we obtained from our ML model
  histdata <- rnorm(500)
  # LINK_new <- 
  #   "https://raw.githubusercontent.com/NicoHenzel/Insurance-Churn-Prediction/main/Data/Test.csv"
  # new_data <- 
  #   read_csv(LINK_new)
  # 
  # 
  output$plot1 <- renderPlot({
    data <- histdata[seq_len(input$slider)]
    hist(data)
  })
  
  output$clientBox <- renderValueBox({
      valueBox(
        paste0(42 + input$count), "Contaced clients", icon = icon("user"),
        color = "blue"
      )
    })
}

shinyApp(ui, server)

