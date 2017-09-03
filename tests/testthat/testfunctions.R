
# earthquakeGeoms Tests

library(testthat)

## Testing eq_location_clean

test_that("checking eq_location_clean", {

  ## Data Setup

  test_dataframe = data.frame(order = 1:10,
                              LOCATION_NAME = c("Peru: Lima", "Mexico: Tijuana",
                                                "CUBA: HABANA", "SRI LANKA: IslanD",
                                                "EU: SPain: unknown", "US: Maine",
                                                "US: California: Los Angeles", " Ecuador: Bogota",
                                                "Ivory COAST: ISLAND 3", "China: HONG KONG"),
                              stringsAsFactors = F)

  clean_test_dataframe = test_dataframe = data.frame(order = 1:10,
                                                     LOCATION_NAME = c("Lima", "Tijuana",
                                                                       "Habana", "Island",
                                                                       "Unknown", "Maine",
                                                                       "Los Angeles", "Bogota",
                                                                       "Island 3", "Hong Kong"),
                                                     stringsAsFactors = F)

  ## Function Call

  test_dataframe = eq_location_clean(test_dataframe)


  ## Testing

  expect_equal(test_dataframe, clean_test_dataframe)
})

## Testing eq_clean_data

test_that("checking eq_clean_data", {

  ## Data Setup

  test_dataframe = data.frame(LOCATION_NAME = c("Peru: Lima", "Mexico: Tijuana",
                                                "CUBA: HABANA", "SRI LANKA: IslanD",
                                                "EU: SPain: unknown", "US: Maine",
                                                "US: California: Los Angeles"),
                              YEAR = c(2150,-2000,2000,1999,-1610,1566,1450),
                              MONTH = c(NA,3,NA,1,9,6,5),
                              DAY = c(NA,NA,1,4,NA,2,NA),
                              LATITUDE = c(31.1,38,35.683,34.1,36.4,31.5,35.5),
                              LONGITUDE = c(35.5,58.2,35.8,43.2,25.4,35.3,25.5),
                              DEATHS = c(NA,1,2,8,33,NA,NA),
                              TOTAL_DEATHS = c(NA,1,NA,9,NA,25,NA),
                              stringsAsFactors = F)

  clean_test_dataframe = data.frame(LOCATION_NAME = c("Lima","Habana","Island","Maine","Los Angeles"),
                                    YEAR = c(2150,2000,1999,1566,1450),
                                    MONTH = c(1,1,1,6,5),
                                    DAY = c(1,1,4,2,1),
                                    LATITUDE = c(31.1,35.683,34.1,31.5,35.5),
                                    LONGITUDE = c(35.5,35.8,43.2,35.3,25.5),
                                    DEATHS = c(NA,2,8,NA,NA),
                                    TOTAL_DEATHS = c(NA,NA,9,25,NA),
                                    DATE = as.Date(c("2150-01-01","2000-01-01","1999-01-04","1566-06-02","1450-05-01")),
                                    stringsAsFactors = F)

  ## Function Call

  test_dataframe = eq_clean_data(test_dataframe) # Calling the function


  ## Testing

  expect_equal(test_dataframe, clean_test_dataframe)
})

## Testing geom_timeline

test_that("checking geom_timeline", {

  ## Data Setup

  test_dataframe = data.frame(LOCATION_NAME = c("Peru: Lima", "Mexico: Tijuana",
                                                "CUBA: HABANA", "SRI LANKA: IslanD",
                                                "EU: SPain: unknown", "US: Maine",
                                                "US: California: Los Angeles"),
                              YEAR = c(2150,-2000,2000,1999,-1610,1566,1450),
                              MONTH = c(NA,3,NA,1,9,6,5),
                              DAY = c(NA,NA,1,4,NA,2,NA),
                              LATITUDE = c(31.1,38,35.683,34.1,36.4,31.5,35.5),
                              LONGITUDE = c(35.5,58.2,35.8,43.2,25.4,35.3,25.5),
                              DEATHS = c(NA,1,2,8,33,NA,NA),
                              TOTAL_DEATHS = c(NA,1,NA,9,NA,25,NA),
                              EQ_PRIMARY = c(3.6, 4.4,6.5, 2.7, 5.5, 6.3, 7.4),
                              stringsAsFactors = F)
  test_dataframe = eq_clean_data(test_dataframe)

  ## Function Call

  p = ggplot2::ggplot(test_dataframe, ggplot2::aes(DATE,
                                            colour = TOTAL_DEATHS,
                                            size = as.numeric(EQ_PRIMARY) )) +
    geom_timeline()


  ## Testing

  expect_identical(p$layers[[1]]$geom$default_aes$shape, 21)
  expect_identical(p$layers[[1]]$geom$default_aes$fill, "grey10")
  expect_identical(p$layers[[1]]$geom$default_aes$alpha, 0.5)
  expect_identical(p$layers[[1]]$geom$default_aes$colour, "black")
  expect_identical(p$layers[[1]]$geom$default_aes$stroke, 0)
  expect_identical(p$layers[[1]]$geom$default_aes$size, 6)


})

## Testing geom_timeline_label

test_that("checking geom_timeline_label", {

  ## Data Setup

  test_dataframe = data.frame(LOCATION_NAME = c("Peru: Lima", "Mexico: Tijuana",
                                                "CUBA: HABANA", "SRI LANKA: IslanD",
                                                "EU: SPain: unknown", "US: Maine",
                                                "US: California: Los Angeles"),
                              YEAR = c(2150,-2000,2000,1999,-1610,1566,1450),
                              MONTH = c(NA,3,NA,1,9,6,5),
                              DAY = c(NA,NA,1,4,NA,2,NA),
                              LATITUDE = c(31.1,38,35.683,34.1,36.4,31.5,35.5),
                              LONGITUDE = c(35.5,58.2,35.8,43.2,25.4,35.3,25.5),
                              DEATHS = c(NA,1,2,8,33,NA,NA),
                              TOTAL_DEATHS = c(NA,1,NA,9,NA,25,NA),
                              EQ_PRIMARY = c("3.6", "4.4","6.5", "2.7", "5.5", "6.3", "7.4"),
                              stringsAsFactors = F)
  test_dataframe = eq_clean_data(test_dataframe)

  ## Function Call

  p = ggplot2::ggplot(test_dataframe, ggplot2::aes(DATE,
                                                   colour = TOTAL_DEATHS,
                                                   size = as.numeric(EQ_PRIMARY) )) +
    geom_timeline() +
    geom_timeline_label(ggplot2::aes(label = test_dataframe$LOCATION_NAME))


  ## Testing

  expect_identical(p$layers[[1]]$geom$default_aes$shape, 21)
  expect_identical(p$layers[[1]]$geom$default_aes$fill, "grey10")
  expect_identical(p$layers[[1]]$geom$default_aes$alpha, 0.5)
  expect_identical(p$layers[[1]]$geom$default_aes$colour, "black")
  expect_identical(p$layers[[1]]$geom$default_aes$stroke, 0)
  expect_identical(p$layers[[1]]$geom$default_aes$size, 6)


})

## Testing eq_map

test_that("checking eq_map", {

  ## Data Setup

  test_dataframe = data.frame(LOCATION_NAME = c("Peru: Lima", "Mexico: Tijuana",
                                                "CUBA: HABANA", "SRI LANKA: IslanD",
                                                "EU: SPain: unknown", "US: Maine",
                                                "US: California: Los Angeles"),
                              YEAR = c(2150,-2000,2000,1999,-1610,1566,1450),
                              MONTH = c(NA,3,NA,1,9,6,5),
                              DAY = c(NA,NA,1,4,NA,2,NA),
                              LATITUDE = c(31.1,38,35.683,34.1,36.4,31.5,35.5),
                              LONGITUDE = c(35.5,58.2,35.8,43.2,25.4,35.3,25.5),
                              DEATHS = c(NA,1,2,8,33,NA,NA),
                              TOTAL_DEATHS = c(NA,1,NA,9,NA,25,NA),
                              EQ_PRIMARY = c("3.6", "4.4","6.5", "2.7", "5.5", "6.3", "7.4"),
                              stringsAsFactors = F)
  test_dataframe = eq_clean_data(test_dataframe)

  ## Function Call

  m = eq_clean_data(test_dataframe)
  m = eq_map(m, annot_col = "DATE")


  ## Testing

  expect_identical(m$sizingPolicy$defaultWidth, "100%")
  expect_identical(m$sizingPolicy$defaultHeight, 400)
  expect_identical(m$sizingPolicy$padding, 0)

  expect_identical(m$x$calls[[2]]$args[[1]], test_dataframe$LATITUDE)
  expect_identical(m$x$calls[[2]]$args[[2]], test_dataframe$LONGITUDE)
  expect_identical(m$x$calls[[2]]$args[[9]], test_dataframe$DATE)
  expect_identical(m$x$calls[[2]]$method, "addCircleMarkers")

})

## Testing eq_create_label

test_that("checking eq_create_label", {

  ## Data Setup

  test_dataframe = data.frame(LOCATION_NAME = c("Peru: Lima", "Mexico: Tijuana",
                                                "CUBA: HABANA", "SRI LANKA: IslanD",
                                                "EU: SPain: unknown", "US: Maine",
                                                "US: California: Los Angeles"),
                              YEAR = c(2150,-2000,2000,1999,-1610,1566,1450),
                              MONTH = c(NA,3,NA,1,9,6,5),
                              DAY = c(NA,NA,1,4,NA,2,NA),
                              LATITUDE = c(31.1,38,35.683,34.1,36.4,31.5,35.5),
                              LONGITUDE = c(35.5,58.2,35.8,43.2,25.4,35.3,25.5),
                              DEATHS = c(NA,1,2,8,33,NA,NA),
                              TOTAL_DEATHS = c(NA,1,NA,9,NA,25,NA),
                              EQ_PRIMARY = c("3.6", "4.4","6.5", "2.7", "5.5", "6.3", "7.4"),
                              stringsAsFactors = F)
  test_dataframe = eq_clean_data(test_dataframe)

  annotations = c(" <b>Location:</b> Lima <br/> <b>Magnitude:</b> 3.6 <br/>",
                  " <b>Location:</b> Habana <br/> <b>Magnitude:</b> 6.5 <br/>",
                  " <b>Location:</b> Island <br/> <b>Magnitude:</b> 2.7 <br/> <b>Total deaths:</b> 9",
                  " <b>Location:</b> Maine <br/> <b>Magnitude:</b> 6.3 <br/> <b>Total deaths:</b> 25",
                  " <b>Location:</b> Los Angeles <br/> <b>Magnitude:</b> 7.4 <br/>")

  ## Function Call

  m = eq_clean_data(test_dataframe)
  m$popup_text = eq_create_label(m) # Creating the Labels
  m = eq_map(m, annot_col = "popup_text")


  ## Testing

  expect_identical(m$sizingPolicy$defaultWidth, "100%")
  expect_identical(m$sizingPolicy$defaultHeight, 400)
  expect_identical(m$sizingPolicy$padding, 0)

  expect_identical(m$x$calls[[2]]$args[[1]], test_dataframe$LATITUDE)
  expect_identical(m$x$calls[[2]]$args[[2]], test_dataframe$LONGITUDE)
  expect_identical(m$x$calls[[2]]$args[[9]], annotations)
  expect_identical(m$x$calls[[2]]$method, "addCircleMarkers")

})
