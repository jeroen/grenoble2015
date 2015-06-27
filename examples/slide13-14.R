### Slide 13: Building pipes
library(curl)
library(jsonlite)
library(dplyr)
library(magrittr)
curl("https://api.github.com/repos/hadley/ggplot2/issues") %>%
  fromJSON(flatten = TRUE) %>%
  mutate(date = as.Date(created_at)) %>%
  filter(user.login == "hadley") %>%
  select(title, state, date)

### Slide 14: aggregation
library(curl)
library(jsonlite)
library(dplyr)
library(magrittr)
curl("https://api.github.com/repos/rstudio/shiny/commits") %>%
  fromJSON(flatten = TRUE) %>%
  group_by(author.login) %>%
  summarise(count = n())
