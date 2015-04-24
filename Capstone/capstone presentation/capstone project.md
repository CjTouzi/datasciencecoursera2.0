Coursera Data Science Capstone Project: A Simple Predictive Language Model 
========================================================
author: Cheng Juan, PhD
date: 20-04-2015
font-family: 'Helvetica'

Objectives
========================================================
    
 1. **A predictive language model**
 2. **Showcase the model with a Shiny App**

 
Modeling Process  
========================================================

1. [Data Cleaning](http://rpubs.com/Cjtouzi/capstoneReport)
    - data source:[link](http://www.corpora.heliohost.org/aboutcorpus.html) 
    - Non-ASCII Characters, punctuation, numbers, additional white escarce and stopping words are removed
2. Term Document Matrix using [N-gram Modeling](http://en.wikipedia.org/wiki/N-gram)
3. [Back-off Prediction](http://en.wikipedia.org/wiki/Katz%27s_back-off_model)   
4. shiny app 

Detail of prediction process  
========================================================

- The prediction process first **starts with trigram** and the most frequent word is selected. 
- If **no result occurs** for trigram model, the prediction model backs off to the bigram model and so on.
- Sometimes, there are **multiple words with equal frequency**. For example, 10 results are found using trigram model. Then the prediction process select the most frequent within these 10 results in bigram model. 



Shiny App Instructions
========================================================

1. **Access shiny app**
2. **Key in your desired phrase into the text box.**
3. **The app predict the next word and display it.**

