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

  
header <- dashboardHeader(
    title = "Insurance churn",
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

sidebar <-  dashboardSidebar(
    sidebarMenu(
      menuItem(
        "Dashboard",
        tabName = "dashboard",
        icon = icon("dashboard")
        ),
      menuItem(
        "Charts",
        tabName = "charts",
        icon = icon("chart-bar")
        ),
      menuItem(
        "Source code", 
        icon = icon("file-code-o"), 
        href = "https://github.com/NicoHenzel/Insurance-Churn-Prediction/tree/main/Dashboard/insurance-churn-dashboard")
    )
  )

body <- dashboardBody(
    tabItems(
      # First tab content
      tabItem(
        tabName = "dashboard",
        h2("Overview of contract churn data"),
        fluidRow(
        box(
          title = tagList("Table of contract data", shiny::icon("file")),
          color = "green",
          plotOutput("plot1", height = 250)
          ),
        box(
          title = "Controls",
          sliderInput(
            "slider",
            "Number of observations:", 1, 100, 50)
          )
        ),
        fluidRow(
          # Dynamic valueBoxes
          valueBoxOutput("clientBox")
        ),
        fluidRow(
          # Clicking this will increment the progress amount
          box(width = 4, actionButton("count", "Increment progress"))
        )
        
      ),
      # Second tab content
      tabItem(
        tabName = "charts",
        h2("Charts of contract data"),
        fluidRow(
          box(
            title = tagList("Total churn distribution", shiny::icon("chart-pie")),
            color = "blue",
            plotOutput("plot2", height = 250)
          ),
          box(
            title = tagList("Most important features", shiny::icon("exclamation")),
            color = "blue",
            plotOutput("plot3", height = 250)
          ),
          tabBox(
            # Title can include an icon
            title = tagList( "Bar charts", shiny::icon("chart-bar")),
            tabPanel("Feature 1",
                     "Tab content 1"
            ),
            tabPanel("Feature 2", "Tab content 2")
          )
        )
      )
    )
  )


ui <- dashboardPage(header, sidebar, body)

server <- function(input, output) {
  set.seed(42)
  histdata <- rnorm(500)
  
  output$plot1 <- renderPlot({
    data <- histdata[seq_len(input$slider)]
    hist(data)
  })
  
  output$clientBox <- renderValueBox({
      valueBox(
        paste0(42 + input$count), "Contaced clients", icon = icon("user"),
        color = "purple"
      )
    })
}

shinyApp(ui, server)

