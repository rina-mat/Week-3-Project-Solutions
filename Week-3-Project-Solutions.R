
### Question 1 ###

communityServeyFile <- download.file("https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06hid.csv", destfile = "G:/R Files/R Learning From Coursera/Week 3 project/amerian_comm_servey.csv")
ServeyData <- read.csv("amerian_comm_servey.csv")
agricultureLogical <- (ServeyData$ACR == 3 & ServeyData$AGS == 6)
SelectedData <- ServeyData[which(agricultureLogical),]
which(agricultureLogical) ## SOlution


### Question 2 ###

install.packages("jpeg")
library(jpeg)
#jeffPic2 <- download.file("https://d396qusza40orc.cloudfront.net/getdata%2Fjeff.jpg")

getPicData <-  readJPEG("getdata_jeff.jpg", native = TRUE)

Data <-summary(getPicData) 
quantile(getPicData, c(.30,.80)) ## Solution



### Question 3 ###

GDP_file <- download.file("https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FGDP.csv", destfile = "G:/R Files/R Learning From Coursera/Week 3 project/gdp_data.csv")
EDU_file <- download.file("https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FEDSTATS_Country.csv", destfile = "G:/R Files/R Learning From Coursera/Week 3 project/edu_data.csv")

gdp_data <- read.csv("gdp_data.csv",skip = 4, stringsAsFactors = FALSE)
edu_data <- read.csv("edu_data.csv", stringsAsFactors = FALSE)
gdp_data <- as.data.frame(gdp_data)
#edu_data <- as.data.frame(edu_data)

library(dplyr)
gdp_data<-select(gdp_data,X,X.1,X.3,X.4)
gdp_data <- rename(gdp_data[1:190, ], country.code = X, Rank = X.1, country_name = X.3, millions_of_usd = X.4)
lapply(gdp_data, class)
gdp_data$Rank <- as.numeric(gdp_data$Rank)
lapply(gdp_data, class)
gdp_data <- select(gdp_data, country.code, Rank, country_name, millions_of_usd)
edu_data <- rename(edu_data, country.code = CountryCode, country_name = Long.Name)
merged_data <- inner_join(gdp_data, edu_data, by = "country.code") ## 189 matches
#merged_data <- select(merged_data)

arranged_data <- arrange(merged_data, desc(Rank)) ### 13th : St. Kits and Nevis



### Question 4 ###

data <- merged_data

averageGDP <- tapply(data$Rank, data$Income.Group, mean)

quantile(data$Rank)
table_gdp_income_group <- table(data$Rank, data$Income.Group)
income_group_data <- data[(data$Income.Group %in% "Lower middle income"), ]
income_group_data_under_38 <- filter(income_group_data, income_group_data$Rank <= 38) ### Solution: 5 countries


