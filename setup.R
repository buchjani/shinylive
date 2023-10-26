
### deploy Shiny apps in browser
# https://medium.com/@rami.krispin/deploy-shiny-app-on-github-pages-b4cbd433bdc

library(shiny)
# install.packages("pak")
# library("pak")
library("dplyr")
# pak::pak("posit-dev/r-shinylive")
# pak::pak("rstudio/httpuv")

library(shinylive)
library(httpuv)


packageVersion("shinylive")
packageVersion("httpuv")

shinylive::export(appdir = "myapp", destdir="docs")
httpuv::runStaticServer("docs", port=8008)

# install.packages('plumber')
# library(plumber)
# pr() %>% pr_static("/", "docs") %>% pr_run()
