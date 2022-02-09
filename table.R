library(dplyr)

KpopData <- read_excel("KpopData.xlsx")
agg_table <- subset(KpopData, select = -c(1:3))

agg_table <- group_by(agg_table, Year) %>%
  summarize(
    Danceability = mean(danceability),
    Energy = mean(energy),
    Loudness = mean(loudness),
    Speechiness = mean(speechiness),
    Acousticness = mean(acousticness)
  )

agg_table <- agg_table %>% 
  mutate_at(vars(-Year), funs(round(., 3)))
