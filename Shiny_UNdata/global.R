library(shiny)
library(tidyverse)
gdp_le <- read_csv("data/gdp_le.csv")
gdp_le <- gdp_le |>
  drop_na()
gdp_le<- gdp_le |> mutate(Log_GDP_Per_capita = log10(GDP_Per_capita))

countries <- gdp_le |>
  pull(Country) |>
  unique() |>
  sort()

continents <- gdp_le |>
  pull(Continent) |>
  unique() |>
  sort()

years <- gdp_le |>
  pull(Year) |>
  unique() |>
  sort()
