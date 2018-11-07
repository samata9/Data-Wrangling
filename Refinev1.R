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
refine_updated$product_code

#Spell check all company names and replace with correction on updated file
# why use mutate when I can just do equal here?  Mutate not working

#refine_updated$company = ifelse(grepl("ph.*",refine_updated$company),"phillips",
#ifelse(grepl("ak.*",refine_updated$company),"azko",ifelse(grepl("fi.*",refine_updated$company),"phillips",
#  ifelse (grepl("un.*",refine_updated$company),"Unilever",refine_updated$company))))

  
 refine_updated  <- refine_updated %>% 
  mutate(company = gsub('ph.*|fi.*', "phillips", company)) %>%
  mutate(company = gsub('ak.*', "azko", company)) %>%
  mutate(company = gsub ('van.*',"van houten",company)) %>%
  mutate(company = gsub ('uni.*',"unilever",company)) %>% 
  separate("Product.code...number", c("product_code", "product_number"), sep="-") %>%
  unite (full_adress,address,city,country,sep=",") 
  refine_updated$product_catagory <- refine_updated$product_code
  refine_updated$product_catagory
   refine_updated  <- refine_updated %>%
    mutate (product_catagory = gsub ('p',"Smartphone",product_catagory)) %>%
    mutate (product_catagory = gsub ('v',"TV",product_catagory)) %>%
   mutate (product_catagory = gsub ('x',"Laptop",product_catagory)) %>%
   mutate (product_catagory = gsub ('q',"Tablet",product_catagory))
   refine_updated
   # EVERYTHING IS WORKING BEFORE THIS LINE

#refine_updated$company_phillips <- refine_updated$company
#refine_updated$company_azko <- refine_updated$company
#refine_updated$company_vanhouten <- refine_updated$company
#refine_updated$company_unilever <- refine_updated$company

refine_updated$company_phillips <- ifelse(refine_updated$company == "phillips", 1, 0)  
refine_updated$company_azko <- ifelse(refine_updated$company == "azko", 1, 0)
refine_updated$company_azko
refine_updated$company_vanhouten <- ifelse(refine_updated$company == "van houten", 1, 0)
refine_updated$company_unilever <- ifelse(refine_updated$company == "unilever", 1, 0)

refine_updated$product_Smartphone <- ifelse(refine_updated$product_catagory == "Smartphone", 1, 0)  
refine_updated$product_Laptop <- ifelse(refine_updated$product_catagory == "Laptop", 1, 0) 
refine_updated$product_TV <- ifelse(refine_updated$product_catagory == "TV", 1, 0) 
refine_updated$product_Tablet <- ifelse(refine_updated$product_catagory == "Tablet", 1, 0) 
refine_updated

# Write CSV in R
write.csv(refine_updated, file = "RefineUpdated.csv")


#ifelse(refine_updated$company = "phillips", refine_updated$company_phillips = 1, refine_updated$company_phillips = 0)

# Add four binary (1 or 0) columns for company: company_philips, company_akzo, company_van_houten and company_unilever.

# Add four binary (1 or 0) columns for product category: product_smartphone, product_tv, product_laptop and product_tablet.

#refine_updated$company_phillips = ifelse(grepl("phillips",refine_updated$company),1,
#ifelse(grepl("ak.*",refine_updated$company),"azko",ifelse(grepl("fi.*",refine_updated$company),"phillips",
#  ifelse (grepl("un.*",refine_updated$company),"Unilever",refine_updated$company))))



#if (refine_udpated$company = "phillips"){
#  refine_updated$company_phillips = 1 
#} else {
#    refine_updated$company_phillips = 0
#}

