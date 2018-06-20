testInput <- data.frame("xAxis" = c("first", "second", "third"), "yAxis" = c(20, 200, 60))

# Changeable variables
yMax <- 220
plotHeight <- 5
textSize <- 4

# Set up labels
geomTextList <- {
  textHeightRatio <- textSize / height
  maxHeightRatio <- yMax / height

  values <- testInput[["yAxis"]]

  ### THIS IS THE FORMULA NEEDING UPDATING
  testInput[["labelPositions"]] <- values + 5 # # Should instead be a formula eg. (x * height) + (y * textSize) + (z * yMax)?    
  list(
    ggplot2::geom_text(data = testInput, ggplot2::aes_string(x = "xAxis", y = "labelPositions", label = "yAxis"), hjust = 0.5, size = textSize)
  )
}

# Create plot
outputPlot <- ggplot2::ggplot(testInput) +
  ggplot2::geom_bar(data = testInput, ggplot2::aes_string(x = "xAxis", y = "yAxis"), stat = "identity", position = "dodge", width = 0.5) +
  geomTextList +
  ggplot2::scale_y_continuous(breaks = seq(0, yMax, yInterval), limits = c(0, yMax))

ggplot2::ggsave(filename = "test.png", plot = outputPlot, width = 4, height = plotHeight, device = "png")
