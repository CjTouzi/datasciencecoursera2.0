
# init --------------------------------------------------------------------

libs <-c("tm", "dplyr","NLP","openNLP","RWeka","SnowballC","wordcloud")
lapply(libs, require, character.only=TRUE)
# set options
options(stringsAsFactors = FALSE)

# sometimes my system is in chinese.
Sys.setenv(LANG = "en_US.UTF-8")


# set parameters


# files <- paste0(foldPath,list.files(foldPath))
files <- list("data/en_US/en_US.blogs.txt","data/en_US/en_US.news.txt")
files

# clean text --------------------------------------------------------------

# data source selection
# we have three kind of data source: news, blog and twitter
# Intuitively, twitter text data may suffer more gramma errors and contain more emotions
# abbreviations. While news and blog might consider to be written by professionals 
# Therefore, to better complete our task of predicting the next word correctly
# our data source will only contain text from news and blog.


# remove non-ASCII characters
# link: http://stackoverflow.com/questions/18153504/removing-non-english-text-from-corpus-in-r-using-tm

rm_nonasc <- function(file){
    
    text <- readLines(file)
    # find indices of words with non-ASCII characters
    nonascIndex <- grep("text.tmp", iconv(text, "latin1", "ASCII", sub="text.tmp"))
    # subset original vector of words to exclude words with non-ASCII char
    text <- text[-nonascIndex]    
    
} 


# blog <- rm_nonasc("./Coursera-SwiftKey/final//en_US//en_US.blogs.txt")
# save("blog",file="./Coursera-SwiftKey/final/en_US/en_US.blogs2asc.Rdata")
# rm(blog)
# 
# news <- rm_nonasc("./Coursera-SwiftKey/final//en_US//en_US.news.txt")
# save("news",file="./Coursera-SwiftKey/final//en_US//en_US.news2asc.Rdata")
# rm(news)


## combine into one single dataset myText
# load("./Coursera-SwiftKey/final//en_US/en_US.news2asc.Rdata")
# load("./Coursera-SwiftKey/final//en_US/en_US.blogs2asc.Rdata")
# myText <- c(blog, news)
# save("myText",file="./Coursera-SwiftKey/final//en_US//myText.Rdata")
# rm(blog,news)

##  samplling due the computation and memory limit 

# load("./Coursera-SwiftKey//final//en_US//myText.Rdata")
# 
# 
# myText.sample.ind <- sample(1:length(myText), 
#                             size=floor(0.1*length(myText)))
# myText.sample <- myText[myText.sample.ind]
# head(myText.sample)
# rm(myText)





# to remove unwanted tokens by sentence junction, we using sentence detector provided by openNLP

# convert_text_to_sentences <- function(text, lang = "en") {
#     
#     # Function to compute sentence annotations using the Apache OpenNLP Maxent sentence detector employing the default model for language 'en'. 
#     sentence_token_annotator <- Maxent_Sent_Token_Annotator(language = lang)
#     
#     # Convert text to class String from package NLP
#     text <- as.String(text)
#     
#     # Sentence boundaries in text
#     sentence.boundaries <- annotate(text, sentence_token_annotator)
#     
#     # Extract sentences
#     sentences <- text[sentence.boundaries]
#     
#     # return sentences
#     return(sentences)
# }
# 
# # then we further seperate the sentences by comma 
# 
# convert_text_to_sentences_fragment_text <- function(text,lang="en"){
#     
#     # docs<- readLines(file,nline, encoding="UTF-8")
#     text <- {
#         convert_text_to_sentences(text,lang) %>%
#             strsplit("[,\n]") %>%        
#             unlist()
#     }
#     
# }
# 
# myText.Sentences <- convert_text_to_sentences_fragment_text(myText.sample,lang="en")
# head(myText.Sentences)
# remove(myText.sample)
# save("myText.Sentences",file="./Coursera-SwiftKey/final//en_US//myText.Sentences.Rdata")


## remove the sentences frame with length less than 4
# load("./Coursera-SwiftKey/final//en_US//myText.Sentences.Rdata")
# 
# 
# 
# rmShortSentences<- function (text.list,len){
#     
#     ind.remove=0
#     for (i in 1: length(text.list)){
#         
#         textlen<- length(unlist(strsplit(text.list[[i]]," ")))
#         print(textlen)
#         if (textlen<len){
#          
#             ind.remove=c(ind.remove,i)
# 
#         }
#         
#         
#     }
#     print(ind.remove[-1])
#     text.list[-ind.remove[-1]]
#     
#     
# }
# 
# 
# 
# 
# myText.Sentences.Long <-rmShortSentences(myText.Sentences,5)
# head(myText.Sentences.Long)
# rm(myText.Sentences)
# 
# 
# convert_text_to_Corpus <- function(text){
#     
#     corpus.tmp <- {
#             text %>%
#             unlist() %>%
#             as.vector() %>%
#             VectorSource() %>%
#             Corpus() 
#     }
#     
# }
# 
# mySentence.Long.Corpus <- convert_text_to_Corpus(myText.Sentences.Long)

save(mySentence.Long.Corpus,file="mySentence.Long.Corpus.RData")
load("mySentence.Long.Corpus.RData")


# clean Corpus

# mySentence.Long.Corpus <- {
#     
#     # convert to lowercase
#      tm_map(mySentence.Long.Corpus, content_transformer(tolower)) %>%
#                 tm_map(removePunctuation) %>%
#                 tm_map(removeNumbers) %>%
#                 tm_map(stripWhitespace) %>%
#                 tm_map(removeWords, stopwords("english")) 
#     
# }
# 
# save(mySentence.Long.Corpus, file="mySentence.Long.Corpus.RData")
# 
# 
# inspect(mySentence.Long.Corpus)




##  divide into training set, dev set, and test set

set.seed(111)
train_size <- floor(0.75 * length(mySentence.Long.Corpus))
train_ind_tmp<- sample(1:length(mySentence.Long.Corpus),size=train_size)
myTest <- mySentence.Long.Corpus[-train_ind_tmp]
myTrain <- mySentence.Long.Corpus[train_ind_tmp]

dev_size <- floor(0.3 * length(myTrain))
dev_ind <- sample(1:length(myTrain), size=dev_size)
myDev <- myTrain[dev_ind]
myTrain <- myTrain[-dev_ind]

save(myTrain,file="myTrain.RData")
save(myDev,file="myDev.RData")
save(myTest,file="myTest.RData")




# build TDM ---------------------------------------------------------------


load("myTrain.RData")

getNgramTDM <- function(corpus, ngram){
    
    Tokenizer <- function(x) NGramTokenizer(x, Weka_control(min = ngram, max = ngram))
   
    tdm <-  TermDocumentMatrix(corpus,
                              control = list(tokenize = Tokenizer))
            
}


tdm4 <- getNgramTDM(myTrain,4)
save(tdm4,file="tdm4.RData")


# Exploratory analysis ----------------------------------------------------

# find Frequency Per Term
# http://stackoverflow.com/questions/14426925/frequency-per-term-r-tm-documenttermmatrix
rm(myTrain)



# remove none frequent terms
# Show this many top frequent terms


## 1gram
length(findFreqTerms(tdm1,200))

tdm1.topFreq<- tdm1[findFreqTerms(tdm1,200),]%>%
    as.matrix() %>%
    rowSums() 

head(tdm1.topFreq)
tdm1.topFreq <- sort(tdm1.topFreq, decreasing=TRUE)

## 2gram
length(findFreqTerms(tdm2,20))

tdm2.topFreq<- tdm2[findFreqTerms(tdm2,20),]%>%
    as.matrix() %>%
    rowSums() 
tdm2.topFreq <- sort(tdm2.topFreq, decreasing=TRUE)
head(tdm2.topFreq)

## 3gram
length(findFreqTerms(tdm3,3))

tdm3.topFreq<- tdm3[findFreqTerms(tdm3,3),]%>%
    as.matrix() %>%
    rowSums() 
tdm3.topFreq <- sort(tdm3.topFreq, decreasing=TRUE)
head(tdm3.topFreq)

## 4gram
length(findFreqTerms(tdm4,2))

tdm4.topFreq<- tdm4[findFreqTerms(tdm4,4),]%>%
    as.matrix() %>%
    rowSums() 
tdm4.topFreq <- sort(tdm4.topFreq, decreasing=TRUE)
head(tdm4.topFreq)

rm(tdm1,tdm2,tdm3,tdm4)


save(tdm1.topFreq,tdm2.topFreq,tdm3.topFreq,tdm4.topFreq,file="tdmTopFreq.RData")


hist(tdm2.topFreq)

# word cloud


set.seed(111)
wordcloud(names(tdm1.topFreq), tdm1.topFreq, max.words=50, scale=c(5, .1), colors=brewer.pal(6, "Dark2"))
wordcloud(names(tdm2.topFreq), tdm2.topFreq, max.words=50, scale=c(5, .1), colors=brewer.pal(6, "Dark2"))
wordcloud(names(tdm3.topFreq), tdm3.topFreq, max.words=50, scale=c(5, .1), colors=brewer.pal(6, "Dark2"))


# model -------------------------------------------------------------------


