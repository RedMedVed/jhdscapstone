library(tm)
library(dplyr)

#reading source files
unigram <- readRDS('data/1gram.Rda')
bigram <- readRDS('data/2gram.Rda')
trigram <- readRDS('data/3gram.Rda')
fourgram <- readRDS('data/4gram.Rda')
fivegram <- readRDS('data/5gram.Rda')
sixgram <- readRDS('data/6gram.Rda')

#defining the function
wordPredict <- function(userText) {
  
  #check user input, if it contains only numbers
  #if(grepl('[A-Za-z]', userText) == 0) stop('Input should contain at least one letter!')
  
  if(nchar(userText) > 0) {
    
    #transform text input as the corpus before
    userText <- tolower(userText)
    userText <- removePunctuation(userText)
    userText <- removeNumbers(userText)
    userText <- stripWhitespace(userText)
    
    #splitting input strings and turned them into vectors
    inputObject <- unlist(strsplit(userText, split =  " "))
    
    #getting the length of each input vector
    wordCount <- length(inputObject)
    
    
    #text analysis
    #first use bigram
    useBigram <- function(words)
    {
      bigram[bigram$string$one == words, ]$string$two
    }
    
    #then trigram
    useTrigram <- function(words)
    {
      trigram[trigram$string$one == words[1] &
                trigram$string$two == words[2], ]$string$three
    }
    
    #then fourgram
    useFourgram <- function(words)
    {
      fourgram[fourgram$string$one == words[1] &
                 fourgram$string$two == words[2] &
                 fourgram$string$three == words[3], ]$string$four
    }
    
    #now fivegram
    useFivegram <- function(words)
    {
      fivegram[fivegram$string$one == words[1] & 
                 fivegram$string$two == words[2] &
                 fivegram$string$three == words[3] &
                 fivegram$string$four == words[4], ]$string$five
    }
    
    #and sixgram
    useSixgram <- function(words)
    {
      sixgram[sixgram$string$one == words[1] & 
                sixgram$string$two == words[2] &
                sixgram$string$three == words[3] &
                sixgram$string$four == words[4] &
                sixgram$string$five == words[5], ]$string$six
    }
    
    
    #PREDICTION PART
    
    #using bigram functions if there is only a single word
    if(wordCount == 1) 
    {
      predictedWords <- useBigram(inputObject[1])
    }    
    
    #with two words can use trigrams
    else if (wordCount == 2)
    {
      word1 <- inputObject[1]
      word2 <- inputObject[2]
      predictedWords <- useTrigram(c(word1, word2))
      
      if(length(predictedWords) == 0)
      {
        # if trigram fails use bigram function
        predictedWords <- useBigram(word2)
      }
    }
    
    #fourgrams and so on
    else if (wordCount < 4)
    {
      word1 <- inputObject[wordCount-2]
      word2 <- inputObject[wordCount-1]
      word3 <- inputObject[wordCount]
      predictedWords <- useFourgram(c(word1, word2, word3)) 
      
      # if fourgram fails use trigram function
      if(length(predictedWords) == 0)
      {
        predictedWords <- useTrigram(c(word2, word3))
      }
      
      # if trigram fails use bigram function
      if(length(predictedWords) == 0)
      {
        predictedWords <- useBigram(word3)
      }
    } 
    
    #fivegrams
    else if (wordCount == 4)
    {
      word1 <- inputObject[wordCount-3]
      word2 <- inputObject[wordCount-2]
      word3 <- inputObject[wordCount-1]
      word4 <- inputObject[wordCount]
      predictedWords <- useFivegram(c(word1, word2, word3, word4))
      
      #if fivegram fails use fourgram function
      if(length(predictedWords) == 0)
      {
        predictedWords <- useFourgram(c(word2, word3, word4))
      }
      
      #then trigram function
      if(length(predictedWords) == 0)
      {
        predictedWords <- useTrigram(c(word3, word4))
      }  
      
      #then bigram
      if(length(predictedWords) == 0)
      {
        predictedWords <- useBigram(word4)
      }
    }
    
    #sixgrams
    else {
      word1 <- inputObject[wordCount-4]
      word2 <- inputObject[wordCount-3]
      word3 <- inputObject[wordCount-2]
      word4 <- inputObject[wordCount-1]
      word5 <- inputObject[wordCount]
      predictedWords <- useSixgram(c(word1, word2, word3, word4, word5))
      
      if(length(predictedWords) == 0) {
        predictedWords <- useFivegram(c(word2, word3, word4, word5))
      }
      
      if(length(predictedWords) == 0)
      {
        predictedWords <- useFourgram(c(word3, word4, word5))
      }
      
      if(length(predictedWords) == 0)
      {
        predictedWords <- useTrigram(c(word4, word5))
      }  
      
      if(length(predictedWords) == 0)
      {
        predictedWords <- useBigram(word5)
      }
    }
    
    #-------------------------------------------------------
    #returning all top n predictors
    k <- 5
    pw <- length(predictedWords)
    # setting the output frequency to five
    if(pw >= k)
    {
      predictedWords <- predictedWords[1:k]
    }
    as.character(predictedWords)
  } else { '' }
  
}

