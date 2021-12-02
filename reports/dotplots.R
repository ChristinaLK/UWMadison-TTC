library(readr)
library(dplyr)
library(ggplot2)
library(lubridate)
library(stringr)

TTCdatafile <- "data/TTC_All_FacultyStaff.csv"
TTCdata <- read_csv(TTCdatafile)

TTCdata <- TTCdata %>%
  mutate(EmploymentDuration = interval(`Date of Hire`,ymd("2021-11-07")) %/% years(1)) %>%
  filter(`Current Annual Contracted Salary` > 100) 

#position <- "Software Eng"
position <- "Software Engineer/Developer IV"

# binning from https://community.rstudio.com/t/create-bins-the-tidy-way/63492
TTCdata %>%
  select(Title,`Current Annual Contracted Salary`,EmploymentDuration) %>%
  #filter(str_detect(Title,position)) %>%
  filter(Title == position) %>%
  mutate(Position = position) %>%
  mutate(YrsEmployed = cut(EmploymentDuration, 
                                      seq(0, max(EmploymentDuration) + 5, 5),
                                      right = FALSE)) %>%
  ggplot(aes(x = `Current Annual Contracted Salary`)) + 
  geom_dotplot(aes(fill = YrsEmployed), binwidth = 5000,
               alpha = .75, dotsize = .3) + 
  theme_minimal() + 
  theme(axis.text.y=element_blank()) + 
  scale_fill_brewer(palette = "Spectral") #+ 
  #facet_grid(rows = vars(Title))

# https://r-graphics.org/R-Graphics-Cookbook-2e_files/figure-html/FIG-COLORS-PALETTE-BREWER-1.png

position1 <- "Dean"
position2 <- "Software Eng"
TTCdata %>%
  select(Title,`Current Annual Contracted Salary`,EmploymentDuration) %>%
  filter(str_detect(Title,position1) | str_detect(Title,position2)) %>%
  #mutate(Position = position) %>%
  ggplot(aes(x = `Current Annual Contracted Salary`)) + 
  geom_dotplot(aes(fill = Title,, color = Title), alpha = .5) + theme_minimal()

+
  geom_jitter(aes(color = EmploymentDuration), alpha = .7, size = 2, height = .25) + 
  theme_minimal()
geom
