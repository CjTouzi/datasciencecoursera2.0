
# q1 ----------------------------------------------------------------------

library(httr)

# 1. Find OAuth settings for github:
#    http://developer.github.com/v3/oauth/
oauth_endpoints("github")
# 2. Register an application at https://github.com/settings/applications;
#    Use any URL you would like for the homepage URL (http://github.com is fine)
#    and http://localhost:1410 as the callback url
#
#    Insert your client ID and secret below - if secret is omitted, it will
#    look it up in the GITHUB_CONSUMER_SECRET environmental variable.
myapp <- oauth_app("github", key="8fe0fb13b92e42e6f8bd", secret="71cbc8c6f4d067bdb2242c9e5a95c73b35cac2bf")
# 3. Get OAuth credentials
github_token <- oauth2.0_token(oauth_endpoints("github"), myapp)

# 4. Use API
gtoken <- config(token = github_token)
req <- GET("https://api.github.com/users/jtleek/repos", gtoken)
stop_for_status(req)
content(req)
content =content(req,as="text")
BROWSE("https://api.github.com/users/jtleek/repos",gtoken)
# search created_at for datasharing


# q2 ----------------------------------------------------------------------

acs=read.csv("./data/acs.csv")
head(acs, 6)
library(sqldf)
require(gsubfn,proto,RSQLite,DBI)



# q3 ----------------------------------------------------------------------
unique(acs$AGEP)
length(unique(acs$AGEP))
length(sqldf("select unique AGEP from acs"))
sqldf("select AGEP where unique from acs")
nrow(sqldf("select distinct AGEP from acs"))
nrow(sqldf("select unique AGEP from acs"))


# q4 ----------------------------------------------------------------------

url="http://biostat.jhsph.edu/~jleek/contact.html"
library(httr)
content= GET(url, as="text")
CharNum= nchar(readLines(url,100))
CharNum[c(10,20,30,100)]




# q5 ----------------------------------------------------------------------

q5=read.csv("data/q5data.csv")
head(q5,20)
dim(q5)
df <- read.fwf("data/q5data.csv", skip=4, widths=c(12, 7,4, 9,4, 9,4, 9,4))
head(df)
head(df$V1)
sum(df$V4)
