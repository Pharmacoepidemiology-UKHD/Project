ui <- fluidPage(
  
  # App title ----
  # Application title
  titlePanel("Seminar 'Reproducible Research'"),
  #Application Title
  h3("Caffeine pharmacokinetics"),
  
  hr(),	#Add a break with a horizontal line
  
  h4("Andreas D. Meid"),
  
  hr(),
  
  # Sidebar layout with input and output definitions ----
  sidebarLayout(
    
    # Sidebar panel for inputs ----
    sidebarPanel(
      
      #Application Description
      #p("CKD EPI trajetories depends on HES application and covariates."),
      #p("Concerning HES application, we provide several treatment options for 3 scenarios:"),
      
      #p("Option 1: 500 mL at the beginning"),
      #p("Option 2: 500 mL on each of days 1 to 4"),
      #p("Option 3: 2000 mL at the beginning"),
      
      
      h4("Plot Options:"),
      br(),	#Add a blank break between widgets
      
      sliderInput("weight_range", "Weight range [kg]:",
                  min = 10, max = 80,
                  value = c(20,50)),
      br(),	#Add a blank break between widgets
      
      br(),	#Add a blank break between widgets
      
      sliderInput("dose_range",
                  "Dose range [mg]:",
                  min = 50,
                  max = 200,
                  value = c(50,50),
                  step = 50),
      
      br(),	#Add a blank break between widgets
      
      downloadButton('foo')

      
    ),
    
    # Main panel for displaying outputs ----
    mainPanel(
      h3("Concentration-Time profiles"),
      plotOutput("plotCT")
      # Output: Tabset w/ plot, summary, and table ----
      #tabsetPanel(type = "tabs",
      #            tabPanel("Plot", print("test")),
      #            tabPanel("Summary", plotOutput("plotCKDEPI")),
      #            tabPanel("Table", plotOutput("plotCKDEPI"))
      #)
    )
  ))

