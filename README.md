# AssignmentB3-Ghirmay-Teklemichael


# BC Wildfire Data Explorer

## Overview

This R Shiny application allows users to explore historical wildfire
incidents in British Columbia from 1950 to 2025.

Users can select a year range and wildfire cause to explore wildfire
incident records through interactive visualizations and tables.

This application was developed for STAT 545 Assignment B3.

## Main Features

There are three main features of this application:

- **Feature 1: Dynamic Plot**  
  A bar plot showing the annual number of wildfire incidents that
  automatically updates based on the selected year range and wildfire cause.

- **Feature 2: Dynamic Table**  
  An interactive table displaying filtered wildfire records, including
  fire number, year, cause, type, and size. Users can also search and
  sort the table.

- **Feature 3: CSV Download**  
  A download button that allows users to export wildfire records
  matching the selected year range and cause as a CSV file.

## Data Source

The data were obtained from the BC Data Catalogue using the
`bcdata` R package.

- Dataset: [BC Wildfire Fire Incident Locations - Historical](https://catalogue.data.gov.bc.ca/dataset/e2dadc60-292f-4d98-b42b-56ca9e4fe694)
- Number of records: 200,479
- Year range: 1950–2025
- Licence: Open Government Licence - British Columbia

The dataset includes confirmed fires, suspected fires, nuisance fires,
and other reported incidents. Therefore, the number of incidents
does not necessarily represent the number of confirmed wildfires.

## Required R Packages

- shiny
- tidyverse
- DT

## Run the Application Locally

Clone this repository, open the RStudio project, and run:

```r
install.packages(c("shiny", "tidyverse", "DT"))
shiny::runApp()
```

## Deployed Application

You can access the application here:

[BC Wildfire Data Explorer](https://public-health-wildfire-data.shinyapps.io/bc-wildfire-explorer/)

