rm(list = ls())

library(shiny)

ui <- pageWithSidebar(
  
  headerPanel("Comparison of CDC and Twitter heat maps"),
  
  sidebarPanel(
    
    selectInput("variable", "Select a map from the drop down", 
                c("CDC flu Heatmap","Twitter Heatmap for flu",
                  "Twitter Heatmap for keyword HEADACHE","Twitter Heatmap for keyword FEVER",
                  "Comparison of CDC Heatmap and Twitter Heatmap", 
                  "Comparison of CDC Heatmap and Twitter Heatmap for keyword HEADACHE",
                  "Comparison of CDC Heatmap and Twitter Heatmap for keyword FEVER"))
    
  ),
  
  # Main panel for displaying outputs ----
  mainPanel(
    imageOutput("selected_var", width = "100%", height = "100%"),
    imageOutput("selected_var1", width = "100%", height = "100%")
  )
)


server <- function(input, output) {
  output$selected_var <- renderImage({
    
    if (input$variable == "CDC flu Heatmap") {
      return(list(
        src = "cdc_flu_heatmap.png",
        contentType = "imag1",
        alt = "1"
      ))
    } else if (input$variable == "Twitter Heatmap for flu") {
      return(list(
        src = "tweet_heatmap.jpg",
        filetype = "image/jpeg",
        alt = ""
      ))
    }else if (input$variable == "Twitter Heatmap for keyword HEADACHE") {
      return(list(
        src = "keyword2_headache.jpeg",
        filetype = "image/jpeg",
        alt = ""
      ))
    }else if (input$variable == "Twitter Heatmap for keyword FEVER") {
      return(list(
        src = "keyword1_fever.jpeg",
        filetype = "image/jpeg",
        alt = ""
      ))
    }else if (input$variable == "Comparison of CDC Heatmap and Twitter Heatmap") {
      return(list(
        src = "cdc_flu_heatmap.png",
        contentType = "imag1",
        alt = "1"
      ))
    }
    else if (input$variable == "Comparison of CDC Heatmap and Twitter Heatmap for keyword HEADACHE") {
      return(list(
        src = "cdc_flu_heatmap.png",
        contentType = "imag1",
        alt = "1"
      ))
    }else if (input$variable == "Comparison of CDC Heatmap and Twitter Heatmap for keyword FEVER") {
      return(list(
        src = "cdc_flu_heatmap.png",
        contentType = "imag1",
        alt = "1"
      ))
    }
    
  }, deleteFile = FALSE)
  output$selected_var1 <- renderImage({
    
    if (input$variable == "CDC flu Heatmap") {
      return(list(
        src = "",
        contentType = "imag1",
        alt = ""
      ))
    } else if (input$variable == "Twitter Heatmap for flu") {
      return(list(
        src = "",
        filetype = "image/jpeg",
        alt = ""
      ))
    }else if (input$variable == "Twitter Heatmap for keyword HEADACHE") {
      return(list(
        src = "",
        filetype = "image/jpeg",
        alt = ""
      ))
    }else if (input$variable == "Twitter Heatmap for keyword FEVER") {
      return(list(
        src = "",
        filetype = "image/jpeg",
        alt = ""
      ))
    }else if (input$variable == "Comparison of CDC Heatmap and Twitter Heatmap") {
      return(list(
        src = "tweet_heatmap.jpg",
        contentType = "imag1",
        alt = "1"
      ))
    }
    else if (input$variable == "Comparison of CDC Heatmap and Twitter Heatmap for keyword HEADACHE") {
      return(list(
        src = "keyword2_headache.jpeg",
        contentType = "imag1",
        alt = "1"
      ))
    }else if (input$variable == "Comparison of CDC Heatmap and Twitter Heatmap for keyword FEVER") {
      return(list(
        src = "keyword1_fever.jpeg",
        contentType = "imag1",
        alt = "1"
      ))
    }
    
  }, deleteFile = FALSE)
}



shinyApp(ui, server)