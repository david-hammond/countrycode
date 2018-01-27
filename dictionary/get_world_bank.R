get_world_bank = function() {
    url <- 'http://databank.worldbank.org/data/download/site-content/CLASS.xls'

    filename <- tempfile(fileext = '.xls')
    download.file(url, filename, quiet = TRUE)

    wb <- readxl::read_excel(filename) %>%
          dplyr::select(3:4, 6:7) %>%
          setNames(c('wb.name', 'wb', 'wb.region', 'wb.income')) %>%
          dplyr::mutate(country.name.en.regex = CountryToRegex(wb.name, warn = FALSE)) %>%
          dplyr::select(country.name.en.regex, wb, wb.name, wb.region, wb.income) %>%
          na.omit

    return(wb)
}
