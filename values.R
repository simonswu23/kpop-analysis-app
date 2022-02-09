library(dplyr)

KpopData <- read_excel("KpopData.xlsx")
Kpop_means <- subset(KpopData, select = -c(1:3))
Kpop_means <- aggregate(.~Year, Kpop_means, mean)

summary_info <- list()
summary_info$num_observations <- nrow(Kpop_means)
summary_info$max_danceability <- Kpop_means %>%
  filter(danceability == max(danceability, na.rm = T)) %>%
  select(Year, danceability)
summary_info$max_energy <- KpopData %>%
  filter(energy == max(energy, na.rm = T)) %>%
  select(Year, energy)
summary_info$max_loudness <- KpopData %>%
  filter(loudness == max(loudness, na.rm = T)) %>%
  select(Year, loudness)
summary_info$max_speechiness <- KpopData %>%
  filter(speechiness == max(speechiness, na.rm = T)) %>%
  select(Year, speechiness)
summary_info$max_acousticness <- KpopData %>%
  filter(acousticness == max(acousticness, na.rm = T)) %>%
  select(Year, acousticness)
