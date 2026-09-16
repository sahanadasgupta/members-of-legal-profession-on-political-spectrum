
load("lawyers.RData") 

library(dplyr)
library(ggplot2)

lawyers_clean <- lawyers %>% 
  mutate(
    INDIV = if_else(contributor.type == "C", FALSE, TRUE)
  ) %>% 
  filter(!is.na(INDIV))

indiv_lawyers <- lawyers_clean %>% 
  filter(INDIV == TRUE)

# State by state comparison with respect to gender
# Califonia
# Penn
# 

Ideo_by_gender_CA_PA <- indiv_lawyers %>% 
  filter(contributor.gender != "U") %>%
  filter(most.recent.contributor.state %in% c("CA", "PA")) %>% 
  group_by(contributor.gender, most.recent.contributor.state) %>% 
  summarize(
    mean_ideo = mean(contributor.cfscore, na.rm = TRUE),
    .groups = 'keep'
    )

ideo_by_gender <- indiv_lawyers %>% 
  filter(contributor.gender != "U") %>% 
  filter(most.recent.contributor.state %in% c("CA", "PA")) 

ggplot(ideo_by_gender, aes(x = contributor.gender, y = contributor.cfscore))+
  #geom_point(alpha = 0.5, position = position_jitter())+
  geom_boxplot()+
  facet_wrap(~most.recent.contributor.state)+
  theme_bw()

# T-test comparing CF Score by gender
# H0 = means are equal for men and women
# H1 = means are not eqaul for men and women

# CA
CA_dat <- indiv_lawyers %>% 
  filter(contributor.gender != "U") %>% 
  filter(most.recent.contributor.state == "CA") 

# Reject H0 for CA
t.test(CA_dat$contributor.cfscore ~ CA_dat$contributor.gender)

# PA
PA_dat <- indiv_lawyers %>% 
  filter(contributor.gender != "U") %>% 
  filter(most.recent.contributor.state == "PA") 

# Reject the null
t.test(PA_dat$contributor.cfscore ~ PA_dat$contributor.gender)

# Chi Square Test for Men/Women in CA vs PA

CA_PA <- indiv_lawyers %>% 
  filter(contributor.gender != "U") %>%
  filter(most.recent.contributor.state %in% c("CA", "PA"))

# counting number of men and women in each state (CA, PA) who are lawyers

table(CA_PA$contributor.gender, CA_PA$most.recent.contributor.state)

chisq.test(CA_PA$contributor.gender, CA_PA$most.recent.contributor.state)

# Corporations

Corp <- lawyers_clean %>% 
  filter(INDIV == FALSE)

names(Corp)

summary(Corp$contributor.cfscore)
summary(indiv_lawyers$contributor.cfscore)

ggplot(lawyers_clean, aes(x = contributor.cfscore, fill = INDIV))+
  geom_density(alpha = 0.5)+
  geom_vline(xintercept = -0.3528, linetype = "dotted")+
  geom_vline(xintercept = 0.0941, linetype = "dashed")+
  theme_bw()

t.test(lawyers_clean$contributor.cfscore ~ lawyers_clean$INDIV)

summary(Corp$amount_2020)
summary(indiv_lawyers$amount_2020)

donations_2020 <- lawyers_clean %>% 
  filter(amount_2020 != 0) %>% 
  filter(amount_2020 <= 1500)

ggplot(donations_2020, aes(x = amount_2020, fill = INDIV))+
  geom_density(alpha = 0.5)+
  geom_vline(xintercept = 166.4, linetype = "dotted")+
  geom_vline(xintercept = 723, linetype = "dashed")+
  theme_bw()

donations_2008 <- lawyers_clean %>% 
  filter(amount_2008 != 0 & amount_2008 <= 1500) %>% 
  select(INDIV,amount_2008) %>% 
  reshape2::melt(by = "INDIV")

donations_2012 <- lawyers_clean %>% 
  filter(amount_2012 != 0 & amount_2012 <= 1500) %>% 
  select(INDIV,amount_2012) %>% 
  reshape2::melt(by = "INDIV")

donations_2016 <- lawyers_clean %>% 
  filter(amount_2016 != 0 & amount_2016 <= 1500) %>% 
  select(INDIV,amount_2016) %>% 
  reshape2::melt(by = "INDIV")

donations_2020 <- lawyers_clean %>% 
  filter(amount_2020 != 0 & amount_2020 <= 1500) %>% 
  select(INDIV,amount_2020) %>% 
  reshape2::melt(by = "INDIV")

donations <- bind_rows(donations_2008, donations_2012, donations_2016, donations_2020)

ggplot(donations, aes(x = value, fill = INDIV))+
  geom_density(alpha = 0.5)+
  facet_wrap(~variable, nrow = 1)+
  theme_bw()+
  theme(legend.position = 'bottom')
