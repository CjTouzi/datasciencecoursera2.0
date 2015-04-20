
# init --------------------------------------------------------------------

libs <-c("tm", "dplyr","NLP","openNLP","RWeka","SnowballC","wordcloud","ggplot2", "slam")
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

load("tdm1.RData")
load("tdm2.RData")
load("tdm3.RData")

# remove none frequent terms
# Show this many top frequent terms


## 1gram

length(findFreqTerms(tdm1,200))

tdm1.topFreq<- tdm1[findFreqTerms(tdm1,200)]%>%
    as.matrix() %>%
    rowSums() 
tdm1.topFreq <- sort(tdm1.topFreq, decreasing=TRUE)

x <- barplot(table(mtcars$cyl), xaxt="n")
labs <- paste(names(table(mtcars$cyl)), "cylinders")
text(cex=1, x=x-.25, y=-1.25, labs, xpd=TRUE, srt=45, pos=2)


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




## train N-gram models---------------------------------------
## term-document matrix combined unigram, bigram, trigram

load("myTrain.RData")
Tokenizer <- function(x) NGramTokenizer(x, Weka_control(min = 1, max = 3))
tdm <-  TermDocumentMatrix(myTrain,
                           control = list(tokenize = Tokenizer))



save(tdm,file="tdm.RData")

## convert term document matrix into condictional probability
load("tdm.RData")


# unigram probword1)= count(word1)/total number of word
# bigram prob(word2|word1)= count(word1 word2)/count(word1)
# trigram prob(word3|word1 word2)= count(word1 word2 word3)/count(word1 word2)


convertTDM_to_Freq_DF <- function(tdm1){
    require(slam)
    tdm1.Freq <- rollup(tdm1, 2, na.rm=TRUE, FUN = sum)
    tdm1.Freq.mat<- as.matrix(tdm1.Freq[findFreqTerms(tdm1.Freq,1),])
    term <- row.names(tdm1.Freq.mat)
    tdm1.Freq.df <- data.frame(term=term, freq= tdm1.Freq.mat[1:nrow(tdm1.Freq.mat)])
    
    
}

tdm.Freq.df <- convertTDM_to_Freq_DF(tdm)

get_first_n1_word(head(tdm.Freq.df$term)[[3]])
term <- strsplit(tdm.Freq.df$term," ")

term.length <- unlist(lapply(term, function(i) length(term[i])))
tdm.Freq.df <- cbind(tdm.Freq.df, term.length)
rm(term)


unigram.log.cond.prob <- log(tdm.Freq.df[tdm.Freq.df$term.length==1,]$freq)-log(sum(tdm.Freq.df[tdm.Freq.df$term.length==1,]$freq,na.rm=TRUE))
head(unigram.log.cond.prob)
    

#root words are the words first n-1 words in a n word term

get_root_word <- function(str, sep=" "){
    
    strl <- unlist(strsplit(str,sep))
    paste(strl[1:length(strl)-1], collapse = sep)
    
    
}

root.words <- apply(as.data.frame(tdm.Freq.df$term), 1, function(x) get_root_word(x))
tdm.Freq.df$root.words <- root.words



# count the root words frequence 
root.words.freq <- data.frame(root.words.freq=rep(0,nrow(tdm.Freq.df)))

# case 2

for (leaf.index in 1:nrow(tdm.Freq.df)){

    if (tdm.Freq.df$term.length[[leaf.index]]==2){
        root.freq=tdm.Freq.df$freq[[leaf.index]]
        next  
    }
    if (tdm.Freq.df$term.length[[leaf.index]]==3){
        root.words.freq$root.words.freq[[leaf.index]] <- root.freq
    }
  
    
}

save(root.words.freq,file="rootwordsfreq.RData")

# case 1

for (leaf.index in 1:nrow(tdm.Freq.df)){
    
    if (tdm.Freq.df$term.length[[leaf.index]]==1){
        root.freq=tdm.Freq.df$freq[[leaf.index]]
        next  
    }
    if (tdm.Freq.df$term.length[[leaf.index]]==2){
        root.words.freq$root.words.freq[[leaf.index]] <- root.freq
    }
    
    
}


tdm.Freq.df$root.words.freq <- root.words.freq$root.words.freq

save(tdm.Freq.df,file="tdm.Freq.df.RData")

# simple stupid backoff model

# 1. measure the length of the input setence
# 2. 1) length>=2:trigram backoff;2) length=1 bigram  



## back_off_model
library(dplyr)
load("tdm.Freq.df.RData")
input.setence <- "If it returns"
back_off_model(input.setence,tdm.Freq.df)

back_off_model <- function(input.setence,tdm.Freq.df){
    
# trigram prediction
    # get the last two words
    root <- get_rootword(input.setence,2)
    re <- predict_next_word(root,tdm.Freq.df)
    re
    if (nrow(re)==0){
        # bigram
        root <- get_rootword(input.setence,1)
        re <- predict_next_word(root,tdm.Freq.df)
        
        if(nrow(re)==0){
            # unigram
            re <- {
                tdm.Freq.df %>% 
                    filter(term.length==1) %>%
                    filter(freq==max(freq))
            }
            return(get_rootword(re$term,1))

        }
        
        # bigram finished
        if (nrow(re)==1){
            return(get_rootword(re$term,1))
        }
        
        if (nrow(re)>1){
            # use the most frequent
            
            pred.phrase <-unlist(lapply(re$term, get_rootword, lastn=1))
            temp <- tdm.Freq.df[tdm.Freq.df$term %in% pred.phrase,]
            re <- temp[which.max(temp$freq),]
            return(get_rootword(re$term,1))
        }
        
    }
    
    if (nrow(re)==1){
        return(get_rootword(re$term,1))
    }
    
    # return multiple results, find the most frequent term
    if (nrow(re)>1){
        
        pred.phrase <-unlist(lapply(re$term, get_rootword, lastn=2))
        temp <- tdm.Freq.df[tdm.Freq.df$term %in% pred.phrase,]
        re <- temp[which.max(temp$freq),]
        
        return(get_rootword(re$term,1))
    }

}

predict_next_word <- function(root, tdm.Freq){
    
    re <- {
        tdm.Freq%>%
            filter(root.words==root) %>% 
            filter(freq==max(freq))
        
    }
    re
  
}

# get_freq_term <- function(my_term, tdm.Freq){
#     
#     re <- {
#         tdm.Freq%>%
#             filter(term==my_term) %>% 
#             filter(freq==max(freq))
#         
#     }
#     re
#     
#     
# }


get_rootword <- function(input.setence, lastn){
    
    words <- unlist(strsplit(input.setence, split=" "))
    n.word <- length(words)
    
    if(n.word<=lastn){
        return(input.setence)
        
    }
   
    paste(words[(n.word-lastn+1):n.word],collapse =" ")
    
}






