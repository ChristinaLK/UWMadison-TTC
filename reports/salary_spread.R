library(readr)
library(dplyr)
library(ggplot2)

ttc_datafile <- "data/TTC_All_FacultyStaff.csv"
ttc_data <- read_csv(ttc_datafile)

salary_file <- "data/salary_ranges.csv"
salary_data <- read_csv(salary_file, col_names = c("Label","Min","Max")) %>%
  mutate(TextLabel = sprintf("%03d", Label))

data_labels <- salary_data %>% select(Label)
data_labels <- data_labels[[1]]

main_colleges <- c(
  "Sch of Med & Public Health",
  "College of Letters & Science",
  "School of Pharmacy"
)

below_35_divisions <- c(
"Sch of Med & Public Health",
"Facilities Planning & Mgmt",
"College of Letters & Science",
"VC for Rsrch & Grad Education",
"College of Ag & Life Science",
"Information Technology")

c(
"UW - Madison Extension",
"General Services",
"University Housing",
"Intercollegiate Athletics"
)

query_division <- "College of Letters & Science"

ttc_data %>%
  filter(as.numeric(`Salary Grade`) %in% data_labels) %>%
  filter(`Current Annual Contracted Salary` > 400) %>%
#  filter(Division == query_division) %>%
#  filter(Division %in% below_35_divisions) %>%
  ggplot(aes(x = `Salary Grade`, y = `Current Annual Contracted Salary`)) + 
#  geom_jitter(alpha = .2) + 
  geom_boxplot() + theme_minimal() + 
  geom_point(data = salary_data, mapping = aes(x = TextLabel, y = Min), color = "red") + 
  geom_point(data = salary_data, mapping = aes(x = TextLabel, y = Max), color = "red")

ttc_data %>%
  filter(as.numeric(`Salary Grade`) %in% data_labels) %>%
  filter(`Current Annual Contracted Salary` > 400) %>% 
  group_by(`Salary Grade`) %>%
  tally() %>% arrange(n)
