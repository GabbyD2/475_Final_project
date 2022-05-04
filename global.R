#install.packages("shinydashboard")


library(fpp3)
library(readr)
library(shiny)
library(seasonal)
library(shinydashboard)
# Data starts in 3rd row, skip first 2 rows
g_trends <- read.csv('multiTimeline.csv', skip = 2)
# Rename columns
names(g_trends) <- c("Month", "Interest")
# Convert Month to date
g_trends$Month <- yearmonth(g_trends$Month)
# Convert to tsibble
g_trends <- tsibble(g_trends)

#autoplot(g_trends)

