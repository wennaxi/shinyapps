#
# This is a Shiny web application. You can run the application by clicking
# the 'Run App' button above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

# library(shiny)
# 
# # Define UI for application that draws a histogram
# ui <- fluidPage(
#    
#    # Application title
#    titlePanel("Old Faithful Geyser Data"),
#    
#    # Sidebar with a slider input for number of bins 
#    sidebarLayout(
#       sidebarPanel(
#          sliderInput("bins",
#                      "Number of bins:",
#                      min = 1,
#                      max = 50,
#                      value = 30)
#       ),
#       
#       # Show a plot of the generated distribution
#       mainPanel(
#          plotOutput("distPlot")
#       )
#    )
# )
# 
# # Define server logic required to draw a histogram
# server <- function(input, output) {
#    
#    output$distPlot <- renderPlot({
#       # generate bins based on input$bins from ui.R
#       x    <- faithful[, 2] 
#       bins <- seq(min(x), max(x), length.out = input$bins + 1)
#       
#       # draw the histogram with the specified number of bins
#       hist(x, breaks = bins, col = 'darkgray', border = 'white')
#    })
# }
# 
# # Run the application 
# shinyApp(ui = ui, server = server)



# rm(list=ls())
# setwd("D:/AHDC - flashdrive/shiny/ahdc_comm_detect")

library(shiny)
library(ggplot2)


#ui <- fluidPage(



ui <- navbarPage("Community Detection with LDA Models",
                 
                 
                 
                 
                 tabPanel("Results",
                          fluidRow(
                            column(8, offset = 2,
                                   plotOutput("Image_communities")
                                   )
                            ),
                          
                          br(),br(),br(),br(),br(),br(),br(),br(),
                          br(),br(),br(),br(),br(),br(),br(),br(),
                          
                        
                          
                          fluidRow(
                            column(10, offset = 2,
                            "Household residence locations are shown as a random location within the block group to protect the anonymity of study participants."
                            )
                          ),
                          
                          hr(),
                          
                          fluidRow(
                            shiny::column(width = 4, offset = 3,
                                          #wellPanel(
                                          
                                          sliderInput(inputId = "n",
                                                      label = "Number of Communities:",
                                                      min = 2, max = 10,  value = 2, step = 1,
                                                      animate = animationOptions(interval = 1000,
                                                                                 loop = TRUE))
                                          #)
                            )
                          )
                          
                          
                 ),
                 tabPanel("Variable's Distribution by Community",
                          sidebarLayout(position = "left",
                                        sidebarPanel(
                                          selectInput(inputId = "varname",
                                                      label = "Variable",
                                                      choices = c("race", "income", "edu")),
                                          sliderInput(inputId = "n",
                                                      label = "Number of Communities:",
                                                      min = 2, max = 10,  value = 2, step = 1,
                                                      animate = animationOptions(interval = 1000,
                                                                                 loop = TRUE))
                                        ),
                                        mainPanel(
                                          # Use imageOutput to place the image on the page
                                          imageOutput("Image_variables")
                                        )
                          )
                 )
)





server <- function(input, output, session) {
  # Send a pre-rendered image, and don't delete the image after sending it
  output$Image_communities <- renderImage({
    # When input$n is 3, filename is ./images/image3.jpeg
    filename <- normalizePath(file.path('./plots',
                                        paste('lda_topics', input$n, '.jpeg', sep='')))
    
    # Return a list containing the filename and alt text
    list(src = filename,
         width = 800,
         height = 800,
         alt = paste("Image number", input$n))
    
  }, deleteFile = FALSE)
  
  # Send a pre-rendered image, and don't delete the image after sending it
  output$Image_variables <- renderImage({
    # When input$n is 3, filename is ./images/image3.jpeg
    filename <- normalizePath(file.path('./plots',
                                        paste(input$n, 'lda_', input$varname, '_bar', '.jpeg', sep='')))
    
    # Return a list containing the filename and alt text
    list(src = filename,
         width = 600,
         height = 600,
         alt = paste("Image number", input$n))
    
  }, deleteFile = FALSE)
  
  
}



shinyApp(ui = ui, server = server)


