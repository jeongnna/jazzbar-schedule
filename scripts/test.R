library(tidyverse)
library(rvest)
source("src/functions.R")


base_url <- "http://www.allthatjazz.kr/"
schedule <- get_schedule(base_url)
schedule

when_my_star_performs("허소영", schedule)
when_my_star_performs("김영후", schedule)
when_my_star_performs("서수진", schedule)
when_my_star_performs(c("허소영", "김영후", "서수진"), schedule)
