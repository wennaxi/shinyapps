

#setwd("D:/AHDC - flashdrive/shiny/ahdc_eda_top_bg")
#setwd("/Volumes/WENNA XI/AHDC - flashdrive/shiny/ahdc_comm_detect_lda_18")

library(shiny)
library(ggplot2)



ui <- navbarPage("AHDC -- Stan",
                 
                 tabPanel("Results",
                          fluidRow(
                            column(width = 6, 
                                   plotOutput("stan_cmty")
                                  )
                                  )
                          ),   
                 
                 
                 
                          br(),br(),br(),br(),br(),br(),br(),br(),
                          #br(),br(),br(),br(),br(),br(),br(),br(),
                 #hr(),hr(),hr(),hr(),#hr(),hr(),hr(),hr(),
                          
                          
                          fluidRow(
                            column(10, offset = 1,
                                   "Household residence locations are shown as a random location within the block group to protect the anonymity of study participants."
                            )
                          ),
                          
                          br(),
                          
                          fluidRow(
                            shiny::column(width = 4, offset = 4,
                                          
                                          #wellPanel(
                                          
                                          sliderInput(inputId = "n",
                                                      label = "Community #",
                                                      min = 2, max = 9,  value = 1, step = 1,
                                                      animate = animationOptions(interval = 1500,
                                                                                 loop = TRUE))
                                          #)
                            )
                          )
                 #)
)





server <- function(input, output, session) {
  # Send a pre-rendered image, and don't delete the image after sending it
  output$stan_cmty <- renderImage({
    # When input$n is 3, filename is ./images/image3.jpeg
    filename <- normalizePath(file.path('./plots',
                                        paste('stan_cmty_', input$n, '.jpeg', sep='')))
    
    # Return a list containing the filename and alt text
    list(src = filename,
         width = 600,
         height = 600,
         alt = paste("Image number", input$n))
    
  }, deleteFile = FALSE)
  
 
  
  
}



shinyApp(ui = ui, server = server)


