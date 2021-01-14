library(shiny)
library(shinythemes)

source('model.R', local = TRUE)

# Define UI for application 
shinyUI(fluidPage
        (navbarPage(theme = shinytheme("united"),
                    strong("Data Science Captone Project: Next - Word - Prediction")),
            sidebarPanel(tags$style(".well {background-color: #01A9DB;}"),
                         h4( HTML("<font color=white><strong>Project Synopsis:</strong></font>")),
                         h4( HTML("<font color=black><b>This application predicts the next probable word choices stems from N-gram logical sequence.</b></font>")), 
                         h4(HTML("<font color=white><b>To use this app, simply type-in words inside the text field on the right screen.")),
                         h4(HTML("<font color=red><b>Every time, if available, this app will display 5 next possible  word choices inside  buttons below.</b></font>")),
                         h4(HTML("<font color=black><b>To explore simpler next word prediction add words from buttons below by clicking on it.</b></font>")),
                         h4(HTML("<font color=white><b>Every single new word-addition of input will predict more word choices inside the buttons.</b></font>")),
                         h4(HTML("<font color=black><b>Each tab-panel offers detail app related resources.</b></font>"))
                   ),
            mainPanel(wellPanel(tags$style(HTML("body {background-color: grey;}")),
                                tabsetPanel
                                (tabPanel
                                    ("Application",(h3("Input your choice words:")),
                                        textInput("InputText", "Type-in or Click-in word(s) from below:", width = "75%"),
                                        h4("The predicted next five to [one] choice words:"),
                                        uiOutput("words"),
                                        hr(),    #style = "background-color: black;"
                                        h5 ("[Please wait for 5-seconds for predicted next words]"),
                                        br(),
                                        h4( "In collaboration with:"),
                                        wellPanel(img(src="coursera.png", height=70, width=250),
                                                  img(src="jhu.png", height=70, width=250),
                                                  img(src="swiftkey.png", height=70, width=200))),
                                    tabPanel("Project Framework",
                                    tags$div(HTML("<font color=black>
                                    <left><h4>Author: Md Ahmed </h4>
                                    <h4>Date: 12th February 2018 </h4>
                                    <hr>
                                    <h5> Github Link : <a href= https://github.com/farhadkpx/Data-Science-Capstone-Project> https://github.com/farhadkpx/Data-Science-Capstone-Project</a> </h5>
                                    <h5> App presentation on R-pub : <a href = http://rpubs.com/Redeemk17/359445 > http://rpubs.com/Redeemk17/359445</a></h5></center>
                                    <h5> Data loading link: <a href = https://d396qusza40orc.cloudfront.net/dsscapstone/dataset/Coursera-SwiftKey.zip> https://d396qusza40orc.cloudfront.net/dsscapstone/dataset/Coursera-SwiftKey.zip</a></h5>
                                    <br>
                                    <left><h4><b>Project Objective sequence</b> </h4><hr>
                                    <h5>The main goal of this capstone project is to build a shiny application, which will be able to predict the next possible word choices.
                                    This project exercise was divided into several sub tasks as such data cleansing, exploratory analysis, finding N-grams sequenes and creating a predictive model for next word choices.
                                    All text data used to create a frequency dictionary in predicting the next words comes from a corpus called HC Corpora.
                              Every necessary text mining and natural language processing(NLP) was done with the use of a variety of well-known R packages.
                              </h5>
                              
                              <h4><b> Applied Data processing Methods </b> </h4>
                              <h5>After creating a sample corpus from the HC Corpora data, it was cleaned by conversion to lowercase, removing punctuation, links, white space, numbers and all kinds of special characters.
                              Then I did tokenizing, the process of breaking up a stream of text into words, phrases, symbols, or other meaningful elements. The list of elements(tokens) becomes input for further processing such as parsing or text mining.
                              Then I build final N-gram word data frame with meaningful tokens combined.</h5> 
                              <h5>By Wiki: In the fields of computational linguistics and probability, an N-gram is a contiguous sequence of n items from a given sequence of text or speech.
                              On this progression, I have created bigram, trigram, fourgram and fivegram N-gram data frame frequency model.
                              Then I used these data model with frequencies to predict the next word in connection with the text input by a user of the above application.[5]
                              </h5>
                              
                              <h4><left> Data sources:</left></h4>
                              <b>The corpus for this model consisted with 3 raw text files: </b>
                              <ol>
                              <li>en_US.blogs.txt</li>
                              <li>en_US.news.txt</li>
                              <li>en_US.twitter.txt</li>
                              </ol>
                              
                              <h5> The data set is reduced(10%) of the total and combined into a single file for faster processing. <h5>
                              <h4>Data Cleaning Activites :</h4> 
                              <ol>
                              <li> Converting to lower case </li>
                              <li> Removing bad words from Corpus </li>
                              <li> Removing Numbers </li>
                              <li> Removing Puntuations </li>
                              <li> Removing Foreign characters </li>
                              <li> Removing extra white spaces </li>
                              <li> Creating a Sample Corpus - with clean data </li>
                              </ol>
                              
                              <left>
                              <h4> N-Gram determination with the (tm) package:</h4>
                              <ol>
                              <li> Tokenizing the 'Sample Corpus' with TermDocumentMatrix function. </li>
                              <li> Convert the tokens in to a matrix.</li>
                              <li> Reordering token-terms (higher > lower) of the matrix by counting frequency.</li>
                              <li> Transforming the matrix into data frame with column names as strings and upward frequency order.</li>
                              <li> Separate them as N-gram data frame names unigram_test, bigram_test, trigram_test, fourgram_test and
                                   fivegram_test with 'Rda' file format. </li>
                              <li> These Rda data frames will be called-in by the algorithm for next word prediction.</li>
                              </ol></font>"
                                          ))),
                                 tabPanel("Model Algorithm",
                                          tags$div(HTML("<font color=black>
                              <left>
                              <h4><b> Model Building</b></h4>
                              <h5> Markov Model Assumptions:</h5>
                              <h5> In search of finding the right next-word-prediction model, I think Markov chain model in collaboration
                                   with Markov random field is the perfect choice. Markov chain model property suggests that the distribution
                                   of a variable depends only on the distribution of previous state with random variables those changes through time.</h5> 
                              <h5> We know that Markov random field is a generalization of Markov chain in multiple dimensions. 
                                   In Markov random field future state of a variable depends on its neighboring variables (existing/previous)
                                   in multiple directions with which it is connected.[4]</h5>
                              <li><h5> In my pursuit to ascertain the connected and possible next word choice, I used N-gram models(bigram, trigram,
                                   fourgram and fivegram).These N-gram word combinations are based on existing logical neighboring relations,
                                   ,which projects Markov Chain model properties.</h5></li>
                              <br>
                              <h4>Katz's Back-off Model</h4>
                              <h5>Following the Markov property, I think katz's Back-Off (KBO) Model is an apt choice algorithm for 'next-word-prediction' project. 
                                  By Wiki: Katz's back-off is a progressive N-gram language model that estimates the conditional probability of a word 
                                  given its history in the N-gram. It accomplishes this estimation by backing-off to models with smaller histories under certain 
                                  conditions. By doing so, the model with the most reliable information about a given history is used to provide the better results.[3]</h5>
                            
                              <h4>Mathematical analysis(partial) of the katz's model</h4>
                              <h5>'In the context of Natural Language Processing (NLP), which  is a mathematical model is constructed for the purpose of assigning 
                                  a probability or in my model the higher frequency occurrences with N-Grams to either a series of words wi-n,wi-n+1,...wiwi-n,wi-n+1,...wi  
                                  which we can denote as P(wi-n,wi-n+1,...wi)P(wi-n,wi-n+1,...wi) or the probability (frequency) of the last word given the previous words
                                  as denoted by P(wi|wi-n,wi-n+1,...wi-1)P(wi|wi-n,wi-n+1,...wi-1). This later definition is what we'll be counting on in order to predict 
                                  the next word of a phrase'.Predicting Next Word Using Katz Back-Off-[7] </h5>
                            
                              <h4> Prediction processes with the Model</h4>
                              <ol>
                              <li><h5> Receiving input through the input text box. </h5>
                              <li><h5> After initial processing for basic text cleaning with 'tm' R-package,</h5></li>
                              <li><h5> We will go by sequential implementation of bigram, trigram models with every addition
                                       of newer input.</h5></li> 
                              <li><h5> If no matching found, we move to fourgram or fivegram model and display probable next word choices.</h5></li>
                              <li><h5> Not every input combination matching will produce five word choices.<h5></li>
                              <li><h5> Based on frequency number and strength next word prediction choices will always be varied.<h5></li>
                              </ol>
                              <h4> Live Corpus and Ethical dilemma </h4>
                              <h5> In Google search about 15% of all the queries are completely new everyday, represents all evolving puzzle for the pediction
                                   algorithm to figure out. In offering next-word choices frequently existing algorithms introduce vile
                                   autocomplete suggestions, which may disseminate harmful social thoughts and creating  an ethical uproar.
                                   These questions raises the needed value-efficiency of designing next-word-prediction algorithms.
                                    <a href = https://www.wired.com/story/google-autocomplete-vile-suggestions> [WIRED LINK] </a>
                                   .This is a very practical scenario corresponds to the projects contemporaneous need for better prediction algorithm.</h5>
                              
                              <h4> Conclusion </h4>    
                              <li><h5> Since the 'Sample Corpus' represents only the 10% of the selective data set, the predicted next-word-choices
                                   may not be truly representative of the whole corpus.</h5></li>
                              <li><h5> The generated N-grams may be biased towards the training data set sources in predictions.[Shiny App uploading limit]. </h5></li>
                              </left></font>"))), 
                                 
                                 tabPanel("Resources:", 
                                          tags$div(HTML("<font color=black>
                             <left>
                             <h4><b> Bibliograhical Resources:</b> </h4>
                             <h5> To comprehend the complexity of this project, we need some other relevant sources of information.
                                  Each of these source-link provides indepth detail about the project understanding.</h5>
                             <hr><ol>
                          
                             <li><h5><strong> Coursera NLP course: <a href= https://www.coursera.org/learn/natural-language-processing> https://www.coursera.org/learn/natural-language-processing</a></h4>
                             <li><h5><strong> Katz's Back-off Model: <a href = https://en.wikipedia.org/wiki/Katz%27s_back-off_model> https://en.wikipedia.org/wiki/Katz%27s_back-off_model</a><h5>
                             <li><h5><strong> Markov Model: <a href = https://en.wikipedia.org/wiki/Markov_model> https://en.wikipedia.org/wiki/Markov_model</a><h5>
                             <li><h5><strong> N-Grams with wikipedia: <a href=https://en.wikipedia.org/wiki/N-gram> https://en.wikipedia.org/wiki/N-gram </a>
                             <li><h5><strong> Package(tm) in R: <a href= https://cran.r-project.org/web/packages/tm/tm.pdf>  https://cran.r-project.org/web/packages/tm/tm.pdf </a>
                             <li><h5><strong> Predicting Next Word Using Katz Back-Off: <a href = https://rpubs.com/mszczepaniak/predictkbo3model> https://rpubs.com/mszczepaniak/predictkbo3model </a>
                             <li><h5><strong> Shiny Tutorial in R: <a href=http://shiny.rstudio.com/tutorial/> http://shiny.rstudio.com/tutorial </a>
                             <li><h5><strong> Shiny Package in R: <a href = https://cran.r-project.org/web/packages/shiny/shiny.pdf> https://cran.r-project.org/web/packages/shiny/shiny.pdf</a>
                             <li><h5><strong> Shiny Presentation format: <a href = http://rmarkdown.rstudio.com/slidy_presentation_format.html#overview> http://rmarkdown.rstudio.com/slidy_presentation_format.html#overview</a>
                             <li><h5><strong> Shiny Themes : <a href = https://rstudio.github.io/shinythemes> https://rstudio.github.io/shinythemes/</a>
                             <li><h5><strong> Source of bad-words data: <a href = https://github.com/LDNOOBW/List-of-Dirty-Naughty-Obscene-and-Otherwise-Bad-Words/blob/master/en> https://github.com/LDNOOBW/List-of-Dirty-Naughty-Obscene-and-Otherwise-Bad-Words/blob/master/en </a><h4>
                             <li><h5><strong> Text mining infrastructure at: <a href = https://www.jstatsoft.org/article/view/v025i05 > https://www.jstatsoft.org/article/view/v025i05 </a>
                             </ol></left></font>"  )))
                                 
                                 
                                 ) )
                   ) 
    )
)

# Define server logic
shinyServer(
    function(input, output, session)
    { # using 'reactive function' as input-word changes
        Word.Prediction <- reactive({
            Predict.Next.Word(input$InputText)
        })
        
        # making reactive version of output(HTML) using ShinyUI library
        output$words <- renderUI({
            Words.predictd <- Word.Prediction()
            
            # assigning 'predicted-output-text' values to 'WordAssigned' with
            # a 'global-environment' on user-space
            assign('AssignedWords', Words.predictd, envir= globalenv()) 
            
            # counting predicted word and matching character conditions
            k <- length(Words.predictd)       
            if( k >= 0 && nchar(Words.predictd) > 0 )
                
                #-------------------------------------- 
            {  # displaying words inside a button, on user-space
                buttons <- list()
                for(i in 1:k) 
                { buttons <- list(buttons, list(
                    actionButton(inputId = paste("word",i, sep = ""), label = Words.predictd[i])))
                #----------------------possible word cloud----------------------------
                # possible word cloud presentation
                # wordcloud_rep = repeatable(wordcloud)
                #  output$wordcloud = renderPlot(
                #    wordcloud_rep(
                #    predictWords[i]$string,
                #    colors = brewer.pal(8, 'Dark2'),
                #    scale=c(3, 0.5),
                #     max.words = 5
                #  ) ) 
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

# Run the application 
shinyApp(ui = ui, server = server)
