
<!-- README.md is generated from README.Rmd. Please edit that file -->
When my star performs
=====================

웹 스크래핑을 통해 다양한 재즈바의 공연 스케줄을 통합하는 프로그램입니다. 검색을 통해 원하는 뮤지션의 스케줄만 따로 뽑아낼 수도 있습니다. 현재는 데모버전으로 이태원 올댓재즈의 스케줄만 지원합니다.

`get_schedule` 함수로 공연 스케줄을 불러옵니다. `yy`년 `mm`월의 스케줄을 불러오고 싶으면 `date_yymm` 인자에 `yymm`를 입력합니다. `date_yymm` 인자를 생략하면 현재 날짜를 기준으로 자동으로 설정됩니다.

``` r
base_url <- "http://www.allthatjazz.kr/"
schedule <- get_schedule(base_url, date_yymm = 1902)
schedule %>% select(date, stage, team)
```

    ## # A tibble: 49 x 3
    ##     date stage         team                
    ##    <dbl> <chr>         <chr>               
    ##  1     1 All That Jazz Saha Lee Band       
    ##  2     1 All That Jazz 박주원 Electric Band
    ##  3     2 All That Jazz 이용석 Quintet      
    ##  4     2 All That Jazz The Triad           
    ##  5     3 All That Jazz 정광진 Band         
    ##  6     3 All That Jazz 차유빈 Trio         
    ##  7     4 All That Jazz Cray K Quintet      
    ##  8     4 All That Jazz 전영세 Trioˇ        
    ##  9     5 All That Jazz 김이슬 Trio+1       
    ## 10     5 All That Jazz 김지훈 Jazz Band    
    ## # ... with 39 more rows

`when_my_star_performs` 함수로 원하는 뮤지션의 스케줄을 불러옵니다.

``` r
when_my_star_performs("허소영", schedule)
```

    ## Date   : 26
    ## Stage  : All That Jazz
    ## Team   : 허소영 Band
    ## Members: 허소영, 심규민, 신동하, Chirs

``` r
when_my_star_performs("김영후", schedule)
```

    ## Date   : 7
    ## Stage  : All That Jazz
    ## Team   : Vian Trio
    ## Members: Vian, 김영후, Steve

``` r
when_my_star_performs("서수진", schedule)
```

    ## Date   : 27
    ## Stage  : All That Jazz
    ## Team   : 이승원 Quartet
    ## Members: 이승원, 이지영, 신동하, 서수진

여러 명의 뮤지션을 한꺼번에 입력할 수도 있습니다.

``` r
when_my_star_performs(c("허소영", "김영후", "서수진"), schedule)
```

    ## Date   : 7
    ## Stage  : All That Jazz
    ## Team   : Vian Trio
    ## Members: Vian, 김영후, Steve
    ## 
    ## Date   : 26
    ## Stage  : All That Jazz
    ## Team   : 허소영 Band
    ## Members: 허소영, 심규민, 신동하, Chirs
    ## 
    ## Date   : 27
    ## Stage  : All That Jazz
    ## Team   : 이승원 Quartet
    ## Members: 이승원, 이지영, 신동하, 서수진
