# attach packages

library(shiny)
library(tidyverse)
library(palmerpenguins)


# create ui
ui <- fluidPage(
    titlePanel("this is a title"),
    sidebarLayout(
        sidebarPanel("widgets here",
                     radioButtons(inputId = "penguin_sp",
                                  label = "Choose pengin species",
                                  choices = c("Adelie", "Cool Chinstrap" = "Chinstrap", "Gentoo")
                                  )
                     ),
        mainPanel("here is output",
                  plotOutput(outputId = "penguin_plot"))
    )

)


# create server

server <- function(input, output) {

    penguin_select <- reactive({
        penguins %>%
            filter(species == input$penguin_sp)
    })

   output$penguin_plot <- renderPlot({

       ggplot(data = penguin_select(), aes(x = flipper_length_mm, y = body_mass_g)) +
           geom_point()

   })

}


shinyApp(ui = ui, server = server)
