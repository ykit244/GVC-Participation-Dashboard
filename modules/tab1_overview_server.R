# ============================================================================
# TAB 1: OVERVIEW - SERVER
# ============================================================================

tab1_overview_server <- function(id) {
  moduleServer(id, function(input, output, session) {
    
    # Filtered data based on user selections
    filtered_data <- reactive({
      df <- data
      
      # Apply exporter filter
      if (input$filter_exporter != "all") {
        df <- df %>% filter(country_i == input$filter_exporter)
      }
      
      # Apply importer filter
      if (input$filter_importer != "all") {
        df <- df %>% filter(country_j == input$filter_importer)
      }
      
      # Apply year filter
      if (input$filter_year != "all") {
        df <- df %>% filter(year == as.numeric(input$filter_year))
      }
      
      return(df)
    })
    
    # Reset filters button
    observeEvent(input$reset_filters, {
      updateSelectInput(session, "filter_exporter", selected = "all")
      updateSelectInput(session, "filter_importer", selected = "all")
      updateSelectInput(session, "filter_year", selected = "all")
    })
    
    # Interactive data table
    output$data_table <- renderDT({
      df_display <- filtered_data() %>%
        mutate(
          # Convert country codes to full names
          exporter_name = sapply(country_i, function(x) country_names[x]),
          importer_name = sapply(country_j, function(x) country_names[x])
        ) %>%
        select(
          Exporter = exporter_name,
          Importer = importer_name,
          Year = year,
          `Forward Linkage (USD, MM)` = bilateral_gvcf,
          `Backward Linkage (USD, MM)` = bilateral_gvcb,
          `Total GVC (USD, MM)` = bilateral_gvc,
          `Gross Exports (USD, MM)` = bilateral_exgr,
          `GVC Participation` = bi_gvc_ratio,
          `GDP per capita (Exporter)` = gdp_pc_i,
          `GDP per capita (Importer)` = gdp_pc_j,
          `GDP Gap` = gdp_pc_gap
        )
      
      datatable(
        df_display,
        options = list(
          pageLength = 15,
          scrollX = TRUE,
          searchHighlight = TRUE,
          dom = 'Bfrtip',
          buttons = c('copy', 'csv', 'excel', 'pdf'),
          language = list(
            search = "Search:",
            lengthMenu = "Show _MENU_ entries",
            info = "Showing _START_ to _END_ of _TOTAL_ entries"
          )
        ),
        rownames = FALSE,
        filter = 'top',
        class = 'cell-border stripe hover',
        escape = FALSE
      ) %>%
        # Format numbers
        formatRound(columns = c('Forward Linkage (USD, MM)', 'Backward Linkage (USD, MM)', 
                                'Total GVC (USD, MM)', 'Gross Exports (USD, MM)'), 
                    digits = 2) %>%
        formatRound(columns = c('GVC Participation', 'GDP Gap'), 
                    digits = 3) %>%
        formatRound(columns = c('GDP per capita (Exporter)', 'GDP per capita (Importer)'), 
                    digits = 2) %>%
        
        # Group 1: GVC-related columns (Light blue background)
        formatStyle(
          c('Forward Linkage (USD, MM)', 'Backward Linkage (USD, MM)', 
            'Total GVC (USD, MM)', 'Gross Exports (USD, MM)', 'GVC Participation'),
          backgroundColor = '#DEEBFF',
          color = '#000000'
        ) %>%
        
        # Group 2: GDP-related columns (Pale blue background)
        formatStyle(
          c('GDP per capita (Exporter)', 'GDP per capita (Importer)', 'GDP Gap'),
          backgroundColor = '#F4F5F7',
          color = '#000000'
        ) %>%
        
        # Data bars for GVC Participation
        formatStyle(
          'GVC Participation',
          fontWeight = 'bold',
          color = '#000000',
          background = styleColorBar(range(df_display$`GVC Participation`, na.rm = TRUE), 'rgba(0, 82, 204, 0.5)'),
          backgroundSize = '100% 80%',
          backgroundRepeat = 'no-repeat',
          backgroundPosition = 'center'
        ) %>%
        
        # Data bars for GDP Gap
        formatStyle(
          'GDP Gap',
          fontWeight = 'bold',
          color = '#000000',
          background = styleColorBar(range(df_display$`GDP Gap`, na.rm = TRUE), 'rgba(0, 82, 204, 0.5)'),
          backgroundSize = '100% 80%',
          backgroundRepeat = 'no-repeat',
          backgroundPosition = 'center'
        )
    })
  })
}
