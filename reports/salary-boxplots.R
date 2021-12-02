library(readr)
library(dplyr)
library(ggplot2)
library(stringr)

datafile <- "data/TTC_All_FacultyStaff.csv"
data <- read_csv(datafile)

data %>% 
  select(Title,`Current Annual Contracted Salary`) %>%
  filter(`Current Annual Contracted Salary` > 0) %>%
  arrange(`Current Annual Contracted Salary`) %>%
  tail(50) %>% 
  ggplot(aes(x = Title, y = `Current Annual Contracted Salary`)) + 
  geom_boxplot()

position = "Professor"
count_cutoff = 10

sig_roles <- data %>%
  filter(`Current Annual Contracted Salary` > 1000) %>%
  filter(str_detect(Title,position)) %>%
  group_by(Title) %>%
  tally() %>% 
  filter(n > count_cutoff) %>%
  select(Title) %>% c()

data %>%
  filter(`Current Annual Contracted Salary` > 1000) %>%
  #filter(str_detect(Title,position)) %>%
  filter(Title %in% sig_roles[[1]]) %>%
  select(Title, `Current Annual Contracted Salary`) %>%
  ggplot(aes(x = Title, y = `Current Annual Contracted Salary`)) + 
  geom_boxplot() + 
  theme_minimal() + 
  theme(axis.text.x = element_text(angle = 90, vjust = 0.5, hjust=1))

# always this stackoverflow for rotating tick mark labels
# https://stackoverflow.com/questions/1330989/rotating-and-spacing-axis-labels-in-ggplot2

researcher_list <- c("Researcher I","Researcher II","Researcher III")
top_divisions <- data %>%
  filter(`Current Annual Contracted Salary` > 1000) %>%
  filter(Title %in% researcher_list) %>%
  group_by(Division) %>% tally() %>% 
  filter(n >= 5) %>% select(Division)
  
  
data %>%
  filter(`Current Annual Contracted Salary` > 1000) %>%
  filter(Title %in% researcher_list) %>%
  filter(Division %in% top_divisions[[1]]) %>%
  select(Title, `Current Annual Contracted Salary`,Division) %>%
  ggplot(aes(x = Division, y = `Current Annual Contracted Salary`)) + 
  geom_boxplot() + 
  geom_jitter(alpha = .5, color = "red") + 
  facet_grid(rows = vars(Title)) + 
  theme_minimal() + 
  theme(axis.text.x = element_text(angle = 90, vjust = 0.5, hjust=1))

