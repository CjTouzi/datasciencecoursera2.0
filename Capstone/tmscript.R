
# init --------------------------------------------------------------------

libs <-c("tm", "dplyr","NLP","openNLP")
lapply(libs, require, character.only=TRUE)
# set options
options(stringsAsFactors = FALSE)

# sometimes my system is in chinese.
Sys.setenv(LANG = "en_US.UTF-8")


# set parameters

dir <- "./data/en_US/"


# clean text --------------------------------------------------------------


con <- readLines("./data/en_US/en_US.blogs.txt",50, encoding="UTF-8")
con <- strsplit(con, "[,;!?|\n\\.]^[0-9]")

head(con)

# tokenization: 
# the purpose of this project is to predict the following world given a sequence of words.
# These words are surposed to form a a sentences
# Therefore, we use the period and comma as my 


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

corpus <- convert_text_to_sentences(con, lang="en")
head(corpus)

tokenCorpus <- function(file){
    
    con <- readLines(file,50)
    corpus.tmp <- strsplit(con, " ")
    
}




# clean text

cleanCorpus <- function(corpus){
    
    corpus.tmp <- {
        corpus %>%
            tm_map(removePunctuation) %>%
            tm_map(stripWhitespace) %>%
            tm_map(tolower) %>%
            tmp(removeWords, stopwords("english"))
    }
 
}


# build TDM





# build TDM ---------------------------------------------------------------


# attach name -------------------------------------------------------------


# stack -------------------------------------------------------------------


# hold-out ----------------------------------------------------------------


# model -------------------------------------------------------------------


