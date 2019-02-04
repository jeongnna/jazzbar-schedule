configure <- function(date_yymm) {
  base_url <- "http://www.clubevans.com/"
  sub_url <- str_c("bbs/board.php?schedule_ym=20", date_yymm, "&bo_table=TODAYS_LIVE")
  tag <- ".default"
  list("base_url" = base_url, "sub_url" = sub_url, "tag" = tag)
}


get_date <- function(html) {
  text <- html %>% html_text(trim = TRUE)
  if (str_length(text) > 0) {
    text %>% 
      str_extract("^[:digit:]{1,2}") %>% 
      as.numeric()
  } else {
    NA
  }
}


get_team <- function(html) {
  text <- html %>% html_text(trim = TRUE)
  if (str_length(text) > 0) {
    text %>% str_replace("^[:digit:]{1,2}", "")
  } else {
    NA
  }
}


get_url <- function(html) {
  url <- 
    html %>%
    html_nodes("a") %>%
    html_attr("href") %>%
    str_sub(4, -1)
  
  if (length(url) > 0) {
    url
  } else {
    NA
  }
}


get_members <- function(url) {
  website <- read_html(url)
  members_html <- website %>% html_nodes("img + a")
  if (length(members_html) > 0) {
    members_html %>% html_text(trim = TRUE)
  } else {
    NA
  }
}
