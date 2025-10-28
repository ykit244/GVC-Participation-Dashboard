# ============================================================================
# GVC Dashboard - Main Server
# ============================================================================

# Source all server modules
source("modules/tab0_home_server.R")
source("modules/tab1_overview_server.R")
source("modules/tab2_network_server.R")

# ============================================================================
# MAIN SERVER
# ============================================================================

server <- function(input, output, session) {
  
  # Call Tab 0: Home module
  tab0_home_server("tab0")
  
  # Call Tab 1: Overview module
  tab1_overview_server("tab1")
  
  # Call Tab 2: Network Analysis module
  tab2_network_server("tab2")
  
  # Future tabs will be called here:
  # tab3_temporal_server("tab3")
  # tab4_economic_server("tab4")
}