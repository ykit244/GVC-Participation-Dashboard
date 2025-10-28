# ============================================================================
# TAB 0: HOME - UI
# ============================================================================

tab0_home_ui <- function(id) {
  ns <- NS(id)
  
  tabItem(
    tabName = "home",
    
    # Hero Section
    fluidRow(
      box(
        width = 12,
        status = "info",
        solidHeader = FALSE,
        
        div(
          style = "text-align: center; padding: 40px 20px;",
          h1("Understanding Global Value Chain (GVC) Participation", 
             style = "color: #0052CC; font-weight: 700; font-size: 32px; margin-bottom: 20px;"),
          p("Measuring How Countries Integrate into Global Production Networks",
            style = "font-size: 18px; color: #5E6C84; font-weight: 500;")
        )
      )
    ),
    
    # What is GVC Section
    fluidRow(
      box(
        title = "WHAT IS THE GVC PARTICIPATION INDEX?",
        status = "info",
        solidHeader = TRUE,
        width = 12,
        
        p(style = "font-size: 15px; line-height: 1.8; text-align: justify;",
          "In today's interconnected global economy, products rarely come from a single country. An iPhone designed in California contains components from dozens of countries before being assembled in China and sold worldwide. The GVC Participation Index, developed by economists Alessandro Borin and Michele Mancini",tags$sup("1"),", measures how deeply a country is integrated into these complex international production networks."
        ),
        
        p(style = "font-size: 15px; line-height: 1.8; text-align: justify; margin-top: 15px;",
          "Unlike traditional trade statistics that simply count goods crossing borders, the GVC Participation Index identifies", 
          strong("GVC-related trade"),
          "—intermediate goods and services that cross at least two international borders before reaching final consumers. This captures the reality of modern manufacturing, where production is fragmented across multiple countries, each specializing in specific tasks or components."
        ),
        
        div(
          style = "background-color: #DEEBFF; padding: 20px; border-radius: 4px; margin-top: 20px; border-left: 4px solid #0052CC;",
          p(style = "font-size: 15px; margin: 0;",
            icon("info-circle"), " ",
            strong("Key Concept:"),
            " The index ranges from 0% to 100%, where higher values indicate greater involvement in global production networks. For instance, if Country A's manufacturing exports have a GVC participation rate of 35%, this means that 35% of the value of those exports consists of goods that will cross at least one more international border before final consumption."
          )
        )
      )
    ),
    
    # Why Bilateral Analysis
    fluidRow(
      box(
        title = "WHY BILATERAL ANALYSIS MATTERS",
        status = "info",
        solidHeader = TRUE,
        width = 12,
        
        p(style = "font-size: 15px; line-height: 1.8; text-align: justify;",
          "While many studies examine overall GVC participation at the country level, this research takes a",
          strong("bilateral approach"),
          "—analyzing trade relationships between specific country pairs. This matters because the benefits of GVC integration may differ substantially depending on whether a developing country exports to another developing country versus to an advanced economy."
        ),
        
        p(style = "font-size: 15px; line-height: 1.8; text-align: justify; margin-top: 15px;",
          "For example, when Vietnam exports electronics components to China (South-South integration), the convergence dynamics may differ from when Vietnam exports similar components to the United States (South-North integration). By examining bilateral relationships, we can identify which integration patterns offer the greatest development opportunities for countries at different income levels."
        )
      )
    ),
    
    # Practical Example
    fluidRow(
      box(
        title = "HOW IT WORKS: A PRACTICAL EXAMPLE",
        status = "info",
        solidHeader = TRUE,
        width = 12,
        
        h4("Laptop Production Chain", style = "color: #0052CC; font-weight: 600; margin-bottom: 20px;"),
        
        # Visual diagram
        div(
          style = "background-color: #F4F5F7; padding: 30px; border-radius: 4px; margin-bottom: 25px;",
          HTML('
            <div style="display: flex; justify-content: space-around; align-items: center; flex-wrap: wrap;">
              <div style="text-align: center; margin: 10px;">
                <div style="background-color: #0052CC; color: white; padding: 20px; border-radius: 8px; min-width: 150px;">
                  <strong style="font-size: 16px;">THAILAND</strong><br>
                  <span style="font-size: 14px;">Hard Drive<br>Production<br><strong>$50</strong></span>
                </div>
              </div>
              <div style="font-size: 30px; color: #0052CC; margin: 10px;">→</div>
              <div style="text-align: center; margin: 10px;">
                <div style="background-color: #0065FF; color: white; padding: 20px; border-radius: 8px; min-width: 150px;">
                  <strong style="font-size: 16px;">MALAYSIA</strong><br>
                  <span style="font-size: 14px;">Assembly +<br>Components<br><strong>$150</strong></span>
                </div>
              </div>
              <div style="font-size: 30px; color: #0052CC; margin: 10px;">→</div>
              <div style="text-align: center; margin: 10px;">
                <div style="background-color: #0747A6; color: white; padding: 20px; border-radius: 8px; min-width: 150px;">
                  <strong style="font-size: 16px;">UNITED STATES</strong><br>
                  <span style="font-size: 14px;">Final Sale<br><strong>$150</strong></span>
                </div>
              </div>
            </div>
          ')
        ),
        
        h5("Scenario:", style = "color: #172B4D; font-weight: 600; margin-top: 20px;"),
        tags$ul(
          style = "font-size: 15px; line-height: 1.8;",
          tags$li(strong("Thailand"), " produces a hard drive worth $50"),
          tags$li(strong("Malaysia"), " imports Thailand's hard drive, adds assembly and other components worth $100, creating a laptop worth $150"),
          tags$li(strong("United States"), " imports Malaysia's laptop for final sale at $150")
        ),
        
        h5("Key Insight:", style = "color: #172B4D; font-weight: 600; margin-top: 25px;"),
        div(
          style = "background-color: #FFF4E5; padding: 20px; border-radius: 4px; border-left: 4px solid #FF8B00;",
          p(style = "font-size: 15px; margin: 0;",
            icon("exclamation-triangle"), " ",
            strong("The Problem with Traditional Statistics:"),
            " Thailand's $50 hard drive is counted twice—once when Thailand ships it to Malaysia, and again when Malaysia ships the finished laptop (which contains that hard drive) to the United States."
          )
        )
      )
    ),
    
    # Breaking Down Malaysia's Exports
    fluidRow(
      box(
        title = "BREAKING DOWN MALAYSIA'S EXPORTS",
        status = "info",
        solidHeader = TRUE,
        width = 12,
        
        h5("Malaysia's $150 Export to the US Contains:", 
           style = "color: #172B4D; font-weight: 600; margin-bottom: 20px;"),
        
        fluidRow(
          column(
            width = 6,
            div(
              style = "background-color: #DEEBFF; padding: 25px; border-radius: 8px; height: 100%; border-left: 5px solid #0052CC;",
              h4("$100", style = "color: #0052CC; font-weight: 700; margin-top: 0;"),
              p(style = "font-size: 14px; margin-bottom: 5px;", 
                strong("DAVAX (Directly Absorbed Value-Added)")),
              p(style = "font-size: 13px; color: #5E6C84; line-height: 1.6;",
                "Malaysia's own assembly work and components that won't cross any more borders"),
              p(style = "font-size: 12px; margin-top: 10px; margin-bottom: 0;",
                icon("tag"), " ", em("Traditional trade"))
            )
          ),
          column(
            width = 6,
            div(
              style = "background-color: #E3FCEF; padding: 25px; border-radius: 8px; height: 100%; border-left: 5px solid #00875A;",
              h4("$50", style = "color: #00875A; font-weight: 700; margin-top: 0;"),
              p(style = "font-size: 14px; margin-bottom: 5px;", 
                strong("GVC-Related Trade")),
              p(style = "font-size: 13px; color: #5E6C84; line-height: 1.6;",
                "Thailand's hard drive that crossed Thailand→Malaysia→US (two borders)"),
              p(style = "font-size: 12px; margin-top: 10px; margin-bottom: 0;",
                icon("tag"), " ", em("Production fragmentation"))
            )
          )
        ),
        
        div(
          style = "background-color: #F4F5F7; padding: 20px; border-radius: 4px; margin-top: 25px; text-align: center;",
          h3(style = "color: #0052CC; font-weight: 700; margin: 0;",
             "GVC Participation Rate = 33.3%"),
          p(style = "font-size: 14px; color: #5E6C84; margin-top: 10px; margin-bottom: 0;",
            "$50 (GVC-Related) ÷ $150 (Total Exports)")
        )
      )
    ),
    
    # Two Components
    fluidRow(
      column(
        width = 6,
        box(
          title = "BACKWARD PARTICIPATION",
          status = "primary",
          solidHeader = TRUE,
          width = NULL,
          
          div(
            style = "text-align: center; padding: 20px;",
            icon("arrow-left", class = "fa-3x", style = "color: #0052CC;"),
            h4(style = "color: #172B4D; margin-top: 15px; font-weight: 600;", 
               "Foreign Inputs in Exports"),
            p(style = "font-size: 14px; color: #5E6C84; line-height: 1.6; margin-top: 15px;",
              "Measures how much ", strong("foreign value-added"), " is embedded in a country's exports. In our example, Malaysia's backward participation is ", 
              strong("33.3%"), " because one-third of its export value to the US consists of foreign inputs (Thailand's hard drive).")
          )
        )
      ),
      column(
        width = 6,
        box(
          title = "FORWARD PARTICIPATION",
          status = "primary",
          solidHeader = TRUE,
          width = NULL,
          
          div(
            style = "text-align: center; padding: 20px;",
            icon("arrow-right", class = "fa-3x", style = "color: #00875A;"),
            h4(style = "color: #172B4D; margin-top: 15px; font-weight: 600;", 
               "Exports for Re-export"),
            p(style = "font-size: 14px; color: #5E6C84; line-height: 1.6; margin-top: 15px;",
              "Measures how much of a country's ", strong("domestic value-added"), " is re-exported by trading partners. Thailand's forward participation is ", 
              strong("100%"), " because all of its hard drive exports to Malaysia are used in products that Malaysia re-exports.")
          )
        )
      )
    ),
    # Advanced Technical Details (Expandable)
    fluidRow(
      box(
        title = "ADVANCED TECHNICAL DETAILS",
        status = "info",
        solidHeader = TRUE,
        width = 12,
        collapsible = TRUE,
        collapsed = TRUE,
        
        div(
          style = "padding: 20px;",
          
          h4("Mathematical Framework", style = "color: #0052CC; font-weight: 600; margin-bottom: 15px;"),
          
          p(style = "font-size: 14px; line-height: 1.8; text-align: justify;",
            "The GVC Participation Index builds on ", strong("input-output analysis"),", which tracks how industries within and across countries supply inputs to each other. The foundation is the Leontief inverse matrix, derived from inter-country input-output (ICIO) tables."
          ),
          
          h5("Key Equation for Bilateral GVC Participation:", 
             style = "color: #172B4D; font-weight: 600; margin-top: 25px; margin-bottom: 15px;"),
          
          div(
            style = "background-color: #F4F5F7; padding: 20px; border-radius: 4px; text-align: center; margin-bottom: 20px;",
            withMathJax(),
            helpText("$$\\text{GVC}_{sr} = \\frac{\\text{GVCX}_{sr}}{E_{sr}} = \\frac{E_{sr} - \\text{DAVAX}_{sr}}{E_{sr}}$$")
          ),
          
          p(style = "font-size: 14px; line-height: 1.8;", strong("Where:")),
          tags$ul(
            style = "font-size: 14px; line-height: 1.8;",
            tags$li(HTML("\\(E_{sr}\\) = gross exports from country \\(s\\) to country \\(r\\)")),
            tags$li(HTML("\\(\\text{DAVAX}_{sr}\\) = Directly Absorbed Value-Added eXports (value-added that does NOT cross any additional borders)")),
            tags$li(HTML("\\(\\text{GVCX}_{sr}\\) = GVC-related exports (everything that WILL cross at least one more border)"))
          ),
          
          h5("DAVAX Calculation:", 
             style = "color: #172B4D; font-weight: 600; margin-top: 25px; margin-bottom: 15px;"),
          
          div(
            style = "background-color: #F4F5F7; padding: 20px; border-radius: 4px; text-align: center; margin-bottom: 20px;",
            helpText("$$\\text{DAVAX}_{sr} = V_s(I-A_{ss})^{-1}Y_{sr} + V_s(I-A_{ss})^{-1}A_{sr}(I-A_{rr})^{-1}Y_{rr}$$")
          ),
          
          p(style = "font-size: 14px; line-height: 1.8; text-align: justify;",
            "The first term captures domestic value-added in final goods directly consumed in country ", HTML("\\(r\\)"), 
            ". The second term represents domestic value-added in intermediate goods processed in country ", HTML("\\(r\\)"), 
            " and consumed there as final goods without crossing other borders."
          ),
          
          h5("GVC Participation Decomposition:", 
             style = "color: #172B4D; font-weight: 600; margin-top: 25px; margin-bottom: 15px;"),
          
          div(
            style = "background-color: #F4F5F7; padding: 20px; border-radius: 4px; text-align: center; margin-bottom: 20px;",
            helpText("$$\\text{GVC}_{sr} = \\text{GVC}^{\\text{backward}}_{sr} + \\text{GVC}^{\\text{forward}}_{sr}$$")
          ),
          
          h5("Backward Participation (foreign value-added in exports):", 
             style = "color: #172B4D; font-weight: 600; margin-top: 25px; margin-bottom: 15px;"),
          
          div(
            style = "background-color: #F4F5F7; padding: 20px; border-radius: 4px; text-align: center; margin-bottom: 20px;",
            helpText("$$\\text{GVC}^{\\text{backward}}_{sr} = \\frac{V_s(I-A_{ss})^{-1}\\sum_{j \\neq s}A_{sj}B_{js}E_{sr} + \\sum_{t \\neq s}V_tB_{ts}E_{sr}}{E_{sr}}$$")
          ),
          
          h5("Notation:", 
             style = "color: #172B4D; font-weight: 600; margin-top: 25px; margin-bottom: 15px;"),
          
          tags$ul(
            style = "font-size: 14px; line-height: 1.8;",
            tags$li(HTML("\\(GVC_{sr}^{\\text{backward}}\\): Backward GVC participation of country \\(s\\) in exports to \\(r\\)")),
            tags$li(HTML("\\(V_s\\), \\(V_t\\): Value-added coefficient vector for country \\(s\\) or \\(t\\) respectively")),
            tags$li(HTML("\\(L_{ss} = (I - A_{ss})^{-1}\\): Domestic Leontief inverse for country \\(s\\)")),
            tags$li(HTML("\\(A_{sj}\\): Technical coefficient matrix (intermediate inputs from \\(s\\) to \\(j\\))")),
            tags$li(HTML("\\(B = (I - A)^{-1}\\): The <strong>global</strong> Leontief inverse matrix")),
            tags$li(HTML("\\(B_{js}\\), \\(B_{ts}\\): Blocks of the global Leontief inverse, tracing inputs from \\(j\\) or \\(t\\) required for one unit of final demand in \\(s\\)")),
            tags$li(HTML("\\(E_{sr}\\): Total gross exports from country \\(s\\) to country \\(r\\)"))
          ),
          
          h5("Forward Participation (domestic value-added re-exported by partners):", 
             style = "color: #172B4D; font-weight: 600; margin-top: 25px; margin-bottom: 15px;"),
          
          div(
            style = "background-color: #F4F5F7; padding: 20px; border-radius: 4px; text-align: center; margin-bottom: 20px;",
            helpText("$$\\text{GVC}^{\\text{forward}}_{sr} = \\frac{V_s(I-A_{ss})^{-1}A_{sr}(I-A_{rr})^{-1}\\left(\\sum_{j \\neq r}Y_{rj} + \\sum_{j \\neq r}A_{rj}\\sum_k\\sum_{l \\neq s}B_{jk}Y_{kl}\\right)}{E_{sr}}$$"),
            helpText(
              style = "margin-top: 15px; font-style: italic; line-height: 1.6;",
              "$$\\text{GVC}^{\\text{forward}}_{sr} = \\frac{\\text{Value-added from } s \\text{ contained in } r\\text{'s exports to the world}}{\\text{Total gross exports from } s \\text{ to } r}$$"
            )
          ),
          
          h5("Notation:", 
             style = "color: #172B4D; font-weight: 600; margin-top: 25px; margin-bottom: 15px;"),
          
          tags$ul(
            style = "font-size: 14px; line-height: 1.8;",
            tags$li(HTML("\\(GVC_{sr}^{\\text{forward}}\\): Forward GVC participation of country \\(s\\) via country \\(r\\)")),
            tags$li(HTML("\\(V_s\\): Value-added coefficient vector for country \\(s\\)")),
            tags$li(HTML("\\(A_{sr}\\): Technical coefficient matrix (intermediate inputs from \\(s\\) to \\(r\\))")),
            tags$li(HTML("\\((I - A_{ss})^{-1}\\): Domestic Leontief inverse for country \\(s\\)")),
            tags$li(HTML("\\((I - A_{rr})^{-1}\\): Domestic Leontief inverse for country \\(r\\)")),
            tags$li(HTML("\\(Y_{rj}\\): Final demand in country \\(j\\) for goods from country \\(r\\)")),
            tags$li(HTML("\\(A_{rj}\\): Technical coefficient matrix (intermediate inputs from \\(r\\) to \\(j\\))")),
            tags$li(HTML("\\(B = (I - A)^{-1}\\): The <strong>global</strong> Leontief inverse matrix")),
            tags$li(HTML("\\(E_{sr}\\): Total gross exports from country \\(s\\) to country \\(r\\)"))
          ),
          
          # div(
          #   style = "background-color: #DEEBFF; padding: 20px; border-radius: 4px; margin-top: 25px; border-left: 4px solid #0052CC;",
          #   p(style = "font-size: 14px; margin: 0; line-height: 1.6;",
          #     icon("info-circle"), " ",
          #     strong("Methodology Note:"),
          #     " This framework follows the ", strong("exporting country perspective"), " with a ", 
          #     strong("source-based approach"), ", meaning value-added is attributed to the first country it leaves, and subsequent border crossings of the same value are classified as double-counted."
          #   )
          # )
        )
      )
    ),
    
    # Key Insights
    fluidRow(
      box(
        #title = "KEY INSIGHTS FROM BILATERAL ANALYSIS",tags$sup("2"),"",
        title = HTML("KEY INSIGHTS FROM BILATERAL ANALYSIS<sup>2</sup>"),
        status = "info",
        solidHeader = TRUE,
        width = 12,
        
        div(
          style = "margin-bottom: 20px;",
          div(
            style = "background-color: #E3FCEF; padding: 20px; border-radius: 4px; margin-bottom: 15px; border-left: 4px solid #00875A;",
            h5(icon("chart-line"), " Finding 1: South-South Integration Benefits", 
               style = "color: #00875A; font-weight: 600; margin-top: 0;"),
            p(style = "font-size: 14px; line-height: 1.6; margin-bottom: 0;",
              "When lower-income countries (like Vietnam, Bangladesh, or Kenya) export intermediate goods to other developing countries, they experience statistically significant income convergence effects. Surprisingly, these South-South convergence effects are often stronger than South-North integration patterns.")
          ),
          
          div(
            style = "background-color: #DEEBFF; padding: 20px; border-radius: 4px; margin-bottom: 15px; border-left: 4px solid #0052CC;",
            h5(icon("globe"), " Finding 2: All Integration Types Help", 
               style = "color: #0052CC; font-weight: 600; margin-top: 0;"),
            p(style = "font-size: 14px; line-height: 1.6; margin-bottom: 0;",
              "Whether countries integrate with partners at similar or different income levels, GVC participation consistently generates long-term convergence effects—though the magnitude and speed vary.")
          ),
          
          div(
            style = "background-color: #FFF4E5; padding: 20px; border-radius: 4px; border-left: 4px solid #FF8B00;",
            h5(icon("clock"), " Finding 3: Temporal Dynamics Matter", 
               style = "color: #FF8B00; font-weight: 600; margin-top: 0;"),
            p(style = "font-size: 14px; line-height: 1.6; margin-bottom: 0;",
              "Some country-pair combinations (particularly involving lower-middle-income exporters) show initial divergence but ultimately converge over time, demonstrating that GVC benefits accumulate gradually.")
          )
        )
      )
    ),
    
    # Call to Action
    # fluidRow(
    #   box(
    #     width = 12,
    #     status = "primary",
    #     solidHeader = FALSE,
    #     
    #     div(
    #       style = "text-align: center; padding: 30px;",
    #       h3("Ready to Explore the Data?", 
    #          style = "color: #0052CC; font-weight: 700; margin-bottom: 20px;"),
    #       p(style = "font-size: 16px; color: #5E6C84; margin-bottom: 25px;",
    #         "Dive into our interactive dashboard to analyze bilateral GVC participation patterns across 76 economies from 1995-2015."),
    #       actionButton(
    #         ns("goto_overview"),
    #         "Start Exploring →",
    #         class = "btn-warning",
    #         style = "font-size: 16px; padding: 12px 40px; font-weight: 600;"
    #       )
    #     )
    #   )
    # ),
    
    p(
      style = "font-size: 13px; line-height: 1.6; text-align: justify; margin-top: 20px;",
      tags$sup("1"),
      " Borin, Alessandro, and Michele Mancini. 2023. “Measuring What Matters in Value-added Trade.” ",
      tags$em("Economic Systems Research"), " 35 (4): 586–613. ",
      a(href = "https://doi.org/10.1080/09535314.2022.2153221", 
        "https://doi.org/10.1080/09535314.2022.2153221", target = "_blank")
    ),
    p(
      style = "font-size: 13px; line-height: 1.6; text-align: justify; margin-top: 20px;",
      tags$sup("2"),
      " NG, Wai Kit. ",tags$em("Production Fragmentation in Manufacturing and Its Differential Impact on High- and Low-Income Economies"),". 
      Praha, 2025. 97 s. Master’s thesis (Mgr). Charles University, Faculty of Social Sciences, Institute of Economic Studies. 
      Supervisor Mgr. Michal Paulus. ",
      a(href = "https://dspace.cuni.cz/handle/20.500.11956/201240",
        "https://dspace.cuni.cz/handle/20.500.11956/201240", target = "_blank")
    )
  )
}
