#' eq_clean_data
#'
#' This function returns the raw NOAA data frame with a new \code{DATE} column (of class date) added
#' by combining the MONTH, YEAR, and DAY fields (MONTHS and DAYS with NA are replaced to 01).
#' Furthermore, the rows with NA YEAR, or YEAR < 0 are removed. The LATITUDE and LONGITUDE fields
#' are converted to numeric type, and the LOCATION_NAME fixing (from the eq_location_clean function)
#' is implemented.
#'
#' @param dset Dataset depicting the raw NOAA data frame.
#'
#' @importFrom dplyr filter
#' @importFrom dplyr %>%
#'
#' @return This function returns a dataframe with the cleaned NOAA data frame.
#'
#' @examples
#'
#' \dontrun{
#'
#' dataset = read_delim("data/signif.txt", delim = "\t")
#' dataset = eq_clean_data(dataset)
#'
#' }
#'
#' @export
#'

eq_clean_data <- function(dset){

  ## Adding PlaceHolder Days and Months to Missing Fields
  dset[is.na(dset$MONTH), "MONTH"] = 1
  dset[is.na(dset$DAY), "DAY"] = 1

  ## Removing Years that are negative
  dset = dset %>%
    dplyr::filter_('YEAR > 0')

  ## Creating Date Columns from individual YEAR, MONTH, DAY columns
  dset$DATE = as.Date(paste(dset$YEAR, dset$MONTH, dset$DAY, sep = "-"), format = "%Y-%m-%d")

  ## Changing the LONGITUDE and LATITUDE types to numeric
  dset$LATITUDE = as.numeric(dset$LATITUDE)
  dset$LONGITUDE = as.numeric(dset$LONGITUDE)

  # Changing Deaths to numeric (For ease of display)
  dset$DEATHS = as.numeric(dset$DEATHS)
  dset$TOTAL_DEATHS = as.numeric(dset$TOTAL_DEATHS)

  ## Fixing Location Names
  dset = eq_location_clean(dset)

  return(dset)
}

