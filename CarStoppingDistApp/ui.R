library(shiny)
shinyUI(fluidPage(
        #Application Title
        titlePanel("Predict Car Stopping Distance from Speed (mph)"),
        sidebarLayout(
                sidebarPanel(
                        p("This app allows you to predict the stopping distance of a car from the 1920s
                          based on its speed (mph)."),
                        p(""),
                        p("Input the car speed in miles per hour and then
                          select the type of linear model you would like to view. There are two possible model types to view: 
                          a simple linear model (model 1) and a linear model with a spline added at 15 mph (model 2)"),
                        numericInput("numericSpeed", "What is the speed (mph) of the car?", 2, 25, value = 15),
                        checkboxInput("showModel1", "Show/Hide Linear Model", value = TRUE),
                        checkboxInput("showModel2", "Show/Hide Linear Model with Spline", value = TRUE)
                ),
                mainPanel(
                        plotOutput("plot1"),
                        h3("Predicted Stopping Distance from Linear Model:"),
                        textOutput("pred1"),
                        h3("Predicted Stopping Distance from Linear Model with Spline:"),
                        textOutput("pred2"),
                        p(""),
                        p("Note: These prediction values are based on a linear model fit to the R datasets package 'cars'. The cars
                        dataset includes 50 observations of speed and stopping distance recorded in the 1920s.")
                
                        
                        
                )
        )
))
        
