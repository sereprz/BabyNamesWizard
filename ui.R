library(shiny)
library(ggplot2)
library(wordcloud)

shinyUI(pageWithSidebar(

	headerPanel('Baby Names Wizard'),
	
	sidebarPanel(

		p('Use the slide to look at the most popular names by year or enter the name to look at its popularity over time on the Name Voyager tab'),

		sliderInput(inputId = 'year', label = 'Year', min = 1880, max = 2013, value = 1880, step = 1, sep = ''),

		textInput(inputId = 'name', label = 'Baby Name', value = 'Taylor'),

		radioButtons(inputId = 'sex', label = 'Sex', choices = c('Boy','Girl', 'Both'), selected = 'Both')
		
		
				
	),  ## close sidebarPanel
	
	mainPanel(
		tabsetPanel(		
			
			tabPanel(title = 'Most Popular',
				plotOutput( outputId = 'topNames')
				),  ## Close tabPanel 1

			tabPanel(title='Name Voyager',
				h6(textOutput(outputId = 'mostCommon')),
				plotOutput( outputId = 'nameFrequency')
				) ## close tabPanel 2
			
			)	## close tabsetPanel
		)	## close mainPanel
	)	## close pageWithSidebar
)	## close shinyUI