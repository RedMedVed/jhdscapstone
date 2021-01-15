library(shiny)
library(shinythemes)

shinyUI(fluidPage( tags$style(type="text/css",
                              ".shiny-output-error { visibility: hidden; }",
                              ".shiny-output-error:before { visibility: hidden; }"
                              ),
                   navbarPage(theme = shinytheme("spacelab"), strong("Capstone Project")),
                   sidebarPanel(h4(HTML("<font color=black><strong>Project Synopsis:</strong></font>")),
                                h4(HTML("<font color=black><b>This application predicts next word 
                                        according to N-gram probability.</b></font>")), 
                                h4(HTML("<font color=black><b>Just type your word or sentence and 
                                the prediction will appear. Next you can add words by clicking or
                                        more typing if there are no suitable options.")),
                                h4(HTML("<font color=black><b>If the output is empty, the input word 
                                        is not in the model (or the input contains no words at all)."))
                   ),
                   mainPanel(
                       wellPanel(tabsetPanel(tabPanel("Application",(h4("Input your choice words:")),
                                                      textInput("InputText", label = NULL, width = "75%"),
                                                      h6("Type or choose words from the prediction"),
                                                      h4("The predicted words:"),
                                                      uiOutput("words"),
                                                      ),
                                 
                                 tabPanel("Project Objective sequence",
                                          tags$div(HTML("<font color=black>
                             <left><h4><b>Project Objective sequence</b></h4>
                              <h5>The main goal of this capstone project is to build an app, which will 
                              predict some possible word choices.
                              This project consisted of data cleaning, EDA, finding N-grams 
                              sequences and creating a predictive model.</h5>
                              <h4><b>Applied Data processing Methods</b></h4>
                              <h5>After a sample corpus was created, it was cleaned by 
                              conversion to lowercase, removing punctuation, links, 
                              whitespaces, numbers and all kinds of special characters (non-UTF-8).
                              
                              <h5> The data set is reduced to 3000 items (according to my PC abilities) 
                              of the total and combined into a single file for faster processing.<h5>
                              
                              <left>
                              <h4><b>N-Gram determination steps:</b></h4>
                              <ol>
                              <li>Tokenizing the sample corpus.</li>
                              <li>Converting the tokens to a matrix.</li>
                              <li>Counting tokens' frequency.</li>
                              <li>Transforming the matrix into dataframe with column names 
                              as strings and upward frequency order.</li>
                              <li>Serialization for the sake of increasing speed</li>
                              </ol>

                                                        </font>"
                                          ))),
                                 tabPanel("Model Algorithm",
                                          tags$div(HTML("<font color=black>
                              <left><h5>When some text inputed:</h5>
                              <ol>
                              <li><h5>Basic text cleaning (removing numbers, punctuation etc.)</h5></li>
                              <li><h5>Sequential implementation of bigram, trigram, fourgram, fivegram
                              model, then sixgram (the longest option) and displaying probable next word 
                              choices.</h5></li>
                              <li><h5>Step 2 continues after every input changes.</h5></li>
                              </ol>")))
                                 ) )
                   ) 
)
) # shinyUI closing