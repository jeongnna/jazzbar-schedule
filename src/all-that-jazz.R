configure <- function(date_yymm) {
  base_url <- "http://www.allthatjazz.kr/"
  sub_url <- str_c("xa02x", date_yymm, ".htm")
  tag <- "td"
  list("base_url" = base_url, "sub_url" = sub_url, "tag" = tag)
}


get_date <- function(html) {
  keys <- c("b", "s", "u")
  for (key in keys) {
    text <- 
      html %>% 
      html_nodes(key) %>% 
      .[1] %>% 
      html_text(trim = TRUE) %>% 
      as.numeric()
    if (length(text) > 0) {
      return (text)
    }
  }
  NA
}


get_team <- function(html) {
  team_name <- 
    html %>% 
    html_nodes("a") %>% 
    html_text(trim = TRUE) %>% 
    str_replace("^[:digit:]' ", "")
}


get_url <- function(html) {
  team_url <- 
    html %>% 
    html_nodes("a") %>% 
    html_attr("href") %>% 
    str_extract("\\(\'.*\'\\)") %>% 
    str_sub(3, -3) %>% 
    str_replace(".htm", "a.htm")
}


get_members <- function(url) {
  website <- read_html(url)
  members_html <- website %>% html_nodes("u")
  
  members <- NULL
  for (node in members_html) {
    text <- node %>% html_text(trim = TRUE)
    # >> "허소영 …… Vocal／Piano\r\n준스미스／찰리정 …… Guitar"
    if (!str_detect(text, "……")) next
    text <- 
      text %>% 
      str_split("\r\n") %>% 
      unlist() %>%
      # >> "허소영 …… Vocal／Piano" "준스미스／찰리정 …… Guitar"
      str_replace("[:blank:].*", "") %>%
      # >> "허소영" "준스미스／찰리정"
      str_split("／") %>% 
      unlist()
    # >> "허소영" "준스미스" "찰리정"
    members <- c(members, text)
  }
  
  members
}
