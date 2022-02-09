kpopdata <- read_excel("KpopData.xlsx")
source("chart3.R")

server <- function(input, output) {
  # Interactive Page 1
  output$plot1plot <- renderPlotly({
    plot_data <- kpopdata %>%
      filter(Year == input$plot1_year)

    plot <- ggplot(data = plot_data) +
      geom_point(mapping = aes(
        x = !!as.name(input$plot1_x_axis),
        y = !!as.name(input$plot1_y_axis)
      )) +
      labs(
        x = names(x_options[which(x_options == input$plot1_x_axis)]),
        y = names(y_options[which(y_options == input$plot1_y_axis)]),
        title = paste0(
          "Correlation between ",
          names(x_options[which(x_options == input$plot1_x_axis)]), " and ",
          names(y_options[which(y_options == input$plot1_y_axis)]),
          " in ", input$plot1_year
        )
      )

    plotly_plot <- ggplotly(plot)
    return(plotly_plot)
  })

  # Interactive Page 2
  output$time_plot <- renderPlotly({
    my_plot <- ggplot(data = KpopData_year) +
      geom_line(aes(x = Year, y = !!as.name(input$y_axis_input))) +
      ggtitle(print(paste0(input$y_axis_input, " Over Time")))

    my_plotly_plot <- ggplotly(my_plot)

    return(my_plotly_plot)
  })

  # Interactive Page 3
  output$debutplot <- renderPlotly({
    if (!!as.name(input$boygirl) == "boy_groups") {
      debut_plot <- ggplot(data = boy_groups, aes(Debut, ..count..)) +
        geom_histogram() +
        theme_bw() +
        xlab(NULL) +
        scale_x_datetime(
          breaks = date_breaks("1 year"),
          labels = date_format("%Y"),
          limits = c(
            as.POSIXct("1995-01-01"),
            as.POSIXct("2020-12-31")
          )
        ) +
        theme(axis.text.x = element_text(angle = 90, vjust = 0.5, hjust = 1)) +
        ggtitle("Number of Boy Groups that Debuted in each Year") +
        xlab("Year")
    } else {
      debut_plot <- ggplot(data = girl_groups, aes(Debut, ..count..)) +
        geom_histogram() +
        theme_bw() +
        xlab(NULL) +
        scale_x_datetime(
          breaks = date_breaks("1 year"),
          labels = date_format("%Y"),
          limits = c(
            as.POSIXct("1995-01-01"),
            as.POSIXct("2020-12-31")
          )
        ) +
        theme(axis.text.x = element_text(angle = 90, vjust = 0.5, hjust = 1)) +
        ggtitle("Number of Girl Groups that Debuted in each Year") +
        xlab("Year")
    }
  })
}
