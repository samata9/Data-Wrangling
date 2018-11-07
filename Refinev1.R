#Import File
#refine_original <- read.csv(file.choose(), header=TRUE)
setwd("C:/Users/pankaj/Desktop/Samata/Springboard/Data Wrangling Exercise 1/")
refine_original <- read.csv("refine_original.csv", header = TRUE)

#attach(refine_original)
refine_updated <- refine_original

#Change company into lowercase
refine_updated$company <- tolower(refine_updated$company)

library (dplyr)
library(tidyr)
library(magrittr)


#Spell check all company names and replace with correction on updated file
#Separate such that there are seperate column for Product code and Product number
#Give a product catagory to product code

 refine_updated  <- refine_updated %>% 
  mutate(company = gsub('ph.*|fi.*', "phillips", company)) %>%
  mutate(company = gsub('ak.*', "azko", company)) %>%
  mutate(company = gsub ('van.*',"van houten",company)) %>%
  mutate(company = gsub ('uni.*',"unilever",company)) %>% 
  separate("Product.code...number", c("product_code", "product_number"), sep="-") %>%
  unite (full_adress,address,city,country,sep=",") 
  refine_updated$product_catagory <- refine_updated$product_code

  refine_updated  <- refine_updated %>%
  mutate (product_catagory = gsub ('p',"Smartphone",product_catagory)) %>%
  mutate (product_catagory = gsub ('v',"TV",product_catagory)) %>%
  mutate (product_catagory = gsub ('x',"Laptop",product_catagory)) %>%
  mutate (product_catagory = gsub ('q',"Tablet",product_catagory))

# Create dummy variable for company and catagory
refine_updated$company_phillips <- ifelse(refine_updated$company == "phillips", 1, 0)  
refine_updated$company_azko <- ifelse(refine_updated$company == "azko", 1, 0)
refine_updated$company_vanhouten <- ifelse(refine_updated$company == "van houten", 1, 0)
refine_updated$company_unilever <- ifelse(refine_updated$company == "unilever", 1, 0)

refine_updated$product_Smartphone <- ifelse(refine_updated$product_catagory == "Smartphone", 1, 0)  
refine_updated$product_Laptop <- ifelse(refine_updated$product_catagory == "Laptop", 1, 0) 
refine_updated$product_TV <- ifelse(refine_updated$product_catagory == "TV", 1, 0) 
refine_updated$product_Tablet <- ifelse(refine_updated$product_catagory == "Tablet", 1, 0) 
refine_updated

# Write CSV 
write.csv(refine_updated, file = "RefineUpdated.csv")


