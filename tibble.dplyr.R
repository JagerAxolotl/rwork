#Creating a new tibble
weather.tib <- tibble(
  outlook = c("sunny", "sunny", "overcast"),
  temperature = c(85, 80, 83),
  humidity = c(85, 90, 86),
  windy = c(FALSE, TRUE, FALSE),
  play = c("no", "no", "yes")
)
weather.tib

#stringsAsFactors (df vs. tbl)
weather.df <- data.frame(
  outlook = c("sunny", "sunny", "overcast"),
  temperature = c(85, 80, 83),
  humidity = c(85, 90, 86),
  windy = c(FALSE, TRUE, FALSE),
  play = c("no", "no", "yes"), 
  stringsAsFactors = FALSE
)

#Coerce an object to tibble
weather.df <- as_tibble(weather.df)#Not in-place
class(weather.df)

class(mtcars)
as_tibble(mtcars)
#pipe
mtcars %>% as_tibble 
#dimensions 
dim(mtcars)
mtcars %>% dim
#
x <- 10
x %>% as_tibble

#Subsetting-without dplyr
iris <- iris %>% as_tibble #as_tibble(iris)
class(iris)
iris$Sepal.Length
iris[,"Sepal.Length"]
iris[,c(1,5)]
iris[1:50,]
iris[,1:2]
iris[,-c(1,5)] 
iris[iris$Species=="setosa",]
iris[iris$Species=="setosa", c("Sepal.Length","Petal.Length")]
summary(iris) #Book2 Chapter 18.1 Summary Statistics

#dplyr read B2Ch12
browseVignettes(package = "dplyr")

#slice (selet rows from a tibble by integer indexes)
iris %>% as_tibble %>% slice(1)
iris %>% as_tibble %>% slice(1:5)
iris %>% as_tibble %>% slice(c(1,5,8,50))

#select: select columns
#iris$Sepal.Length
iris %>% as_tibble %>% select(Sepal.Length)
#iris[,c("Sepal.Length","Species")]
iris %>% as_tibble %>% select(c(Sepal.Length,Species))
iris[,1]
iris %>% as_tibble %>% select(1)
iris %>% as_tibble %>% select(c(1,5))
iris %>% as_tibble %>% select(1:3)
#excluding column(s)
iris[,-5]
iris %>% as_tibble %>% select(-5)
iris %>% as_tibble %>% select(-c(1,3))
iris %>% as_tibble %>% select(-Species)


#filter: apply a logical expression and return the satisfying rows from a tibble.
#Species=='setosa'
#AND, OR !is.na
#starts_with(), ends_with(), contains()
#select rows of iris whose Species equals "setosa"
iris %>% as_tibble %>% filter(Species=='setosa') 
iris %>% 
  as_tibble %>% 
  filter(Species=='setosa'|Species=='versicolor') 
#is.na
test <- tibble(x=c(2, 1, 3),y=c(NA, "b", "a"))
#only return rows which have NA,missing value
test %>% filter(is.na(y))
#return rows which does not have NA
test %>% filter(!is.na(y))

#Summarise:explore variables and calculate group-based aggregate values 
#summary(): mean,median,max,min,sd,var,...
##
ggplot2::diamonds %>% #entire data is a group
  summarise(price.mean=mean(price))
ggplot2::diamonds %>% #entire data is a group
  summarise(price.mean=mean(price),
            price.max=max(price),
            carat.mean=mean(carat))
#n()
diamonds %>% summarise(n()) #nrow(diamonds)

#group_by: group a tibble into a grouped tibble where
#the succeeding operation will be performed by group.
diamonds %>% summarise(n_distinct(cut))
#find total for each of the five cut groups
diamonds %>% 
  group_by(cut) %>%
  summarise(count=n(), price.mean=mean(price),
            carat.mean=mean(carat))
iris %>% group_by(Species) %>% summarise(n())

#Summarise_if: logical expression or function 
iris %>% summarise_if(is.numeric, mean)
iris %>% select(1:4) %>% summarise_all(mean)
#multiple statistics, max,mean,...
iris %>% 
  summarise_if(is.numeric, funs(max,mean,median,min,sd))



#E3-2 (dplyr)
#library(tidyverse)
class(mtcars)
mtcars %>% 
  as_tibble %>%
  group_by(cyl) %>%
  summarise(n())

mtcars %>% 
  as_tibble %>%
  group_by(cyl) %>%
  summarise(mpg.mean=mean(mpg),disp.mean=mean(disp))






