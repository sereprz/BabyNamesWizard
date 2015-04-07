library(shiny)
library(ggplot2)
library(wordcloud)

shinyServer(function(input, output) {

	sex <- reactive({
		switch(input$sex, 'Boy' = 'M', 'Girl' = 'F', 'Both' = c('F', 'M'))
		})

	top20 <- reactive({
		out <- split(nm[ nm$Year == input$year, ], nm$Sex[nm$Year == input$year])
		out <- lapply(out, function(x) { x[ order(-x$Freq),]})
		top20 <- do.call('rbind', lapply(out, function(x) { x[ 1:30, ]}))
		top20$x <- sample(1:1000, nrow(top20), replace = TRUE)
		top20$y <- sample(1:1000, nrow(top20), replace = TRUE)
		top20$color <- ifelse(top20$Sex == 'F', 'pink', 'steelblue2')
		top20
		})

	col <- reactive({
		switch( input$sex, Boy = c('steelblue2'), Girl = c('pink'), Both = c('pink','steelblue2'))
		})

	df <- reactive({
		nm[ nm$Name == name() & nm$Sex %in% sex() ,]
		})

	name <- reactive({
		unique(nm$Name[ grep(paste('^', input$name , '$', sep = ''), nm$Name, ignore.case  = TRUE) ])
		})

	output$namelist <- renderPrint({
		col()
		})

	output$mostCommon <- renderText({
		#paste('Most popular in', df()[which.max(df()$Prop), 'Year'], '(', df()[which.max(df()$Prop), 'Freq'], 'baby', ifelse(df()[which.max(df()$Prop), 'Sex'] == 'F', 'girls)','boys)') )
		})

	output$nameFrequency <- renderPlot({ 
		ggplot(data = df() , aes(Year, Prop)) + geom_line(aes(color =  Sex), size = 1) + scale_colour_manual(values = col()) + theme_bw() 
		})

	output$topNames <- renderPlot({
		#ggplot(top10(), aes(x = Name, y = Prop, label = Name, color = Sex)) + geom_text(aes(size = Prop)) + theme_bw() + scale_colour_manual(values = col()) + scale_x_discrete(breaks=NULL) + xlab('') + ylab('')
		par(xaxt = 'n', yaxt = 'n')
		with(top20(), textplot(x, y, Name, log(Freq/min(Freq)) + 1 , show.lines = FALSE, xlab = '', ylab = '', xlim = c(-100, 1100), ylim = c(-100, 1100), col = color, main = paste('Most common baby names in', input$year)))
		})
		
}) # close shinyServer