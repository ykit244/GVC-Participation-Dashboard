
# GVC Dashboard

An interactive Shiny dashboard for visualizing and analyzing Global Value Chain (GVC) participation patterns in international trade.
🔍 Visit the dashboard here: https://ykit244.shinyapps.io/gvc-dashboard/

## Overview

This dashboard provides comprehensive insights into bilateral trade relationships through the lens of global value chains, enabling researchers and policymakers to understand how countries integrate into international production networks.

## Key Features

### 📊 Overview Tab
- Summary statistics for 76 economies across the manufacturing sector
- Interactive data table with filtering and search capabilities

### 🌍 Network Analysis Tab
- **Geographic Network Map**: Interactive world map visualizing trade relationships with node sizes and connection lines scaled by selected metrics
- **Dual Ranking Charts**: Side-by-side comparison of top trading partners ranked by:
  - GVC Participation (integration depth)
  - Total GVC (absolute trade value)
- Dynamic controls for customizing partner count (5-30) and visualization metrics

## Data Specifications

- **Economies**: 76 countries worldwide
- **Sector**: Manufacturing (OECD 2023 definition)
- **Time Period**: 1995-2020 (26 years)
- **Metrics**: 
  - Forward Linkage (GVCF): Domestic value-added embedded in other countries' exports
  - Backward Linkage (GVCB): Foreign value-added embedded in domestic exports
  - GVC Participation Index: Integration depth into global value chains

## Coming soon
- **Time Series Analysis** tracking GVC participation evolution and structural changes
- **Economic Analysis** examining GDP-GVC correlations through scatter plots. 

## Installation

### Prerequisites
```r
install.packages(c("shiny", "shinydashboard", "shinyjs", "DT", 
                   "dplyr", "plotly", "visNetwork", "tidyr"))
```

### Running the App
```r
shiny::runApp()
```

## Project Structure
```
├── global.R              # Data loading and global configurations
├── server.R              # Main server logic
├── ui.R                  # Main UI structure
├── modules/              # Modular components for each tab
├── www/                  # Custom CSS and JavaScript
└── Data Source/          # OECD TiVA bilateral GVC data
```
**Note:**  
> The data source is not attached to the repo. Request access via **ykit244@gmail.com**.

## Use Cases

- **Academic Research**: Analyze GVC integration patterns and trade relationships
- **Policy Analysis**: Identify key trading partners and assess economic dependencies
- **Trade Strategy**: Compare integration depth vs. trade volume across partners
- **Economic Geography**: Visualize spatial patterns in global production networks

## Credits

Dashboard developed for GVC research analysis. Data source: OECD. 2023. “Inter-Country Input-Output Tables.” Data set. OECD. https://www.oecd.org/en/data/datasets/inter-country-input-output-tables.html. 
## License

This project is for research and educational purposes.
