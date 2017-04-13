.onLoad <- function(libname = find.package("fider"), pkgname = "fider") {
  library(readr)
  load.file()
}

load.file <- function() {

  temp.dir <- tempdir()

  file.ranking.zip <- file.path(temp.dir, 'players_list.zip')
  file.ranking <- file.path(temp.dir, 'players_list_foa.txt')

  utils::download.file('http://ratings.fide.com/download/players_list.zip', file.ranking.zip)
  utils::unzip(file.ranking.zip, exdir = temp.dir)

  ratings <- readr::read_fwf(file = file.ranking,
                      skip = 1,
                      fwf_widths(
                        c(15, #ID Number
                          61, #Name
                           4, #Fed
                           4, #Sex
                           5, #Tit
                           5, #WTit
                          15, #OTit
                           4, #FOA
                           6, #SRtng
                           4, #SGm
                           3, #SK
                           6, #RRtng
                           4, #RGm
                           3, #Rk
                           6, #BRtng
                           4, #BGm
                           3, #BK
                           6, #B-day
                           4  #Flag
                        ),
                        c("ID Number",
                          "Name",
                          "Fed",
                          "Sex",
                          "Tit",
                          "WTit",
                          "OTit",
                          "FOA",
                          "SRtng",
                          "SGm",
                          "SK",
                          "RRtng",
                          "RGm",
                          "Rk",
                          "BRtng",
                          "BGm",
                          "BK",
                          "B-day",
                          "Flag"
                        )
                      )
                    )

  save(ratings, file = "data/ratings.Rda")

  file.remove(file.ranking.zip)
  file.remove(file.ranking)
}
