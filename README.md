
<!-- README.md is generated from README.Rmd. Please edit that file -->
When my star performs
=====================

웹 스크래핑을 통해 다양한 재즈바의 공연 스케줄을 통합하는 프로그램입니다. 검색을 통해 원하는 뮤지션의 스케줄만 따로 뽑아낼 수도 있습니다. 현재는 올댓재즈와 에반스의 스케줄을 지원합니다.

``` r
library(tidyverse)
library(rvest)
source("src/schedule-utils.R")
```

`get_schedule_all` 함수로 공연 스케줄을 불러옵니다. `yy`년 `mm`월의 스케줄을 불러오고 싶으면 `date_yymm` 인자에 `yymm`를 입력합니다. `date_yymm` 인자를 생략하면 현재 날짜를 기준으로 자동으로 설정됩니다.

``` r
schedule <- get_schedule_all(date_yymm = 1901)
schedule %>% select(date, stage, team)
```

    ## # A tibble: 92 x 3
    ##     date stage    team                        
    ##    <dbl> <chr>    <chr>                       
    ##  1     1 올댓재즈 김준범 Trio+1               
    ##  2     1 올댓재즈 조광현 Quartet+1            
    ##  3     2 올댓재즈 차유빈 Trio                 
    ##  4     2 올댓재즈 이지영 New Trio+1           
    ##  5     2 에반스   이한얼 오르간 트리오  + 나겸
    ##  6     3 올댓재즈 TBA                         
    ##  7     3 올댓재즈 Vian Quintet                
    ##  8     3 에반스   이수정Quartet               
    ##  9     4 올댓재즈 Pete Jung Ko ..             
    ## 10     4 올댓재즈 박주원 Electric Band        
    ## # ... with 82 more rows

`when_my_star_performs` 함수로 원하는 뮤지션의 스케줄을 불러옵니다.

``` r
when_my_star_performs("서수진", schedule)
```

    ## Date   : 23
    ## Stage  : 올댓재즈
    ## Team   : 이승원 Quartet
    ## Members: 이승원, 이지영, 신동하, 서수진

``` r
when_my_star_performs("김영후", schedule)
```

    ## Date   : 3
    ## Stage  : 올댓재즈
    ## Team   : Vian Quintet
    ## Members: Vian, 김지석, 박윤우, 김영후, Steve
    ## 
    ## Date   : 9
    ## Stage  : 에반스
    ## Team   : 윤지희 Trio + 1
    ## Members: 윤지희, 김영후, 박종선, 조신일

여러 명의 뮤지션을 한꺼번에 입력할 수도 있습니다.

``` r
when_my_star_performs(c("서수진", "김영후", "찰리정"), schedule)
```

    ## Date   : 3
    ## Stage  : 올댓재즈
    ## Team   : Vian Quintet
    ## Members: Vian, 김지석, 박윤우, 김영후, Steve
    ## 
    ## Date   : 9
    ## Stage  : 에반스
    ## Team   : 윤지희 Trio + 1
    ## Members: 윤지희, 김영후, 박종선, 조신일
    ## 
    ## Date   : 16
    ## Stage  : 올댓재즈
    ## Team   : Xtrike
    ## Members: 조용원, 김승범, 찰리정, Steve
    ## 
    ## Date   : 23
    ## Stage  : 올댓재즈
    ## Team   : 이승원 Quartet
    ## Members: 이승원, 이지영, 신동하, 서수진
