# earthquakeGeoms

## By Rony Sulca - (ronybsulca@berkeley.edu)
Built for Coursera Course: Mastering Software Development in R Capstone


The package `earthquakeGeoms` has been built to clean and display the [earthquake data](https://www.ngdc.noaa.gov/nndc/struts/form?t=101650&s=1&d=1) from NOAA (The National Centers for Environmental
Information).


The Package consists of the functions:

- [eq_location_clean]() -- Cleans the locations of the earthquake dataset.
- [eq_clean_data]() -- Cleans the entire dataset to make it compatible with the other functions.
- [geom_timeline]() -- Displays the earthquakes as points in a plot.
- [geom_timeline_label]() -- Labels the earthquakes in the plot created by the previous function.
- [eq_map -- Displays]() the earthquakes by their location in a leaflet map.
- [eq_create_label]() -- Creates a column of html annotations for the earthquakes displayed by the previous function.



Additional Index:

- [Vignette describing how to use the package](vignettes/earthquakeGeoms_details.Rmd)
- [NAMESPACE dependencies](NAMESPACE)
- [NOAA dataset](https://www.ngdc.noaa.gov/nndc/struts/form?t=101650&s=1&d=1)
