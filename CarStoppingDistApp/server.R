library(shiny)
library(ggplot2)

# setting up input and output functions
shinyServer(function(input, output) {
        
#add the spline term to the cars dataset
        cars$speedSp <- ifelse(cars$speed - 15 > 0, cars$speed - 15, 0)
#Fitting two linear regression models to evaluate the relationship between speed and distance. 
        
        model1 <- lm(dist ~ speed, data = cars)
        model2 <- lm(dist ~ speedSp + speed, data = cars)
#Get the prediction for model 1 and model 2.
        
        model1pred <- reactive({
                speedInput <- input$numericSpeed
                predict(model1, newdata = data.frame(speed = speedInput))
        })
        
        model2pred <- reactive({
                speedInput <- input$numericSpeed
                predict(model2, newdata = 
                                data.frame(speed = speedInput,
                                           speedSp = ifelse(speedInput - 15 > 0,
                                                          speedInput - 15, 0)))
        })
        
       #Create plot output.
        output$plot1 <- renderPlot({
                speedInput <- input$numericSpeed
                
                plot(cars$speed, cars$dist, xlab = "Speed (miles per hour)", 
                     ylab = "Stopping Distance (ft)", bty = "n", pch = 16,
                     xlim = c(2, 25), ylim = c(0, 120))
               
                 if(input$showModel1){
                        abline(model1, col = "red", lwd = 2)
                }
                if(input$showModel2){
                        model2lines <- predict(model2, newdata = data.frame(
                                speed = 2:25, speedSp = ifelse(2:25 - 15 > 0, 2:25 - 15, 0)
                        ))
                        lines(2:25, model2lines, col = "blue", lwd = 2)
                }
                
                legend(12, 120, c("Linear Model", "Linear Model with Spline"), pch = 16, 
                       col = c("red", "blue"), bty = "n", cex = 1.2)
                points(speedInput, model1pred(), col = "red", pch = 16, cex = 2)
                points(speedInput, model2pred(), col = "blue", pch = 16, cex = 2)
        })
        
        #Outputs prediction value in text for both models.
        output$pred1 <- renderText({
                paste(round(model1pred()), "feet")
        })
        
        output$pred2 <- renderText({
                paste(round(model2pred()), "feet")
        })
})
