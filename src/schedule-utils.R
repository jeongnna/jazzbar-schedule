library(tidyverse)
library(rvest)


get_schedule <- function(stage, date_yymm = NULL) {
  if (is.null(date_yymm)) {
    date_yymm <- format(Sys.Date(), "%y%m")
  }
  if (stage %in% c("allthatjazz", "올댓재즈")) {
    source("src/all-that-jazz.R")
  } else if (stage %in% c("evans", "에반스")) {
    source("src/evans.R")
  }
  
  config <- configure(date_yymm)
  url <- str_c(config$base_url, config$sub_url)  # url 설정
  website <- read_html(url)  # 웹사이트 불러오기
  schedule_html <- website %>% html_nodes(config$tag)  # 스케줄 노드
  
  schedule <- list()
  for (node in schedule_html) {
    date <- get_date(node)  # 날짜
    if (is.na(date)) next
    team <- get_team(node)  # 팀명
    if (all(is.na(team))) next
    team_url <- get_url(node)  # 팀 설명 url
    if (all(is.na(team_url))) {
      next
    } else {
      team_url <- str_c(config$base_url, team_url)
    }
    members <- lapply(team_url, get_members)  # 팀 멤버
    if (all(is.na(members))) next
    
    num_teams <- length(team)
    newline <- list("date" = rep(date, num_teams),
                    "stage" = rep(stage, num_teams), 
                    "team" = team, 
                    "members" = members, 
                    "url" = team_url)
    schedule <- schedule %>% bind_rows(newline)
  }
  
  schedule
}


get_schedule_all <- function(date_yymm = NULL) {
  stagelist <- c("올댓재즈", "에반스")
  schedules <- list()
  for (stage in stagelist) {
    schedules <- schedules %>% append(list(get_schedule(stage, date_yymm)))
  }
  schedules %>% 
    bind_rows %>% 
    arrange(date)
}


when_my_star_performs <- function(name, schedule) {
  idx <- sapply(schedule$members, function(x) {any(name %in% x)})
  if (!any(idx)) {  # All FALSE
    "없졍"
  } else {
    schedule <- schedule %>% filter(idx)
    
    print_performance <- function(performance) {
      members <- 
        performance$members %>% 
        unlist() %>% 
        unname() %>% 
        str_c(collapse = ", ")
      
      str_c("Date   : ", performance$date, "\n",
            "Stage  : ", performance$stage, "\n",
            "Team   : ", performance$team, "\n",
            "Members: ", members, "\n")
    }
    
    info <- ""
    for (i in 1:nrow(schedule)) {
      newline <- print_performance(schedule[i, ])
      info <- str_c(info, newline, sep = "\n")
    }
    info
  }
}
