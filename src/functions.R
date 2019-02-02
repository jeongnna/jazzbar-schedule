get_date <- function(html) {
  date <- NULL
  nodes <- c("b", "s", "u")
  for (node in nodes) {
    date <- 
      html %>% 
      html_nodes(node) %>% 
      .[1] %>% 
      html_text(trim = TRUE) %>% 
      as.numeric()
    if (length(date) > 0) {
      return (date)
    }
  }
  NA
}

get_members <- function(url) {
  website <- read_html(url)
  members_html <- website %>% html_nodes("u")
  
  members <- NULL
  for (node in members_html) {
    temp <- node %>% html_text(trim = TRUE)
    # >> "허소영 …… Vocal／Piano\r\n준스미스／찰리정 …… Guitar"
    if (!str_detect(temp, "……")) next
    temp <- 
      temp %>% 
      str_split("\r\n") %>% 
      unlist() %>%
      # >> "허소영 …… Vocal／Piano" "준스미스／찰리정 …… Guitar"
      str_replace("[:blank:].*", "") %>%
      # >> "허소영" "준스미스／찰리정"
      str_split("／") %>% 
      unlist()
    # >> "허소영" "준스미스" "찰리정"
    members <- c(members, temp)
  }
  
  list(members)
}

get_team_info <- function(html) {
  team_name <- 
    html %>% 
    html_text(trim = TRUE) %>% 
    str_replace("^[:digit:]' ", "")
  
  team_url <- 
    html %>% 
    html_attr("href") %>% 
    str_extract("\\(\'.*\'\\)") %>% 
    str_sub(3, -3) %>% 
    str_replace(".htm", "a.htm")
  
  list("team" = team_name, "url" = team_url)
}

get_schedule <- function(base_url, date_yymm = NULL) {
  if (is.null(date_yymm)) {
    date_yymm <- format(Sys.Date(), "%y%m")
  }
  sub_url <- str_c("xa02x", date_yymm, ".htm")
  
  url <- str_c(base_url, sub_url)
  website <- read_html(url)
  schedule_html <- website %>% html_nodes("td")
  
  schedule <- list()
  for (i in seq_along(schedule_html)) {
    date <- get_date(schedule_html[i])
    if (is.na(date)) next
    
    teams_html <- schedule_html[i] %>% html_nodes("a")
    
    schedule_i <- 
      teams_html %>% 
      lapply(get_team_info) %>% 
      bind_rows() %>%
      bind_cols("date" = rep(date, length(teams_html)))
    
    schedule <- schedule %>% bind_rows(schedule_i)
  }
  
  schedule <- 
    schedule %>% 
    filter(team != "TBA") %>% 
    mutate(url = str_c(base_url, url))
  
  schedule$members <- sapply(schedule$url, get_members)
  schedule$stage <- "All That Jazz"
  
  schedule %>% select(date, stage, team, members, url)
}

when_my_star_performs <- function(name, schedule) {
  idx <- sapply(schedule$members, function(x) {any(name %in% x)})
  schedule <- schedule %>% filter(idx)
  
  print_performance <- function(performance) {
    members <- 
      performance$members %>% 
      unlist() %>% 
      unname() %>% 
      str_c(collapse = ", ")
    
    cat("Date   : ", performance$date, "\n",
        "Stage  : ", performance$stage, "\n",
        "Team   : ", performance$team, "\n",
        "Members: ", members, "\n",
        "\n",
        sep = "")
  }
  
  for (i in 1:nrow(schedule)) {
    print_performance(schedule[i, ])
  }
}
