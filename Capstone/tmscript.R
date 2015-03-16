
# init --------------------------------------------------------------------

libs <-c("tm", "dplyr","NLP","openNLP","RWeka")
lapply(libs, require, character.only=TRUE)
# set options
options(stringsAsFactors = FALSE)

# sometimes my system is in chinese.
Sys.setenv(LANG = "en_US.UTF-8")


# set parameters

dir <- "./data/en_US/"


# clean text --------------------------------------------------------------

TestText <- "Text mining, 
also referred to as text data mining, 
roughly equivalent to text analytics, 
refers to the process of deriving high-quality information from text. 
High-quality information is typically derived through the devising of patterns 
and trends through means such as statistical pattern learning."

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


convert2Corpus <- function(text){
    
    corpus.tmp <- {
            text %>%
            unlist() %>%
            as.vector() %>%
            VectorSource() %>%
            Corpus() 
    }
    
}



# build TDM ---------------------------------------------------------------



tdm <- TermDocumentMatrix(TestCorpus,
                          control = list(removePunctuation = TRUE,
                                         stopwords = TRUE, 
                                         stripWhitespace=TRUE,
                                         tolower=TRUE))
tdm[1:2,1:5]

TrigramTokenizer <- function(x) NGramTokenizer(x, Weka_control(min = 3, max = 3))


tdm <- TermDocumentMatrix(TestCorpus,
                          control = list(removePunctuation = TRUE,
                                         stopwords = TRUE, 
                                         stripWhitespace=TRUE,
                                         tolower=TRUE, 
                                         tokenize = TrigramTokenizer))
inspect(tdm[1:2,1:5])



con <- readLines("./Coursera-SwiftKey/final/en_US/en_US.blogs.txt",50, encoding="UTF-8")

head(con)


# hold-out ----------------------------------------------------------------




# model -------------------------------------------------------------------


