####
# 
# sample dataset:
# compute downloads for eat Packages by month
#
###


# install.packages('cranlogs')
library(cranlogs)
library(lubridate)
library(dplyr)

# test for one package
cran_downloads(when = "last-week", packages = c("eatATA"))
dl <- cran_downloads(when = "last-month", packages = c("eatATA")) 
dl %>% 
  mutate(Month=month(date)) %>% 
  group_by(Month) %>% 
  summarise(downloads=sum(count,na.rm=T)) %>% t()

# loop across all eat Packages
eat_packages <- c('eatATA', 'eatDB', 'eatGADS', 'eatRep', 'eatTools')
eat_downloads <- NULL
for (p in eat_packages){
  dl <- cran_downloads(from = "2023-01-01", to = "last-day", packages = p) 
  dl %>% 
    mutate(Month=month(date)) %>% 
    group_by(Month) %>% 
    summarise(downloads=sum(count,na.rm=T)) %>% 
    # pull(downloads) %>%
    rename(!!p := downloads) %>%  
    select(!!p) %>% 
    t() %>% 
    as.data.frame() %>% 
    setNames(paste0(1:10, "/2023")) %>% 
    mutate(`Gesamt 2023` = rowSums(across(where(is.numeric)))) %>% 
    rbind.data.frame(eat_downloads) -> eat_downloads
}
eat_downloads

