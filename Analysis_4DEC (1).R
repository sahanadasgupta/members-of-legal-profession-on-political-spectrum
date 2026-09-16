load("lawyers.RData")

library(dplyr)
library(ggplot2)

table(lawyers$contributor.gender)

lawyers_clean <- lawyers %>% 
  mutate(
    INDIV = if_else(contributor.type == "C", FALSE, TRUE)
  )

table(lawyers_clean$INDIV, lawyers_clean$contributor.gender)

indiv_lawyers <- lawyers_clean %>% 
  filter(INDIV == TRUE)

range(indiv_lawyers$contributor.cfscore)

summary(indiv_lawyers$amount_2020)

donor_table <- table(indiv_lawyers$amount_2020) %>% 
  as.data.frame()

indiv_lawyers_small_donor <- indiv_lawyers %>% 
  filter(amount_2020 <= 5000)

indiv_lawyers_large_donor <- indiv_lawyers %>% 
  filter(amount_2020 >= 5000 & amount_2020 <= 100000)

ggplot(indiv_lawyers_small_donor, 
       aes(x = contributor.cfscore, y = amount_2020))+
  geom_point(alpha = 0.5)+
  theme_bw()


# Gender

ideo_by_gender <- indiv_lawyers %>% 
  filter(contributor.gender != "U") %>% 
  group_by(contributor.gender) %>% 
  summarize(mean_ideo = mean(contributor.cfscore, na.rm = TRUE))

ideo_by_gender <- indiv_lawyers %>% 
  filter(contributor.gender != "U") %>% 
  filter(most.recent.contributor.state == "FL")

ggplot(ideo_by_gender, aes(x = contributor.gender, y = contributor.cfscore))+
  geom_point(alpha = 0.5, position = position_jitter())+
  geom_boxplot()+
  theme_bw()

