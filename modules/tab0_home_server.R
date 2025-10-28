# ============================================================================
# TAB 0: HOME - SERVER
# ============================================================================

tab0_home_server <- function(id) {
  moduleServer(id, function(input, output, session) {
    
    # Navigate to Overview tab when button is clicked
    observeEvent(input$goto_overview, {
      # Use JavaScript to click the Overview menu item
      shinyjs::runjs("$('a[data-value=\"overview\"]').click();")
    })
  })
}