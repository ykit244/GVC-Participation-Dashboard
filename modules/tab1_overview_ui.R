# ============================================================================
# TAB 1: OVERVIEW - UI
# ============================================================================

tab1_overview_ui <- function(id) {
  ns <- NS(id)
  
  tabItem(
    tabName = "overview",
    
    h2("Overview", class = "page-title"),
    
    # Summary boxes
    fluidRow(
      column(
        width = 3,
        div(
          onclick = "showValueBoxModal('economies')",
          style = "cursor: pointer;",
          valueBox(
            value = 76,
            subtitle = "ECONOMIES",
            icon = icon("globe"),
            color = "blue",
            width = NULL
          )
        )
      ),
      column(
        width = 3,
        div(
          onclick = "showValueBoxModal('sector')",
          style = "cursor: pointer;",
          valueBox(
            value = "Manufacturing",
            subtitle = "SECTOR",
            icon = icon("industry"),
            color = "aqua",
            width = NULL
          )
        )
      ),
      column(
        width = 3,
        div(
          onclick = "showValueBoxModal('years')",
          style = "cursor: pointer;",
          valueBox(
            value = "1995-2020",
            subtitle = "YEARS",
            icon = icon("calendar"),
            color = "navy",
            width = NULL
          )
        )
      )
      #,
      # column(
      #   width = 3,
      #   div(
      #     onclick = "showValueBoxModal('pairs')",
      #     style = "cursor: pointer;",
      #     valueBox(
      #       value = "119,700",
      #       subtitle = "BILATERAL PAIRS",
      #       icon = icon("exchange-alt"),
      #       color = "light-blue",
      #       width = NULL
      #     )
      #   )
      # )
    ),
    
    # Filters
    fluidRow(
      box(
        title = "FILTERS",
        status = "info",
        solidHeader = TRUE,
        width = 12,
        
        fluidRow(
          column(
            width = 3,
            selectizeInput(
              ns("filter_exporter"),
              "Exporter:",
              choices = c("All Exporters" = "all", country_choices_i),
              selected = "all",
              options = list(placeholder = 'Select an exporter')
            )
          ),
          column(
            width = 3,
            selectizeInput(
              ns("filter_importer"),
              "Importer:",
              choices = c("All Importers" = "all", country_choices_j),
              selected = "all",
              options = list(placeholder = 'Select an importer')
            )
          ),
          column(
            width = 3,
            selectizeInput(
              ns("filter_year"),
              "Year:",
              choices = c("All Years" = "all", setNames(years, years)),
              selected = "all"
            )
          ),
          column(
            width = 3,
            br(),
            actionButton(
              ns("reset_filters"),
              "Reset Filters",
              icon = icon("redo"),
              class = "btn-warning",
              style = "margin-top: 0px;"
            )
          )
        )
      )
    ),
    
    # Data table
    fluidRow(
      box(
        title = "BILATERAL GVC DATA",
        status = "info",
        solidHeader = TRUE,
        width = 12,
        
        DTOutput(ns("data_table"))
      )
    )
  )
}