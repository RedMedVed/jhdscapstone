library(shiny)
library(shinythemes)
#library(wordcloud)
#data sourcing
#setwd("C:/Users/paralax11/Desktop/Data_Science_Capstone_Project/Project_Capstone/Word_Prediction_Project/Ui-Server")

source("model.R", local = TRUE)

# Designing shiny-server functions
#-------------------------------------------------------------
shinyServer(
    function(input, output, session)
    { # using 'reactive function' as input-word changes
        Word.Prediction <- reactive({
            wordPredict(input$InputText)
        })
        
        # making reactive version of output(HTML) using ShinyUI library
        output$words <- renderUI({
            predictedWords <- Word.Prediction()
            
            # assigning 'predicted-output-text' values to 'WordAssigned' with
            # a 'global-environment' on user-space
            assign('AssignedWords', predictedWords, envir = globalenv()) 
            
            # counting predicted word and matching character conditions
            k <- length(predictedWords)       
            if( k >= 0 && nchar(predictedWords) > 0 )
                
                #-------------------------------------- 
            {  # displaying words inside a button, on user-space
                buttons <- list()
                for(i in 1:k) 
                { buttons <- list(buttons, list(
                    actionButton(inputId = paste("word",i, sep = ""), label = predictedWords[i])))
                }
                # listing the buttons in a tag-list
                tagList( buttons )
            } else { tagList("") }     
        })
        #------------------------------------------------------------------------------------------------------
        # selecting words from buttons instead of typing-in input-box
        # when first output is selected from button output > input box
        
        observeEvent(input$word1, { updateTextInput(session, "InputText", value = paste(input$InputText,
                                                                                        get('AssignedWords', envir=globalenv())[1]))
        })
        
        # when second output is selected into input box
        observeEvent(input$word2, { updateTextInput(session, "InputText", value = paste(input$InputText,
                                                                                        get('AssignedWords', envir=globalenv())[2]))
        })
        #-------------3/4---------------
        
        # when third output is selected
        observeEvent(input$word3, { updateTextInput(session, "InputText", value = paste(input$InputText, 
                                                                                        get('AssignedWords', envir=globalenv())[3]))
        })
        
        
        # when fourth output is selected
        observeEvent(input$word4, { updateTextInput(session, "InputText", value = paste(input$InputText, 
                                                                                        get('AssignedWords', envir=globalenv())[4]))
        })
        #-----------5----------------
        # when fifth output is selected
        observeEvent(input$word5, { updateTextInput(session, "InputText", value = paste(input$InputText, 
                                                                                        get('AssignedWords', envir=globalenv())[5]))
        })
        
    }) # End of shiny server function