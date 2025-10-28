# ============================================================================
# TAB 2: NETWORK ANALYSIS - UI
# ============================================================================

tab2_network_ui <- function(id) {
  ns <- NS(id)
  
  tabItem(
    tabName = "network",
    
    h2("Network Analysis", class = "page-title"),
    
    # Filters (without toggle - moved to map)
    fluidRow(
      box(
        title = "NETWORK FILTERS",
        status = "info",
        solidHeader = TRUE,
        width = 12,
        
        fluidRow(
          column(
            width = 6,
            selectizeInput(
              ns("network_exporter"),
              "Select Exporter (Central Node):",
              choices = country_choices_i,
              selected = "MYS",  # Default to Malaysia
              options = list(placeholder = 'Select an exporter')
            )
          ),
          column(
            width = 6,
            selectizeInput(
              ns("network_year"),
              "Select Year:",
              choices = setNames(years, years),
              selected = "2020"
            )
          )
        )
      )
    ),
    
    # Geographic Network Map with integrated toggle
    fluidRow(
      box(
        title = "GEOGRAPHIC NETWORK MAP",
        status = "info",
        solidHeader = TRUE,
        width = 12,
        
        # Toggle at top left
        fluidRow(
          column(
            width = 3,
            radioButtons(
              ns("metric_toggle"),
              "Rank by:",
              choices = c(
                "GVC Participation" = "participation",
                "Total GVC" = "total_gvc"
              ),
              selected = "participation",
              inline = FALSE
            )
          ),
          column(
            width = 9,
            p("Trade network overlaid on world map showing actual geographic locations of trading partners. 
              Node size and line thickness determined by selected metric.",
              style = "color: #5E6C84; margin-top: 20px;")
          )
        ),
        
        plotlyOutput(ns("network_map"), height = "600px")
      )
    ),
    
    # Top Partners Charts - Two parallel charts
    fluidRow(
      box(
        title = "TOP TRADING PARTNERS",
        status = "info",
        solidHeader = TRUE,
        width = 12,
        
        # Centered slider
        fluidRow(
          column(width = 4),  # Left spacing
          column(
            width = 4,
            sliderInput(
              ns("top_n_partners"),
              "Number of Top Partners:",
              min = 5,
              max = 30,
              value = 10,
              step = 1
            )
          ),
          column(width = 4)  # Right spacing
        ),
        
        # Two charts side by side
        fluidRow(
          column(
            width = 6,
            h4("Ranked by GVC Participation", 
               style = "text-align: center; color: #172B4D; font-weight: 600; margin-bottom: 20px;"),
            uiOutput(ns("participation_chart_ui"))
          ),
          column(
            width = 6,
            h4("Ranked by Total GVC", 
               style = "text-align: center; color: #172B4D; font-weight: 600; margin-bottom: 20px;"),
            uiOutput(ns("total_gvc_chart_ui"))
          )
        )
      )
    )
  )
}