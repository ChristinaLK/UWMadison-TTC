library(readr)
library(dplyr)
library(ggplot2)

datafile <- "data/TTC_All_FacultyStaff.csv"
data <- read_csv(datafile)

data %>%
  group_by(Title) %>%
  tally() %>%
  filter(n < 50) %>%
  ggplot(aes(x = n)) +
  geom_histogram() + theme_minimal()

data %>%
  group_by(Title) %>%
  tally() %>%
  filter(n >= 50) %>%
  ggplot(aes(x = n)) +
  geom_histogram()

preTTCdatafile <- "data/PreTTC_All_FacultyStaff.csv"
data2 <- read_csv(preTTCdatafile)

data2 %>%
  group_by(Title) %>%
  tally() %>%
  filter(n < 50) %>%
  ggplot(aes(x = n)) +
  geom_histogram() + theme_minimal()
