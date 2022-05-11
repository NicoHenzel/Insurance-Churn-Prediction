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

######## Setup ###########
library(shiny) 
library(shinydashboard)
library(DT)

# Set working directory
# Note if you run this on your computer you need to specify the directory where you downloaded the files to
setwd("C:\\Users\\Nico\\Desktop\\Unterlagen_Master_DS_HDM\\SoSe22\\Programming_Languages_for_DS\\Projektarbeit\\churn_prediction\\Insurance-Churn-Prediction\\Dashboard")

######### APP ############
data <-
  read.csv("Results.csv")


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
        # Show predicted data in data table format
        fluidRow(
          column(12,
            title = tagList( shiny::icon("file"),"Table of contract data"),
            status = "primary",
            #width = 12,
            box(DT::dataTableOutput("cdata"),
                height = 600
                #style = "overflow-x: scroll"
                ),
            column(
              6,
              fluidRow(
                valueBoxOutput("clientBox")
              ),
              fluidRow(
                # Clicking this will increment the progress amount
                box(width = 4, actionButton("count", "Increment progress"))
              )
            )
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
            img(src="pie-chart.png", width=500)
            
          ),
          box(
            title = tagList(shiny::icon("exclamation"),"Most important features"),
            status = "primary",
            width = 12,
            tags$iframe(src = "plotly.html", width="100%", height="400", scrolling="no", seamless="seamless", frameBorder="0")
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
    body,
    DT::dataTableOutput("mytable")
    )
# set the dynamic input
server <- function(input, output) {
  
  output$cdata <- DT::renderDataTable({
    datatable(data,
              extensions = list(
                'Buttons' = NULL,
                "Responsive" = NULL
              ),
              options = list(
                dom = 'Bfrtip',
                buttons = c( 'csv', 'excel', 'pdf')
              )
            )
  })
  
  output$clientBox <- renderValueBox({
      valueBox(
        paste0(42 + input$count), "Contaced clients", icon = icon("user"),
        color = "blue"
      )
    })
  
  # output$plot3 <- renderPlot({
  #   # data %>% 
  #   # ggplot(aes_string(x = data$feature_0, y = data$feature_1))+
  #   #   geom_point()
  #   data %>% 
  #     count(churn_prediction, name ="churn_total") %>%
  #     mutate(percent = churn_total/sum(churn_total)*100,
  #            percent = round(percent, 2)) %>%
  #     ggplot(
  #       aes_string(x="",
  #           y=data$percent,
  #           fill=data$churn_prediction)
  #     ) +
  #     geom_bar(
  #       stat="identity",
  #       width=1
  #     ) +
  #     coord_polar("y") +
  #     theme_classic() + 
  #     theme(
  #       axis.line = element_blank(),
  #       axis.text = element_blank(),
  #       axis.ticks = element_blank()
  #     ) +
  #     scale_fill_manual(
  #       values=c("#ffdb58", "#bcd4e6")
  #     ) + 
  #     labs(
  #       x = NULL,
  #       y = NULL,
  #       fill = NULL,
  #       title = "Predicted customer churn distribution",
  #       subtitle = "For insurance contracts") +
  #     geom_text(
  #       aes(label = paste0(percent, "%")),
  #       position = position_stack(vjust=0.5)
  #     )
  # })
  
  
}

shinyApp(ui, server)

