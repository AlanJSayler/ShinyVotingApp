library(shiny)

getResults = function(type,election){
  if(is.null(election)){
    return(list(1, 1))
  }
  return(switch(type,
         plurality = plurality(election),
         instantRunoff = instantRunoff(election)))
}

plurality = function(election){
  return(list(names(sort(summary(as.factor(election[,1])), decreasing = TRUE)[1]),data.frame(election[,1])))
}

instantRunoff = function(election){
  #TODO implement this
  return(list("This voting scheme not yet implemented",1))
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
  
  result <- reactive(
    getResults(input$electionType,reactives$election)
  )
  
  output$winner <-  renderText({
  if(is.numeric(result()[[1]])){
    paste("Enter some ballots to see results")
  }
  else{
  paste("The winner is: ", result()[[1]])
  }
    })
  
  output$summary <- renderPlot({
    if(!is.numeric(result()[[2]])){
      switch(input$electionType,
        plurality = plot(result()[[2]]))
    }
  })
    
    
  
}