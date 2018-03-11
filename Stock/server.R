library('shiny')
library('plotly')
library('reshape')
library('ggplot2')

shinyServer(
  function(input,output){
  
  #Forest Calculations - for stacked bargraph plot  
  forest = read.csv("datasets/forest.csv", header=TRUE)
  forest = data.frame(
    Year = forest$Year,
    Geographical_Area = forest$Geographical.Area,
    Dense_Forests = forest$Very.Dense.Forest+forest$Moderately.Dense.Cover,
    Open_Forests = forest$Open.Forest,
    Scrub = forest$Non.Forest,
    Non_Forest = forest$Non.Forest,
    Mangrove = forest$Mangrove
  )
  morph = melt(forest, id.vars='Year')
  
  wld = read.csv("datasets/world_forest_cover.csv", header=FALSE)
  w = unlist(wld[247,-1])
  i = unlist(wld[105,-1])
  comp = data.frame(Year=1990:2017, World=w, India=i)
  comp_plot = ggplot(comp, aes(x=Year))+geom_line(aes(y=World), colour="red")+geom_line(aes(y=India), colour="green")
  
  tfc = read.csv("datasets/t10fc.csv", header=TRUE)
  tfc.molten = melt(tfc, id.vars = 'Year')
  observeEvent(input$year,{
    toplot = tfc.molten[tfc.molten[,"Year"]==input$year,]
    t10=ggplot(toplot, aes(x=variable, y=value))+geom_bar(stat = 'identity', fill = "darkgreen")+xlab("Countries")+ylab("%Forest Cover")+ggtitle("Top 10 Countries with the most forest cover")
    output$top10=renderPlot(t10)
    }
  )
  
    output$f_text = renderUI(
      h5(
        p("Forestry in India is a significant rural industry and a major environmental resource. India is one of the ten most forest-rich countries of the world along with Russia, Brazil, Canada, United States of America, China, Democratic Republic of the Congo, Australia, Indonesia and Sudan. 
        Together, India and these countries account for 67 percent of total forest area of the world."),
        p(" India's forest cover grew at 0.22 annually over 1990-2000, and has grown at the rate of 0.46% per year over 2000-2010, after decades where forest degradation was a matter of serious concern.")
      )
    )
    
  
    #This will generate the plot of forest covers
    output$forest = renderPlot(
      ggplot(morph,aes(x=Year, y=value,fill=variable))+geom_bar(stat = 'identity')+
      labs( x = "Year", y = "Area covered (in sq mi)", title = "Change in forest covers")
    )
    
    output$compare = renderPlot(comp_plot+ylab("Year")+xlab("% Forest Cover"))
  }
 # forest=function(){}
#  education=function(){}
  )