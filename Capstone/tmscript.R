
# init --------------------------------------------------------------------

libs <-c("tm", "dplyr","NLP","openNLP","RWeka","SnowballC")
lapply(libs, require, character.only=TRUE)
# set options
options(stringsAsFactors = FALSE)

# sometimes my system is in chinese.
Sys.setenv(LANG = "en_US.UTF-8")


# set parameters

foldPath<- "./Coursera-SwiftKey/final//en_US/"
files <- paste0(foldPath,list.files(foldPath))
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

convert_text_to_sentences_fragment_corpus <- function(text,lang="en"){
    
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


# sampling process 
# Given the large amount of text and limited computational resources, sampling is performed. 
# 10000 sentences fragments are randomly sampled, combined to corpus and finally saved to disk.


# sn <- 10000
# mytext <- ""
# for (f in files){
#     print(f)
#     text.tmp <- readLines(f,sn) 
#     text.tmp <- convert_text_to_sentences_fragment_corpus(text.tmp,"en")
# remove non-ASCII characters
# link: http://stackoverflow.com/questions/18153504/removing-non-english-text-from-corpus-in-r-using-tm


#     text.tmp <- text.tmp[sample(1:length(text.tmp),sn)]
#     mytext <- c(text.tmp,mytext)
#     print(mytext)
# }

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


