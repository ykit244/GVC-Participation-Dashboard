# ============================================================================
# GVC Dashboard - Global Configuration
# ============================================================================
# This file loads libraries, data, and defines global variables/functions
# that are shared across all modules

# ============================================================================
# LIBRARIES
# ============================================================================

library(shiny)
library(shinydashboard)
library(shinyjs)
library(DT)
library(dplyr)
library(plotly)
library(visNetwork)
library(tidyr)

# ============================================================================
# LOAD DATA
# ============================================================================

#setwd("C:/Users/user/OneDrive/Documents/GitHub/GVC Participation Index Dashboard")
data <- read.csv("Data Source/bilateral gvc data.csv")

# Prepare data
data <- data %>%
  select(-X)  # Remove row number column if exists

# ============================================================================
# LOAD COUNTRY COORDINATES FOR MAP VISUALIZATION
# ============================================================================

# Create country coordinates data frame
country_coords <- data.frame(
  country_code = c("ARG", "AUS", "AUT", "BEL", "BGD", "BGR", "BLR", "BRA", "BRN", "CAN",
                   "CHE", "CHL", "CHN", "CIV", "CMR", "COL", "CRI", "CYP", "CZE", "DEU",
                   "DNK", "EGY", "ESP", "EST", "FIN", "FRA", "GBR", "GRC", "HKG", "HRV",
                   "HUN", "IDN", "IND", "IRL", "ISL", "ISR", "ITA", "JOR", "JPN", "KAZ",
                   "KHM", "KOR", "LAO", "LTU", "LUX", "LVA", "MAR", "MEX", "MLT", "MMR",
                   "MYS", "NLD", "NOR", "NZL", "PAK", "PER", "PHL", "POL", "PRT", "ROU",
                   "RUS", "SAU", "SGP", "SVK", "SVN", "SWE", "THA", "TUN", "TUR", "TWN",
                   "UKR", "USA", "VNM", "ZAF"),
  country_name = c("Argentina", "Australia", "Austria", "Belgium", "Bangladesh", "Bulgaria", "Belarus", "Brazil", "Brunei", "Canada",
                   "Switzerland", "Chile", "China", "Côte d'Ivoire", "Cameroon", "Colombia", "Costa Rica", "Cyprus", "Czech Republic", "Germany",
                   "Denmark", "Egypt", "Spain", "Estonia", "Finland", "France", "United Kingdom", "Greece", "Hong Kong", "Croatia",
                   "Hungary", "Indonesia", "India", "Ireland", "Iceland", "Israel", "Italy", "Jordan", "Japan", "Kazakhstan",
                   "Cambodia", "South Korea", "Laos", "Lithuania", "Luxembourg", "Latvia", "Morocco", "Mexico", "Malta", "Myanmar",
                   "Malaysia", "Netherlands", "Norway", "New Zealand", "Pakistan", "Peru", "Philippines", "Poland", "Portugal", "Romania",
                   "Russia", "Saudi Arabia", "Singapore", "Slovakia", "Slovenia", "Sweden", "Thailand", "Tunisia", "Turkey", "Taiwan",
                   "Ukraine", "United States", "Vietnam", "South Africa"),
  latitude = c(-38.4161, -25.2744, 47.5162, 50.5039, 23.6850, 42.7339, 53.7098, -14.2350, 4.5353, 56.1304,
               46.8182, -35.6751, 35.8617, 7.5400, 7.3697, 4.5709, 9.7489, 35.1264, 49.8175, 51.1657,
               56.2639, 26.8206, 40.4637, 58.5953, 61.9241, 46.2276, 55.3781, 39.0742, 22.3193, 45.1,
               47.1625, -0.7893, 20.5937, 53.4129, 64.9631, 31.0461, 41.8719, 30.5852, 36.2048, 48.0196,
               12.5657, 35.9078, 19.8563, 55.1694, 49.8153, 56.8796, 31.7917, 23.6345, 35.9375, 21.9162,
               4.2105, 52.1326, 60.4720, -40.9006, 30.3753, -9.1900, 12.8797, 51.9194, 39.3999, 45.9432,
               61.5240, 23.8859, 1.3521, 48.6690, 46.1512, 60.1282, 15.8700, 33.8869, 38.9637, 23.6978,
               48.3794, 37.0902, 14.0583, -30.5595),
  longitude = c(-63.6167, 133.7751, 14.5501, 4.4699, 90.3563, 25.4858, 27.9534, -51.9253, 114.7277, -106.3468,
                8.2275, -71.5430, 104.1954, -5.5471, 12.3547, -74.2973, -83.7534, 33.4299, 15.4730, 10.4515,
                9.5018, 30.8025, -3.7492, 25.0136, 25.7482, 2.2137, -3.4360, 21.8243, 114.1694, 15.2,
                19.5033, 113.9213, 78.9629, -8.2439, -19.0208, 34.8516, 12.5674, 36.2384, 138.2529, 66.9237,
                104.9910, 127.7669, 102.4955, 23.8813, 6.1296, 24.6032, -7.0926, -102.5528, 14.3754, 95.9560,
                101.9758, 5.2913, 8.4689, 174.8860, 69.3451, -75.0152, 121.7740, 19.1451, -8.2245, 24.9668,
                105.3188, 45.0792, 103.8198, 19.6990, 14.9955, 18.6435, 100.9925, 9.5375, 35.2433, 120.9605,
                31.1656, -95.7129, 108.2772, 22.9375)
)

# ============================================================================
# COUNTRY MAPPING
# ============================================================================

country_names <- c(
  "ARG" = "Argentina", "AUS" = "Australia", "AUT" = "Austria", "BEL" = "Belgium",
  "BGD" = "Bangladesh", "BGR" = "Bulgaria", "BLR" = "Belarus", "BRA" = "Brazil",
  "BRN" = "Brunei", "CAN" = "Canada", "CHE" = "Switzerland", "CHL" = "Chile",
  "CHN" = "China", "CIV" = "Côte d'Ivoire", "CMR" = "Cameroon", "COL" = "Colombia",
  "CRI" = "Costa Rica", "CYP" = "Cyprus", "CZE" = "Czech Republic", "DEU" = "Germany",
  "DNK" = "Denmark", "EGY" = "Egypt", "ESP" = "Spain", "EST" = "Estonia",
  "FIN" = "Finland", "FRA" = "France", "GBR" = "United Kingdom", "GRC" = "Greece",
  "HKG" = "Hong Kong", "HRV" = "Croatia", "HUN" = "Hungary", "IDN" = "Indonesia",
  "IND" = "India", "IRL" = "Ireland", "ISL" = "Iceland", "ISR" = "Israel",
  "ITA" = "Italy", "JOR" = "Jordan", "JPN" = "Japan", "KAZ" = "Kazakhstan",
  "KHM" = "Cambodia", "KOR" = "South Korea", "LAO" = "Laos", "LTU" = "Lithuania",
  "LUX" = "Luxembourg", "LVA" = "Latvia", "MAR" = "Morocco", "MEX" = "Mexico",
  "MLT" = "Malta", "MMR" = "Myanmar", "MYS" = "Malaysia", "NLD" = "Netherlands",
  "NOR" = "Norway", "NZL" = "New Zealand", "PAK" = "Pakistan", "PER" = "Peru",
  "PHL" = "Philippines", "POL" = "Poland", "PRT" = "Portugal", "ROU" = "Romania",
  "RUS" = "Russia", "SAU" = "Saudi Arabia", "SGP" = "Singapore", "SVK" = "Slovakia",
  "SVN" = "Slovenia", "SWE" = "Sweden", "THA" = "Thailand", "TUN" = "Tunisia",
  "TUR" = "Turkey", "TWN" = "Taiwan", "UKR" = "Ukraine", "USA" = "United States",
  "VNM" = "Vietnam", "ZAF" = "South Africa"
)

# ============================================================================
# FILTER OPTIONS
# ============================================================================

# Get unique values for filters
countries_i <- sort(unique(data$country_i))
countries_j <- sort(unique(data$country_j))
years <- sort(unique(data$year))

# Create named vectors for selectize options
country_choices_i <- setNames(
  countries_i, 
  sapply(countries_i, function(x) paste0(country_names[x], " (", x, ")"))
)
country_choices_j <- setNames(
  countries_j, 
  sapply(countries_j, function(x) paste0(country_names[x], " (", x, ")"))
)

# ============================================================================
# HELPER FUNCTIONS
# ============================================================================

# Function to get country full name
get_country_name <- function(code) {
  return(country_names[code])
}

# Function to format large numbers
format_number <- function(x, decimals = 2) {
  format(round(x, decimals), big.mark = ",", scientific = FALSE)
}