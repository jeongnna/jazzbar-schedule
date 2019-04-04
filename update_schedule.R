source("src/schedule_manager.R")


schedule <- get_schedule_all()
schedule %>% save_schedule()
