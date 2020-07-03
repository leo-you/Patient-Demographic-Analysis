library(readxl)
library(ggplot2)
library(dplyr)
library(reshape2)
library(nnet)
library(MASS)
library(randomForest)


Patient_Demographic_Analysis <- read_excel("U:/Analysis/Patient Demographic Analysis.xlsx")

Patient_Demographic_Analysis_cleaned <- Patient_Demographic_Analysis %>%
  dplyr::select(person_nbr,age,language,gender,Marketing_Source,Distance,Nextgen_Financial_Class,Booked,Kept) %>%
  # select(person_nbr,age,language,gender,Marketing_Source,Distance,Nextgen_Financial_Class,Booked,Kept) %>%
  mutate(gender = as.factor(gender),
         language = as.factor(language),
         Marketing_Source = as.factor(Marketing_Source),
         Nextgen_Financial_Class = as.factor(Nextgen_Financial_Class),
         Booked = as.factor(Booked),
         Kept = as.factor(Kept)) %>%
  filter(Distance <= 50)

ggplot(Patient_Demographic_Analysis_cleaned,aes(x = Booked,y = Distance)) + 
  geom_boxplot()

ggplot(Patient_Demographic_Analysis_cleaned,aes(x = Booked,y = age)) + 
  geom_boxplot()


set.seed(100)

trainingRows <- sample(1:nrow(Patient_Demographic_Analysis_cleaned), 0.7*nrow(Patient_Demographic_Analysis_cleaned))
training <- Patient_Demographic_Analysis_cleaned[trainingRows, ]
test <- Patient_Demographic_Analysis_cleaned[-trainingRows, ]


model_booked <- glm(Booked ~ age + language + gender + Marketing_Source + Distance + Nextgen_Financial_Class, 
                         data = training,family = "binomial") 


# model_booked <- multinom(Booked ~ age + language + gender + Marketing_Source + Distance + Nextgen_Financial_Class, 
#                   data = training)


output_booked <- summary(model_booked)


pred_booked <- predict(model_booked, test,type="response")
pred_booked <- ifelse(pred_booked > 0.5, 1, 0)


# pred_booked[1:20]
# test$Booked[1:20]


cm_booked <- table(pred_booked, test$Booked)


## misclassification rate
1 - sum(diag(cm_booked))/sum(cm_booked)

# z_booked <- output_booked$coefficients/output_booked$standard.errors
# p_booked <- (1 - pnorm(abs(z_booked),0,1)) * 2
# p_booked

# step_model_booked <- model_booked %>%
#   stepAIC(trace = FALSE)
# 
# summary(step_model_booked)


#########

model_kept <- glm(Kept ~ age + language + Marketing_Source + Distance + Nextgen_Financial_Class, 
                       data = training,family = "binomial")



# model_kept <- multinom(Kept ~ age + language + gender + Marketing_Source + Distance + Nextgen_Financial_Class, 
#                          data = training)


output_kept <- summary(model_kept)


pred_kept <- predict(model_kept, test,type = "response")
pred_kept <- ifelse(pred_kept > 0.5, 1, 0)


cm_kept <- table(pred_kept, test$Kept)

1 - sum(diag(cm_kept))/sum(cm_kept)

step_model_kept <- model_kept %>% stepAIC(trace = FALSE)


summary(step_model_kept)


z_kept <- output_kept$coefficients/output_kept$standard.errors
p_kept <- (1 - pnorm(abs(z_booked),0,1)) * 2
p_kept


#### random forest ####


rf_model <- randomForest(Booked ~ age + language + gender + Marketing_Source + Distance + Nextgen_Financial_Class, 
                         data = training[1:25000,], proximity = TRUE)

rf_model

#### random forest ####





