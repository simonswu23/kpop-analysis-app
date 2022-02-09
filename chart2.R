library("tidyverse")
library("readxl")

kpopdata <- read_excel("KpopData.xlsx")

danceability_energy <- kpopdata %>%
  group_by(Year) %>%
  summarise(
    danceability = mean(danceability, na.rm = TRUE),
    energy = mean(energy, na.rm = TRUE)
  )

danceability_energy_plot <- ggplot(data = danceability_energy) +
  geom_point(mapping = aes(x = danceability, y = energy, color = Year)) +
  labs (
    x = "Song Danceability",
    y = "Song Energy",
    title = "Average Song Energy To Its Danceability For Each Year",
    color = "Year"
  )
danceability_energy_plot