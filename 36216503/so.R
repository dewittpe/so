    library(shiny)
    library(ggplot2)
    set.seed(42)

    runApp(shinyApp(
      ui = fluidPage(plotOutput('plotA', brush = brushOpts(id = 'plotA_brush')),
                     plotOutput('plotZ')),
      server = function(input, output, session) {


        pollData <- reactivePoll(60 * 1000, session,
                                 checkFunc = function(){ Sys.time() },
                                 valueFunc = function(){ data.frame(x = 1:100, y = cumsum(rnorm(100)))})
        output$plotA <- renderPlot({
          dt <- pollData()
          ggplot(dt, aes(x, y)) + geom_line()
        })
        ranges <- reactiveValues(x = NULL, y = NULL)
        observe({
          if (is.null(input$plotA_brush)) {
            brush <- structure(list(xmin = 14.313925002001, xmax = 39.942241912585, ymin = 1.1077251080591, ymax = 5.5028180250535, mapping = structure(list( x = "x", y = "y"), .Names = c("x", "y")), domain = structure(list( left = -3.95, right = 104.95, bottom = -4.07771077213569, top = 9.69030145758825), .Names = c("left", "right", "bottom", "top")), range = structure(list(left = 32.3904099935947, right = 674.020527857828, bottom = 368.859578048224, top = 5.47945189149413), .Names = c("left", "right", "bottom", "top")), log = structure(list(x = NULL, y = NULL), .Names = c("x", "y")), direction = "xy", brushId = "plotA_brush", outputId = "plotA"), .Names = c("xmin", "xmax", "ymin", "ymax", "mapping", "domain", "range", "log", "direction", "brushId", "outputId"))
          } else {
            brush <- input$plotA_brush
          }
          # dput(brush)  # Useful for finding the initial brush
          if(!is.null(brush)) {
            ranges$x <- c(brush$xmin, brush$xmax)
            ranges$y <- c(brush$ymin, brush$ymax)
          } else {
            ranges$x <- NULL
            ranges$y <- NULL
          }
        })
        output$plotZ <- renderPlot({
          dt <- pollData()
          ggplot(dt, aes(x, y)) + geom_line() + coord_cartesian(xlim = ranges$x, ylim = ranges$y)
        })
      }
    ))
