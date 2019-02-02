library(tidyverse)
library(rvest)


get_date <- function(html) {
  html %>% 
    html_text(trim = TRUE) %>%
    str_extract("^[:digit:]{1,2}")
}
get_team <- function(html) {
  html %>% 
    html_text(trim = TRUE) %>%
    str_replace("^[:digit:]{1,2}", "")
}
get_url <- function(html) {
  html %>%
    html_nodes("a") %>%
    html_attr("href") %>%
    str_sub(4, -1)
}
get_members <- function(url) {
  website <- read_html(url)
  members_html <- website %>% html_nodes("img+ a")
  members <- members_html %>% (function(x) {x %>% html_text(trim = TRUE)})
  members
}
get_schedule <- function(base_url, date_yymm = NULL) {
  if (is.null(date_yymm)) {
    date_yymm <- format(Sys.Date(), "%y%m")
  }
  sub_url <- str_c("bbs/board.php?schedule_ym=20", 
                   as.character(date_yymm), 
                   "&bo_table=TODAYS_LIVE")
  
  url <- str_c(base_url, sub_url)  # url 설정
  website <- read_html(url)  # 웹사이트 불러오기
  
  schedule_html <- website %>% html_nodes(".default")  # 스케줄 노드
  
  date <- get_date(schedule_html)
  cpt <- !is.na(date)
  date <- date[cpt]
  team <- get_team(schedule_html)[cpt]
  team_url <- str_c(base_url, get_url(schedule_html))
  members <- lapply(team_url, get_members)
  stage <- rep("클럽에반스", length(date))
  
  tibble("date" = date,
         "stage" = stage,
         "team" = team,
         "members" = members,
         "url" = team_url)
}


base_url <- "http://www.clubevans.com/"
date_yymm <- 1901
schedule <- get_schedule(base_url, 1901)








base_url <- "http://www.clubevans.com/"
sub_url <- "bbs/board.php?schedule_ym=201901&bo_table=TODAYS_LIVE"

url <- str_c(base_url, sub_url)  # url 설정
website <- read_html(url)  # 웹사이트 불러오기
schedule_html <- website %>% html_nodes(".default")  # 스케줄 노드

date <- get_date(schedule_html)
date[!is.na(date)]
get_team(schedule_html)[!is.na(date)]
team_url <- str_c(base_url, get_url(schedule_html))
team_url
get_members(team_url[3])
lapply(team_url[1:3], get_members)


website <- read_html(str_c(base_url, team_url[1]))
members_html <- website %>% html_nodes("img+ a")
members <- members_html %>% (function(x) {x %>% html_text(trim = TRUE)})
list(members)






url <- "http://www.clubevans.com/bbs/board.php?bo_table=TODAYS_LIVE&wr_id=3445"
website <- read_html(url)
website

html <- website %>% html_nodes("body") %>% html_nodes("img+ a")
html <- website %>% html_nodes("img+ a")
html
for (node in html) {
  print(node %>% html_text(trim = TRUE))
}
sapply(html, function(x) {x %>% html_text(trim = TRUE)})
