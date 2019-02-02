library(tidyverse)
library(rvest)
source("src/schedule-utils.R")


schedule <- get_schedule_all(date_yymm = 1901)
schedule %>% select(date, stage, team)

when_my_star_performs("서수진", schedule)
when_my_star_performs("김영후", schedule)
when_my_star_performs(c("김영후", "서수진"), schedule)
