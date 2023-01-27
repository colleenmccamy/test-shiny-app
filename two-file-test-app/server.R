# creating server input and output
server <- function(input, output){
  
  
  trout_filtered_df <- reactive({
    
    validate(
      need(length(input$channel_type_input) > 0, "Please selection one channel type."),
      need(length(input$section_input)> 0, "Select at least one forest section.")
    )
    
    clean_trout |> 
      filter(channel_type %in% c(input$channel_type_input)) |> 
      filter(section %in% c(input$section_input))
  })
  
  output$trout_scatterplot <- renderPlot({
    
    ggplot(na.omit(trout_filtered_df()), aes(x = length_mm,
                                           y = weight_g,
                                           color = channel_type)) +
      geom_point(alpha = 0.5, size = 5) +
      theme_minimal() +
      scale_color_manual(values = c("R" = "#8ecae6",
                                    "C" = "#99ca3c",
                                    "S" = "#126782",
                                    "P" = "#023047",
                                    "SC" = "#ffb703",
                                    "I" = "#fd9e02",
                                    "IP" = "#fb8500"
      )) +
      labs(x = "Weight (g)",
           y = "Length (mm)",
           title = "Trout Length & Weight")
    
  }, alt = "some alt text") # ALT TEXT outside of squiggly but inside paranthesis of rendered plot
}