kpopdata <- read_excel("KpopData.xlsx")

# Introduction
introduction_tab <- tabPanel(
  "Introduction",
  fluidPage(
    includeCSS("styles.css"),
    h1("Background"),
    p("We found K-Pop to be a good topic because it's a media data landscape
       that is rife with layers of racialization and gender. We thought it would
       be particularly interesting to compare the global data trends of K-Pop,
       especially being situated in a very Western data context at UW. Finally,
       we all found a racial connection to the topic; living in the diaspora of
       Asian-America, understanding the reach of a very much Asian (without
       American)-based phenomenon in the US produces layers of personal
       significance and self-reflexivity in understanding and re-articulating
       the 'Asian-ness' that we've been dispossessed of. We will be using the
       'K-Pop Hits Through The Years' dataset which contains hit/top
       songs in K-Pop from the 90s to the latest year using Apple Music and
       Spotify. Each song contains information such as its danceability, energy,
       loudness, and more."),
    h1("Driving Questions"),
    tags$li("Overall, what qualities of musicality does KPop do the best in?"),
    tags$li("How has the qualities of musicality of K-Pop trended over time?"),
    tags$li("Where does popularity spike within  K-Pop world between boy
            groups, girl groups, solo artists, and mixed groups?"),
    br(),
    img("", src = "https://media.giphy.com/media/UWmerXS1W8h7CML7tG/giphy.gif")
  )
)

# Interactive Page 1
x_options <- c(
  "Danceability" = "danceability",
  "Energy" = "energy",
  "Loudness" = "loudness",
  "Speechiness" = "speechiness",
  "Acousticness" = "acousticness",
  "Valence" = "valence",
  "Tempo" = "tempo"
)

y_options <- c(
  "Danceability" = "danceability",
  "Energy" = "energy",
  "Loudness" = "loudness",
  "Speechiness" = "speechiness",
  "Acousticness" = "acousticness",
  "Valence" = "valence",
  "Tempo" = "tempo"
)

plot1_sidebar <- sidebarPanel(
  selectInput(
    inputId = "plot1_x_axis",
    label = "X Axis",
    choices = x_options,
    selected = x_options[1]
  ),
  br(),
  selectInput(
    inputId = "plot1_y_axis",
    label = "Y Axis",
    choices = y_options,
    selected = y_options[2]
  ),
  br(),
  textInput(
    inputId = "plot1_year",
    label = "Year",
    value = "2020"
  )
)

plot1_main <- mainPanel(
  plotlyOutput(outputId = "plot1plot")
)

interact1_tab <- tabPanel(
  "Song Variable Comparison",
  sidebarLayout(
    plot1_sidebar,
    plot1_main
  )
)

# Interactive Page 2
kpopdata2 <- subset(kpopdata, select = -c(1:3))
kpopdata_year <- aggregate(. ~ Year, kpopdata2, mean)
kpopdata_year$duration_ms <- kpopdata_year$duration_ms / 1000 / 60
kpopdata_year <- filter(kpopdata_year, Year != "1990")
colnames(kpopdata_year) <- c(
  "Year", "Danceability", "Energy", "Key",
  "Loudness", "Mode", "Speechiness", "Acousticness",
  "Valence", "Tempo", "Duration (Minutes)",
  "Time Signature"
)

plot2_sidebar <- sidebarPanel(selectInput(
  inputId = "y_axis_input",
  label = "Y Axis",
  choices = list(
    "Danceability" = "Danceability",
    "Energy" = "Energy",
    "Key" = "Key",
    "Loudness" = "Loudness",
    "Mode" = "Mode",
    "Speechiness" = "Speechiness",
    "Acousticness" = "Acousticness",
    "Valence" = "Valence",
    "Tempo" = "Tempo",
    "Duration (Minutes)" = "Duration (Minutes)",
    "Time Signature" = "Time Signature"
  ),
  selected = "Danceability"
))

plot2_main <- mainPanel(
  plotlyOutput(outputId = "time_plot")
)

interact2_tab <- tabPanel(
  "KPop Hits Over Time",
  sidebarLayout(
    plot2_sidebar,
    plot2_main
  )
)

# Interactive Page 3
debut_input <- radioButtons(
  "boygirl",
  "Select Boy or Girl Groups:",
  c(
    "Boy Groups" = "boy_groups",
    "Girl Groups" = "girl_groups"
  )
)

plot3_sidebar <- sidebarPanel(
  debut_input
)

plot3_main <- mainPanel(
  plotlyOutput("debutplot")
)

interact3_tab <- tabPanel(
  "Debut Groups Over Time",
  sidebarLayout(
    plot3_sidebar,
    plot3_main
  )
)

# Conclusion
conclusion_tab <- tabPanel(
  "Conclusion",
  fluidPage(
    h1("Conclusion"),
    p("We didn't notice any particularly strong and consistent relationships
      between the variables of musicality with each other, with the exception
      of a medium-positive correlation between energy and loudness."),
    p("Overall, we noticed that there is a steady increase in the popularity of
      KPop over time. We analyzed changes in its musicality to pinpoint possible
      reasons for this. Plot 2 measures different variables over time starting
      from the year 2000 to the year 2020. For the first two variables,
      danceability and energy, there's a general uptrend with some dips in the
      middle. Loudness also has a general uptrend but with less fluctuations
      throughout the years. Most of the other variables generally do not have a
      clear trend with the exception of duration which has a clear downward
      trend. Looking at the time charts for these variables we can see that over
      the years, the top songs in Kpop have more energy, danceability, and
      loudness while also getting shorter in duration."),
    p("Finally, we noticed that recently, the amount of boy groups and girl
      groups debuting are about equal, both peaking around 2018-2019 and falling
      off in 2020. This could be due to COVID. It was also really interesting to
      see how as the years went on, the proportion of boy-group debuts to girl
      group debuts equaled out."),
    p("There were definitely some limitations with our dataset too. For one, we
      cannot completely attribute the changes in musicality to changes in KPop
      popularity, since there may be other factors at play (changing
      geopolitical climate, globalization, etc.). We also initially wanted to
      base our project around geography, but we could not find the appropriate
      data sets for that investigation. These would definitely be factors to
      consider next time if we were to perform a similar exploration."),
    h1("Thank you!"),
    img("", src = "https://media.giphy.com/media/r7CTw3tVsPKEbirQ90/giphy.gif")
  )
)

ui <- navbarPage(
  "K-Pop Analysis",
  introduction_tab,
  interact1_tab,
  interact2_tab,
  interact3_tab,
  conclusion_tab
)
