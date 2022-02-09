library(readxl)
library(ggplot2)
KpopData <- read_excel("KpopData.xlsx")
i2 <- subset(KpopData, select = c(4, 15))
chart <- aggregate(.~Year, i2, mean)
plot1 <- ggplot(chart, aes(Year)) + 
  geom_line(aes(y = danceability), lwd = 1.5) +
  ggtitle("Danceability over Time") + 
  labs(y = "Danceability", x = "Time")
plot1