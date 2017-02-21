library(shiny)

fluidPage(
  titlePanel("Vote Tabulator"),
  sidebarLayout(
    sidebarPanel(
      radioButtons("dataSource", "How will you load your ballots?",
        c("File" = "file", "Manually" = "manual")),
      conditionalPanel(
        condition = "input.dataSource == 'file'",
        fileInput('file1', 'Choose CSV File',
          accept=c('text/csv', 
            'text/comma-separated-values,text/plain', 
            '.csv'))
      ),
      radioButtons("electionType", "What voting scheme will you use",
                   c("Plurality/First Past the Post" = "plurality", "Instant Runoff/Single Transferable Vote" = "instantRunoff"))
    ),
    mainPanel(
      textOutput('winner'),
      plotOutput('summary')
    )
  )
)
