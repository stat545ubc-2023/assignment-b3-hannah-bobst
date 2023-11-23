# README: assignment-b3-hannah-bobst

This repository contains a project for a shiny app exploring the *penguins* data set from the *palmerpenguins* package. The exploration includes a boxplot, scatterplot, and summary table of means. 

* The boxplot is created using one numerical variable grouped by species. The user may use a drop-down menu to specify which numerical variable should be plotted. This drop-down menu ensures that only numerical variables are selected. 

* The scatterplot is created using two numerical variables grouped by species. The user may use two drop-down menus to specify which numerical variables should be plotted. The user may also use a slider to specify which year should be used. The drop-down menus ensure that only two numerical variables are selected at a time. The slider ensures that only one of the three possible years is selected.

* The summary table of means uses the numerical variables grouped by species. The user may use the single check box to specify whether the table should also be grouped by sex, with the default being False. The single check box ensures that only one of True or False is always selected.

The shiny app may be used here: https://hannah-bobst.shinyapps.io/assignment-b3-hannah-bobst/ 

The following files are included in the repository:

* **README.md**: This Markdown file contains a description of the repository and each file within it.

* **app.R**: This R file contains the R code for the shiny app that explores the *palmerpenguins* data set.

* **app.html**: This html file is the file created by running the shiny app (**app.R**).
