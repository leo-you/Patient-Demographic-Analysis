# Patient Demographic Analysis

## About this Project

The purpose of this analysis is to find out the key factors that determines whether a prospect patient will end up booking/keeping the appointments. The end goal of the analysis is to train a classification model to correctly predict whether a patient will book an appointment based on certain information.

## Data Source

The dataset used in this analysis is from SQL database, tables used are:

- person table
- appointment table
- location
- ZipCode Census (use to get closest distance for a given zip code)
- person source
- person primary payer (get patient insurance)


The data points includes some patient demographic information such as:

- Gender
- Age
- Language

It also includes other key factors might play important role, such as:

- Patient marketing source
- Distance to closest clinic
- Patient insurance

Packages used in ths tracker includes:

- readr
- ggplot2
- dplyr
- reshape2
- MASS
- DT
- gridExtra
- stargazer
- stringr
- yardstick


## Methodology

Various techniques are used in the analysis, steps as follow:

- Exploratory Data Analysis
- Data Visualization
- Logistic Regression Model Training
- Testing and Validation
- Prediction

## Disclaimer

This is a work related project and for education and demostration purpose only. The data and analysis only represent the creater's own
opinion and not affiliate with any other institution or parties. The dataset provided in this project can not be shared and used for other purposes.The source code can be found on Github [Patient Demographic Analysis](https://github.com/leo-you/Patient-Demographic-Analysis).
