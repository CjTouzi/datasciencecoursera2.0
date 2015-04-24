
## back_off_model
library(dplyr)
# load("./data/tdm.Freq.df.RData")
# input.setence <- "If it returns"
# back_off_model(input.setence,tdm.Freq.df)

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






