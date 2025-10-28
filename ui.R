# ============================================================================
# GVC Dashboard - Main UI
# ============================================================================

# Source all UI modules
source("modules/tab0_home_ui.R")
source("modules/tab1_overview_ui.R")
source("modules/tab2_network_ui.R")
source("modules/js_utilities.R")

# ============================================================================
# MAIN UI
# ============================================================================

ui <- dashboardPage(
  
  skin = "blue",
  
  # ============================================================================
  # HEADER
  # ============================================================================
  dashboardHeader(title = "GVC DASHBOARD"),
  
  # ============================================================================
  # SIDEBAR
  # ============================================================================
  dashboardSidebar(
    sidebarMenu(
      id = "sidebar",  # Add ID for navigation
      menuItem("Home", tabName = "home", icon = icon("home")),
      menuItem("Overview", tabName = "overview", icon = icon("chart-bar")),
      menuItem("Network Analysis", tabName = "network", icon = icon("project-diagram")),
      menuItem("Temporal Analysis", tabName = "temporal", icon = icon("chart-line")),
      menuItem("Economic Analysis", tabName = "economic", icon = icon("coins"))
    )
  ),
  
  # ============================================================================
  # BODY
  # ============================================================================
  dashboardBody(
    # Initialize shinyjs
    #shinyjs::useShinyjs(),
    
    # Link to external CSS and JavaScript files
    tags$head(
      tags$link(rel = "stylesheet", type = "text/css", href = "custom.css"),
      tags$script(src = "custom.js")
    ),
    
    # Include MathJax
    tags$head(
      tags$script(src = "https://polyfill.io/v3/polyfill.min.js?features=es6"),
      tags$script(src = "https://cdn.jsdelivr.net/npm/mathjax@3/es5/tex-mml-chtml.js")
    ),
    
    # Modal dialog for detailed information
    tags$div(
      id = "infoModal",
      class = "modal fade",
      tabindex = "-1",
      role = "dialog",
      tags$div(
        class = "modal-dialog modal-lg",
        role = "document",
        tags$div(
          class = "modal-content",
          tags$div(
            class = "modal-header",
            tags$button(
              type = "button",
              class = "close",
              `data-dismiss` = "modal",
              `aria-label` = "Close",
              tags$span(`aria-hidden` = "true", HTML("&times;"))
            ),
            tags$h4(class = "modal-title", id = "modalTitle", "Information")
          ),
          tags$div(
            class = "modal-body",
            id = "modalContent",
            p("Content will be displayed here.")
          ),
          tags$div(
            class = "modal-footer",
            tags$button(
              type = "button",
              class = "btn btn-primary",
              `data-dismiss` = "modal",
              "Close"
            )
          )
        )
      )
    ),
    
    # ============================================================================
    # TAB ITEMS
    # ============================================================================
    tabItems(
      # Tab 0: Home
      tab0_home_ui("tab0"),
      
      # Tab 1: Overview
      tab1_overview_ui("tab1"),
      
      # Tab 2: Network Analysis
      tab2_network_ui("tab2"),
      
      # Tab 3: Temporal Analysis (Placeholder)
      tabItem(
        tabName = "temporal", 
        h2("Temporal Analysis", class = "page-title"),
        box(
          width = 12,
          status = "info",
          solidHeader = TRUE,
          title = "COMING SOON",
          p("Tab 3: Temporal Analysis will be implemented next.", style = "color: #5E6C84;")
        )
      ),
      
      # Tab 4: Economic Analysis (Placeholder)
      tabItem(
        tabName = "economic", 
        h2("Economic Analysis", class = "page-title"),
        box(
          width = 12,
          status = "info",
          solidHeader = TRUE,
          title = "COMING SOON",
          p("Tab 4: Economic Analysis will be implemented next.", style = "color: #5E6C84;")
        )
      )
    )
  )
)