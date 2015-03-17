
# init --------------------------------------------------------------------

libs <-c("tm", "dplyr","NLP","openNLP","RWeka","SnowballC")
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

# The testText has two sentences is divided by comma 
# demonstrate the unwanted tokens using test corpus: sentence and phrase junction


#  the unwanted term "text High-quality information" caused by sentence junction
# "mining also referred",  "text analytics refers" and so on

# to remove unwanted tokens by sentence junction, we using sentence detector provided by openNLP

convert_text_to_sentences <- function(text, lang = "en") {
    
    # Function to compute sentence annotations using the Apache OpenNLP Maxent sentence detector employing the default model for language 'en'. 
    sentence_token_annotator <- Maxent_Sent_Token_Annotator(language = lang)
    
    # Convert text to class String from package NLP
    text <- as.String(text)
    
    # Sentence boundaries in text
    sentence.boundaries <- annotate(text, sentence_token_annotator)
    
    # Extract sentences
    sentences <- text[sentence.boundaries]
    
    # return sentences
    return(sentences)
}

# then we further seperate the sentences by comma 

convert_text_to_sentences_fragment_text <- function(text,lang="en"){
    
    # docs<- readLines(file,nline, encoding="UTF-8")
    text <- {
        convert_text_to_sentences(text,lang) %>%
        strsplit("[,\n]") %>%        
        unlist()
    }

}



convert_text_to_Corpus <- function(text){
    
    corpus.tmp <- {
            text %>%
            unlist() %>%
            as.vector() %>%
            VectorSource() %>%
            Corpus() 
    }
    
}

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


# blog <- rm_nonasc("./data/en_US/en_US.blogs.txt")
# save("blog",file="./data/en_US/en_US.blogs2asc.Rdata")
# rm(blog)
# 
# news <- rm_nonasc("./data/en_US/en_US.news.txt")
# save("news",file="./data/en_US/en_US.news2asc.Rdata")
# rm(news)



# samplling due the computation and memory limit

load("./data/en_US/en_US.news2asc.Rdata")
load("./data/en_US//en_US.blogs2asc.Rdata")
myText <- c(blog, news)
rm(blog,news)

# divide into training set, dev set, and test set

# set.seed(111)
# train_size <- floor(0.75 * length(myText))
# train_ind_tmp<- sample(1:length(myText),size=train_size)
# myTest <- myText[-train_ind_tmp]
# myTrain <- myText[train_ind_tmp]
# 
# dev_size <- floor(0.3 * length(myTrain))
# dev_ind <- sample(1:length(myTrain), size=dev_size)
# myDev <- myTrain[dev_ind]
# myTrain <- myTrain[-dev_ind]
# 
# save(myDev,myTrain,myTest,file="myText.RData")
# rm(myDev,myTrain,myTest)

load("myText.RData")



# convert the text into sentences fragment 
sentence_fragment_text <- convert_text_to_sentences_fragment_text(myText,lang="en")



# clean Corpus

load("mytext.RData")
myCorpus <- convert_text_to_Corpus(mytext)
myCorpus <- {
    
    # convert to lowercase
     tm_map(myCorpus, content_transformer(tolower)) %>%
                tm_map(removePunctuation) %>%
                tm_map(removeNumbers) %>%
                tm_map(stripWhitespace) %>%
                tm_map(removeWords, stopwords("english")) 
    
}
save(myCorpus, file="myCorpus.RData")
# save(mytext,file="mytext.RData")
inspect(myCorpus)



# build TDM ---------------------------------------------------------------


getNgramTDM <- function(corpus, ngram){
    
    Tokenizer <- function(x) NGramTokenizer(x, Weka_control(min = ngram, max = ngram))
   
    tdm <-  TermDocumentMatrix(corpus,
                              control = list(tokenize = Tokenizer))
            
}
tdm1 <- getNgramTDM(myCorpus,1)

load("myCorpus.RData")
myCorpus[[98]]


# Exploratory analysis ----------------------------------------------------



# find Frequency Per Term
# http://stackoverflow.com/questions/14426925/frequency-per-term-r-tm-documenttermmatrix
num <- 10 # Show this many top frequent terms
tdm1[findFreqTerms(tdm1,100)[1:num],]%>%
    as.matrix() %>%
    rowSums()



# hold-out ----------------------------------------------------------------




# model -------------------------------------------------------------------


