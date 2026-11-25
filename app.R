# Load required packages
library(shiny)
library(tidyverse)
library(DT)

# Import wildfire dataset
wildfire <- read_csv(
  "Data/wildfire.csv",
  col_types = cols(IGNITION_DATE = col_character()),
  show_col_types = FALSE
)

# Create the user interface
ui <- fluidPage(
  
  titlePanel("BC Wildfire Data Explorer"),
  
  p("Explore historical wildfire incidents in British Columbia
   from 1950 to 2025. Select a year range and wildfire cause
   to update the plot and table. Use the download button
   to export the filtered data."),
  
  p("Data source: BC Wildfire Service, BC Data Catalogue.
   Records include confirmed fires, suspected fires,
   nuisance fires and other reported incidents."),
  
  sidebarLayout(
    
    sidebarPanel(
      
      # Year range filter
      sliderInput(
        "year",
        "Select year range:",
        min = 1950,
        max = 2025,
        value = c(1950, 2025),
        sep = ""
      ),
      
      # Wildfire cause filter
      selectInput(
        "cause",
        "Select wildfire cause:",
        choices = c("All", "Person", "Lightning", "Unknown")
      ),
      
      # Download button
      downloadButton(
        "download_data",
        "Download CSV"
      )
      
    ),
    
    mainPanel(
      plotOutput("wildfire_plot"),
      
      h3("Filtered Wildfire Records"),
      
      DT::dataTableOutput("wildfire_table")
    )
    
  )
  
)

# Create the server
server <- function(input, output) {
  
  # Filter wildfire data based on user inputs
  filtered_data <- reactive({
    
    data <- wildfire %>%
      filter(FIRE_YEAR >= input$year[1],
             FIRE_YEAR <= input$year[2])
    
    if (input$cause != "All") {
      data <- data %>%
        filter(FIRE_CAUSE == input$cause)
    }
    
    data
  })
  
  # Feature 1: Dynamic wildfire plot
  output$wildfire_plot <- renderPlot({
    
    ggplot(filtered_data(), aes(x = FIRE_YEAR)) +
      geom_bar(fill = "steelblue") +
      labs(
        title = "Number of Wildfire Incidents by Year",
        x = "Year",
        y = "Number of incidents"
      ) +
      theme_minimal()
    
  })
  
  # Feature 2: Dynamic wildfire table
  output$wildfire_table <- DT::renderDataTable({
    
    filtered_data() %>%
      select(FIRE_NUMBER,
             FIRE_YEAR,
             FIRE_CAUSE,
             FIRE_TYPE,
             CURRENT_SIZE)
    
  })
  
  # Feature 3: Download filtered data
  output$download_data <- downloadHandler(
    
    filename = function() {
      "filtered_wildfire.csv"
    },
    
    content = function(file) {
      write.csv(filtered_data(), file, row.names = FALSE)
    }
    
  )
  
}

# Launch the Shiny application
shinyApp(ui = ui, server = server)