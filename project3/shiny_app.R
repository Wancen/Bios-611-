library(shiny)
library(tidyverse)

top10collaborator<-read.csv("top10collaborator.csv",stringsAsFactors = FALSE)

mostwords2<-aggregate(nword~collaborator+word,data = top10collaborator,sum) %>% arrange(collaborator,desc(nword))
collaboratorname<-top10collaborator[!duplicated(top10collaborator$collaborator),] %>% arrange(desc(n))
# basic structure
# Define UI for app that draws a histogram and a data table----
ui <- fluidPage(
  
  # App title ----
  titlePanel("Top ten collaborating institutions with differentiating words in the abstracts"),
  
  # Sidebar layout with input and output definitions ----
  sidebarLayout(
    
    # Sidebar panel for inputs ----
    sidebarPanel(
      
      # Input: Integer for the number of bins ----
      selectInput(inputId = "collaborator",
                   label = "Top 10 collaborators:",
                  choices = unique(top10collaborator$collaborator)),
      textInput(inputId = "words",
                label = "Interested subjects:",
                value = "hpv",
                width = 400)
    ),
    
    
    # Main panel for displaying outputs ----
    mainPanel(
      column(width = 12,
      # Output: Histogram and ----
      plotOutput(outputId = "collaboratorPlot")),
      br(),br(),br(),br(),br(),br(),
      textOutput('caption1'),
      tags$style("#caption1 {font-size:20px;
               color:blue;
                 display:block; }"),
      tableOutput(outputId ="tablecollabortor"),
      textOutput('caption2'),
      tags$style("#caption2 {font-size:20px;
               color:blue;
                 display:block; }"),
      tableOutput(outputId ="tablewords")
    )
  )
)



# Define server logic required to draw a histogram ----
server <- function(input, output) {
  
  dataset<-reactive({top10collaborator})
  
  # renderPlot creates histogram and links to ui
  output$collaboratorPlot <- renderPlot({
    #Let the color of choosen collaborator turn red
    #Give a default color value
    collaboratorname<- collaboratorname %>% mutate( ToHighlight = ifelse( str_detect(collaboratorname$collaborator,input$collaborator), "yes", "no" ) )
    ggplot(data=collaboratorname,aes(x=reorder(collaborator,n,FUN=sum),y=n,fill = ToHighlight)) +
      geom_bar(stat="identity",show.legend = FALSE) +coord_flip() +
      geom_text(aes(label=n), vjust=0)+
      scale_fill_manual( values = c( "yes"="red", "no"="gray" ), guide = FALSE )+
      labs(x = "Collaborator",y="Count",title ="Histogram of top 10 collaborators")+
      theme_minimal()+
      theme(plot.title = element_text(hjust = 0.5,size=15,face="bold.italic"),
            axis.text.y = element_text(face="plain",size=11))
  })
  
 
  output$tablecollabortor <- renderTable({
    
    filtered1 <-mostwords2 %>%
      filter(str_detect(collaborator, input$collaborator))
    colnames(filtered1)<-c("Key Word","Title","Times of appearence")
    filtered1
  })
  
  output$caption1<-renderText({paste("All key words related to",input$collaborator)})
  output$caption2<-renderText({paste("All abstracts related to",input$words)})
  output$tablewords <- renderTable({
    filtered2 <-
      top10collaborator %>%
      filter(word == input$words) %>% 
      select(collaborator, title,nword) 
    colnames(filtered2)<-c("Collaborator","Title","Times of appearence")
    filtered2
  })
}

shinyApp(ui = ui, server = server)   