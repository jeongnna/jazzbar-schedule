print_info <- function(performance) {
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

search_musician <- function(name, schedule) {
  idx <- sapply(schedule$members, function(x) {any(name %in% x)})
  if (!any(idx)) {  # All FALSE
    "없졍"
  } else {
    schedule <- schedule %>% filter(idx)
    
    info <- ""
    for (i in 1:nrow(schedule)) {
      newline <- print_info(schedule[i, ])
      info <- str_c(info, newline, sep = "\n")
    }
    info
  }
}
