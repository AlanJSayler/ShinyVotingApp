library(shiny)

chooseWinner = function(type,election){
  return(switch(type,
         plurality = plurality(election),
         instantRunoff = instantRunoff(election)))
}

plurality = function(election){
  return(names(sort(summary(as.factor(election[,1])), decreasing = TRUE)[1]))
}

instantRunoff = function(election){
  #TODO implement this
  return("this voting scheme not yet implemented")
}

getElection = function(inFile){
  if (is.null(inFile))
    return(NULL)
  numChoices = max(count.fields(inFile$datapath,sep = ","))
  return(read.csv(inFile$datapath, header = FALSE, col.names = 1:numChoices))
}

function(input, output) {
  reactives <- reactiveValues()
  
  observe(reactives$election <- getElection(input$file1))
  output$winner <-  renderText({

    
    paste("The winner is: ", chooseWinner(input$electionType,reactives$election))

    })
  

    
    
  
}