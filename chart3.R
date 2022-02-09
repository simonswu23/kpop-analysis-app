# Creating Histograms to show the number of groups that debuted within
# certain time windows.
# Can be used to see a general trend in kpop with more groups debuting as a sign
# of success for the industry.

library(ggplot2)
library("scales")


# Load in data

boy_groups <- read.csv("data/source_2/kpop_idols_boy_groups.csv")
girl_groups <- read.csv("data/source_2/kpop_idols_girl_groups.csv")

# Create chart for boy groups
# Shows the number of boy groups that debuted in each year

boy_groups$Debut <- as.POSIXct(boy_groups$Debut)

boys_chart <- ggplot(boy_groups, aes(Debut, ..count..)) + 
  geom_histogram() +
  theme_bw() + xlab(NULL) +
  scale_x_datetime(breaks = date_breaks("1 year"),
                   labels = date_format("%Y"),
                   limits = c(as.POSIXct("1995-01-01"), 
                              as.POSIXct("2020-12-31")) ) +
  theme(axis.text.x = element_text(angle = 90, vjust = 0.5, hjust=1)) +
  ggtitle("Number of Boy Groups that Debuted in each Year") +
  xlab("Year")

boys_chart

# Create chart for girl groups
# Shows the number of girl groups that debuted in each year

girl_groups$Debut <- as.POSIXct(girl_groups$Debut)

girls_chart <- ggplot(girl_groups, aes(Debut, ..count..)) + 
  geom_histogram() +
  theme_bw() + xlab(NULL) +
  scale_x_datetime(breaks = date_breaks("1 year"),
                   labels = date_format("%Y"),
                   limits = c(as.POSIXct("1995-01-01"), 
                              as.POSIXct("2020-12-31")) ) +
  theme(axis.text.x = element_text(angle = 90, vjust = 0.5, hjust=1)) +
  ggtitle("Number of Girl Groups that Debuted in each Year") + 
  xlab("Year")

girls_chart
