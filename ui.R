library("shiny")
ui <- fluidPage(
  fluidRow(column(12, tags$div(style="height:8%;text-align:center;",
                               tags$h2("Understanding Central Limit Theorem")
  )
  )
  ),
  fluidRow(column(12, tags$div(style="height:12%;text-align:left;",
                               tags$p(tags$strong("Introduction:"), "Central Limit Theorem (CLT) is one of the most fundamental statistical theorems. Briefly,
                                      it states that given certain conditions, the arithmetic mean of a sufficiently large number of iterates of independent 
                                      random variables, will be approximately normally distributed, regardless of the underlying distribution. Here, in
                                      this application, the user can perform many random samplings from various distributions, in order to verify 
                                      the CLT statement."), 
                               tags$p(tags$strong("Tips:"), "Select the preferred distribution, its parameters and sampling sizes, and click the 
                                      'Generate the Histogram of Means' button. The calculated distribution will be visualized. Also, histogram 
                                      is automatically reformed, when the distribution parameters are redefined.")
                               )
                               )
                               ),  
  fluidRow(
    column(8, tags$div(style="height:45%;",
                       fluidRow(
                         column(12,
                                tags$h3(tags$strong("Select Distribution & Define Parameters")),
                                tags$br()
                         )
                       ),
                       fluidRow(
                         column(5,
                                selectInput(inputId = "distribution",
                                            label = tags$h4(tags$strong("1. Distribution:")),
                                            choices = c("Normal"="normal",
                                                        "Uniform"="uniform",
                                                        "Poisson"="poisson",
                                                        "Chi-squared"="chi.squared"
                                            )
                                ),
                                tags$br(),
                                uiOutput("input.mean"),
                                uiOutput("input.stdev"),
                                uiOutput("input.alpha"),
                                uiOutput("input.beta"),
                                uiOutput("input.lambda"),
                                uiOutput("input.df")
                         ),
                         column(7, 
                                tags$h4(tags$strong("2. Sampling:")),
                                sliderInput(inputId="sample",
                                            label=tags$p("Size of Every Random Sample:"),
                                            value=150, min=10, max=300),
                                sliderInput(inputId="count",
                                            label=tags$p("Total Amount of Random Samples:"),
                                            value=100, min=30, max=500)
                         )
                       ),
                       tags$br(),
                       actionButton("button", "Generate the Histogram of Means")
    ) # div close
    
    ), # column close
    column(4, tags$div(style="height:45%;",
                       tags$h3(tags$strong("Theory:")),
                       tags$br(),
                       tags$p(style="size:14;", tags$em("Draw a Simple Random Sample (SRS) of ",tags$strong("size n"), " from any population with",
                                                        tags$strong("mean μ")," and finite ",tags$strong("standard deviation σ"),". When n is large, 
                                      the sampling distribution of the sample mean is approximately Normal:")), 
                       withMathJax(helpText("$$\\bar{x} \\sim N(μ, \\frac{σ}{\\sqrt(n)})$$")),
                       tags$p(tags$strong("Reference:")," Moore, McCabe, Craig,", tags$em("Introduction to the Practice of Statistics,"), 
                              "W.H. Freeman and Company, New York, 6th Edition.")
    )
    )),
  tags$br(),
  fluidRow(
    column(8,
           plotOutput("hist")
    ),
    column(4,
           htmlOutput("output.the.title"),
           htmlOutput("output.the.mean"),
           htmlOutput("output.the.stdev"),
           htmlOutput("output.act.title"),
           htmlOutput("output.act.mean"),
           htmlOutput("output.act.stdev")          
    )
    
  )
  )
