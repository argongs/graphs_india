library('shiny')
#Load Shiny Package

#Define UI here
shinyUI(fluidPage(
  #Application Title
  titlePanel("Indian Forest Cover Analysis"),
  hr(),
  #!Sidebar Layout begins here
  sidebarLayout(
    sidebarPanel(
      
      #Powered by
      img(src="shiny.png", style="display: block; margin-left: auto; margin-right: auto"),
      h4("A Shiny Creation", style="text-align:center"),
      hr(),
      
      sliderInput(inputId = "year", label = "Year Transition", min = 2001, max = 2015, value = 0, step = 1, animate = TRUE),
      #hr(),
      
      h5("Developed in ", style="text-align: center;"),
      img(src="rstudio.png", style="display: block; margin-left: auto; margin-right: auto"),
      br(),br()
    ),
    mainPanel(
      tabsetPanel(
        #tabPanel("Summary",icon = icon("list-alt"), uiOutput("summary")),
        tabPanel("World Standing",icon = icon("bar-chart-o"), uiOutput("f_text"),plotOutput("top10")),#,
        tabPanel("India's Forest Cover",icon = icon("bar-chart-o"),uiOutput("a_text"),plotOutput("forest"), uiOutput("b_text"),plotOutput("compare"))
        #tabPanel("Table",icon = icon("table"), uiOutput("atable"),uiOutput("ctable"))
      )
      
    )
  )
  
  
))

