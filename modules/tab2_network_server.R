# ============================================================================
# TAB 2: NETWORK ANALYSIS - SERVER
# ============================================================================

tab2_network_server <- function(id) {
  moduleServer(id, function(input, output, session) {
    
    # Helper function to format large numbers with 2 decimal places
    format_value <- function(value) {
      if (is.na(value)) return("N/A")
      if (value >= 1000) {
        return(paste0("$", format(round(value / 1000, 2), nsmall = 2), "B"))
      } else {
        return(paste0("$", format(round(value, 2), nsmall = 2), "M"))
      }
    }
    
    # Filter data for selected exporter and year
    network_data <- reactive({
      req(input$network_exporter, input$network_year)
      
      data %>%
        filter(
          country_i == input$network_exporter,
          year == as.numeric(input$network_year)
        )
    })
    
    # Geographic Network Map
    output$network_map <- renderPlotly({
      req(nrow(network_data()) > 0)
      
      net_data <- network_data()
      exporter <- input$network_exporter
      exporter_name <- country_names[exporter]
      metric <- input$metric_toggle
      
      # Sort by selected metric for map visualization
      net_data <- net_data %>%
        arrange(desc(if (metric == "participation") bi_gvc_ratio else bilateral_gvc))
      
      # Get coordinates for exporter
      exporter_coords <- country_coords %>%
        filter(country_code == exporter)
      
      # Get coordinates for partners and merge with network data
      partner_data <- net_data %>%
        left_join(country_coords, by = c("country_j" = "country_code")) %>%
        filter(!is.na(latitude) & !is.na(longitude))
      
      # Determine scaling metric
      if (metric == "participation") {
        partner_data$scale_metric <- partner_data$bi_gvc_ratio
        metric_label <- "GVC Participation"
      } else {
        partner_data$scale_metric <- partner_data$bilateral_gvc
        metric_label <- "Total GVC"
      }
      
      # Normalize scale_metric for visualization (0-1 range)
      max_metric <- max(partner_data$scale_metric, na.rm = TRUE)
      min_metric <- min(partner_data$scale_metric, na.rm = TRUE)
      partner_data$normalized_metric <- (partner_data$scale_metric - min_metric) / (max_metric - min_metric)
      
      # Create the base map
      map <- plot_ly() %>%
        layout(
          title = list(
            text = paste0("Geographic Network: ", exporter_name, " (", input$network_year, ") - Sized by ", metric_label),
            font = list(size = 16, color = "#172B4D", family = "Inter")
          ),
          geo = list(
            scope = 'world',
            projection = list(type = 'natural earth'),
            showland = TRUE,
            landcolor = toRGB("#F4F5F7"),
            coastlinecolor = toRGB("#DFE1E6"),
            showlakes = TRUE,
            lakecolor = toRGB("#DEEBFF"),
            showcountries = TRUE,
            countrycolor = toRGB("#DFE1E6"),
            countrywidth = 0.5,
            bgcolor = "#FFFFFF"
          ),
          paper_bgcolor = "#FFFFFF",
          margin = list(l = 0, r = 0, t = 50, b = 0)
        )
      
      # Add connection lines (edges)
      if (nrow(partner_data) > 0) {
        for (i in 1:nrow(partner_data)) {
          partner <- partner_data[i, ]
          
          map <- map %>%
            add_trace(
              type = "scattergeo",
              lon = c(exporter_coords$longitude, partner$longitude),
              lat = c(exporter_coords$latitude, partner$latitude),
              mode = "lines",
              line = list(
                width = partner$normalized_metric * 3 + 0.5,  # Scale line width
                color = "#DEEBFF"
              ),
              opacity = 0.6,
              showlegend = FALSE,
              hoverinfo = "skip"
            )
        }
      }
      
      # Create hover text based on metric (always 2 decimal places)
      if (metric == "participation") {
        hover_text <- paste0(
          "<b>", partner_data$country_name, "</b><br>",
          "GVC Participation: ", format(round(partner_data$bi_gvc_ratio, 2), nsmall = 2), "<br>",
          "Total GVC: ", sapply(partner_data$bilateral_gvc, format_value)
        )
      } else {
        hover_text <- paste0(
          "<b>", partner_data$country_name, "</b><br>",
          "Total GVC: ", sapply(partner_data$bilateral_gvc, format_value), "<br>",
          "GVC Participation: ", format(round(partner_data$bi_gvc_ratio, 2), nsmall = 2)
        )
      }
      
      # Add partner nodes
      map <- map %>%
        add_trace(
          type = "scattergeo",
          lon = partner_data$longitude,
          lat = partner_data$latitude,
          text = hover_text,
          hoverinfo = "text",
          mode = "markers",
          marker = list(
            size = partner_data$normalized_metric * 30 + 8,  # Scale marker size (min 8, max 38)
            color = "#0065FF",
            line = list(color = "#0747A6", width = 1),
            opacity = 0.8
          ),
          showlegend = FALSE
        )
      
      # Add central exporter node (on top)
      map <- map %>%
        add_trace(
          type = "scattergeo",
          lon = exporter_coords$longitude,
          lat = exporter_coords$latitude,
          text = paste0("<b>", exporter_name, "</b><br><i>Central Exporter</i>"),
          hoverinfo = "text",
          mode = "markers",
          marker = list(
            size = 25,
            color = "#ed2828",
            line = list(color = "#FFFFFF", width = 2),
            symbol = "circle"
          ),
          showlegend = FALSE
        )
      
      map %>%
        config(
          displayModeBar = TRUE,
          displaylogo = FALSE,
          modeBarButtonsToRemove = c("select2d", "lasso2d")
        )
    })
    
    # Dynamic UI for GVC Participation chart
    output$participation_chart_ui <- renderUI({
      ns <- session$ns
      chart_height <- max(400, input$top_n_partners * 35)
      plotlyOutput(ns("participation_chart"), height = paste0(chart_height, "px"))
    })
    
    # Dynamic UI for Total GVC chart
    output$total_gvc_chart_ui <- renderUI({
      ns <- session$ns
      chart_height <- max(400, input$top_n_partners * 35)
      plotlyOutput(ns("total_gvc_chart"), height = paste0(chart_height, "px"))
    })
    
    # Chart 1: Ranked by GVC Participation
    output$participation_chart <- renderPlotly({
      req(nrow(network_data()) > 0)
      
      # Sort by GVC Participation
      top_data <- network_data() %>%
        arrange(desc(bi_gvc_ratio)) %>%
        head(input$top_n_partners) %>%
        mutate(
          partner_name = sapply(country_j, function(x) country_names[x]),
          partner_name = factor(partner_name, levels = rev(partner_name))
        )
      
      # Create hover template
      hover_template <- paste0(
        "<b>%{y}</b><br>",
        "GVC Participation: %{x:.2f}<br>",
        "Total GVC: %{customdata}<br>",
        "<extra></extra>"
      )
      
      plot_ly(
        data = top_data,
        x = ~bi_gvc_ratio,
        y = ~partner_name,
        type = 'bar',
        orientation = 'h',
        customdata = sapply(top_data$bilateral_gvc, format_value),
        # FIXED: Show values inside bars with 2 decimals
        text = ~format(round(bi_gvc_ratio, 2), nsmall = 2),
        textposition = 'inside',
        textfont = list(color = 'white', size = 11),
        marker = list(
          color = '#0052CC',
          line = list(color = '#0747A6', width = 1)
        ),
        hovertemplate = hover_template
      ) %>%
        layout(
          xaxis = list(
            title = "GVC Participation",
            titlefont = list(size = 13, color = "#172B4D"),
            tickfont = list(size = 11, color = "#5E6C84"),
            gridcolor = "#DFE1E6",
            showgrid = TRUE,
            tickformat = ".2f",  # 2 decimal places
            range = c(0, 1)      # FIXED: Scale from 0.00 to 1.00
          ),
          yaxis = list(
            title = "",
            tickfont = list(size = 11, color = "#172B4D"),
            categoryorder = "array",
            categoryarray = rev(top_data$partner_name),
            # FIXED: More space between labels and bars
            ticklen = 0,
            tickwidth = 0,
            tickpad = 30
          ),
          # FIXED: Reduce left margin (less space to container edge)
          margin = list(l = 120, r = 30, t = 20, b = 50),
          paper_bgcolor = "#FFFFFF",
          plot_bgcolor = "#F4F5F7",
          hovermode = "closest",
          showlegend = FALSE
        ) %>%
        config(
          displayModeBar = TRUE,
          displaylogo = FALSE,
          modeBarButtonsToRemove = c(
            "pan2d", "select2d", "lasso2d", "autoScale2d", "toggleSpikelines"
          )
        )
    })
    
    # Chart 2: Ranked by Total GVC
    output$total_gvc_chart <- renderPlotly({
      req(nrow(network_data()) > 0)
      
      # Sort by Total GVC
      top_data <- network_data() %>%
        arrange(desc(bilateral_gvc)) %>%
        head(input$top_n_partners) %>%
        mutate(
          partner_name = sapply(country_j, function(x) country_names[x]),
          partner_name = factor(partner_name, levels = rev(partner_name)),
          # FIXED: Format values with 2 decimals for display
          display_value = sapply(bilateral_gvc, format_value)
        )
      
      # Create hover template
      hover_template <- paste0(
        "<b>%{y}</b><br>",
        "Total GVC: %{text}<br>",
        "GVC Participation: %{customdata:.2f}<br>",
        "<extra></extra>"
      )
      
      plot_ly(
        data = top_data,
        x = ~bilateral_gvc,
        y = ~partner_name,
        type = 'bar',
        orientation = 'h',
        # FIXED: Use formatted value for display and hover
        text = ~display_value,
        customdata = ~bi_gvc_ratio,
        textposition = 'inside',
        textfont = list(color = 'white', size = 11),
        marker = list(
          color = '#0052CC',
          line = list(color = '#0747A6', width = 1)
        ),
        hovertemplate = hover_template
      ) %>%
        layout(
          xaxis = list(
            title = "Total GVC (USD, billions)",
            titlefont = list(size = 13, color = "#172B4D"),
            tickfont = list(size = 11, color = "#5E6C84"),
            gridcolor = "#DFE1E6",
            showgrid = TRUE
          ),
          yaxis = list(
            title = "",
            tickfont = list(size = 11, color = "#172B4D"),
            categoryorder = "array",
            categoryarray = rev(top_data$partner_name),
            # FIXED: More space between labels and bars
            ticklen = 0,
            tickwidth = 0,
            tickpad = 15
          ),
          # FIXED: Reduce left margin (less space to container edge)
          margin = list(l = 120, r = 80, t = 20, b = 50),
          paper_bgcolor = "#FFFFFF",
          plot_bgcolor = "#F4F5F7",
          hovermode = "closest",
          showlegend = FALSE
        ) %>%
        config(
          displayModeBar = TRUE,
          displaylogo = FALSE,
          modeBarButtonsToRemove = c(
            "pan2d", "select2d", "lasso2d", "autoScale2d", "toggleSpikelines"
          )
        )
    })
  })
}