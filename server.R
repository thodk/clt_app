library(shiny)
library(ggplot2)


server <- function(input, output) {
  
    distribution <- reactive({input$distribution})
  
    # SET NEW NUMERIC INPUT, ACCORDING TO SELECTED DISTRIBUTION
    output$input.mean <- renderUI({
        if (distribution()=="normal"){
            numericInput(inputId = "mean", label="Mean", value=0, width = "30%")
    }})
    output$input.stdev <- renderUI({
        if (distribution()=="normal"){
            numericInput(inputId = "stdev", label="Standard Deviation", value=1, width = "30%")
    }})
    output$input.alpha <- renderUI({
        if (distribution()=="uniform"){
            numericInput(inputId = "alpha", label="Alpha", value=0, width = "30%")
    }})
    output$input.beta <- renderUI({
        if (distribution()=="uniform"){
            numericInput(inputId = "beta", label="Beta", value=1, width = "30%")
    }})  
    output$input.lambda <- renderUI({
        if (distribution()=="poisson"){
            numericInput(inputId = "lambda", label="Lambda", value=0.2, width = "30%")
    }})  
    output$input.df <- renderUI({
      if (distribution()=="chi.squared"){
        numericInput(inputId = "df", label="Degrees of Freedom", value=3, width = "30%")
      }})  
     
  # ACTIONS WHEHN THE BUTTON IS CLICKED
    observeEvent(input$button, {
        if (distribution() == "normal") {
            sample <- reactive({
                sapply(1:input$count, function(i){
                    x <- rnorm(input$sample, mean=input$mean, sd=input$stdev)
                    mean(x)
                })
            })
            output$output.the.mean <- renderUI({
                tags$p("Mean:", round(input$mean, 3))
            })
            output$output.the.stdev <- renderUI({
                tags$p("Standard Deviation:", round(input$stdev/sqrt(input$sample), 3))
            })    
      } else if (distribution() == "uniform") {
            sample <- reactive({
                sapply(1:input$count, function(i){
                    x <- runif(input$sample, min = input$alpha, max = input$beta)
                    mean(x)
                })
            })
            output$output.the.mean <- renderUI({
                tags$p("Mean:", round((input$alpha + input$beta)/2, 3))
            })
            output$output.the.stdev <- renderUI({
                tags$p("Standard Deviation:", round(sqrt(1/12*(input$alpha + input$beta))/sqrt(input$sample), 3))
            })  
      } else if (distribution() == "poisson") {
            sample <- reactive({
                sapply(1:input$count, function(i){
                    x <- rpois(input$sample, lambda = input$lambda)
                    mean(x)
                })
            })
            output$output.the.mean <- renderUI({
                tags$p("Mean:", round(input$lambda, 3))
            })
            output$output.the.stdev <- renderUI({
                tags$p("Standard Deviation:", round(sqrt(input$lambda)/sqrt(input$sample), 3))
            })  
      } else if (distribution() == "chi.squared"){
            sample <- reactive({
              sapply(1:input$count, function(i){
                x <- rchisq(input$sample, df = input$df)
                mean(x)
              })
            })
            output$output.the.mean <- renderUI({
              tags$p("Mean:", round(input$df, 3))
            })
            output$output.the.stdev <- renderUI({
              tags$p("Standard Deviation:", round(sqrt(2*input$df)/sqrt(input$sample), 3))
            })         
      }
      output$hist <- renderPlot({
          df <- data.frame(means = sample())
          g <- ggplot(data=df, aes(x=means)) + 
            geom_histogram(fill="red4", color="black", aes(y =..density..)) + 
            geom_density(colour="black", size=2) + 
            theme(legend.position="none")
          print(g)
      })
      output$output.act.mean <- renderUI({
          tags$p("Mean:", round(mean(sample()), 3))
      })
      output$output.act.stdev <- renderUI({
          tags$p("Standard Deviation:", round(sd(sample()), 3))
      })
      output$output.act.title <- renderUI({
        tags$h4(tags$strong("Actual values (based on random sampling):"))
      })
      output$output.the.title <- renderUI({
        tags$h4(tags$strong("Theoretical values (according to CLT):"))
      })
  })
}
