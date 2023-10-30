
### deploy Shiny apps in browser
# https://medium.com/@rami.krispin/deploy-shiny-app-on-github-pages-b4cbd433bdc


### steps 
# 1. make shiny app (here: "shinylive") as always, with subdirectories for data and images (www)
# 2. run below
# 3. stage, commit and push to github repo
# 4. in github repo: settings-->Pages-->choose branch and directory (here: "docs")
# 5. wait
# 6. go to your github page and be happy

# install.packages("pak")
# library("pak")
# pak::pak("posit-dev/r-shinylive")
# pak::pak("rstudio/httpuv")

library(shinylive)
library(httpuv)

# packageVersion("shinylive")
# packageVersion("httpuv")

# export app 
shinylive::export(appdir = "myapp", destdir="docs")

# check if it works locally:
httpuv::runStaticServer("docs", port=8008)
