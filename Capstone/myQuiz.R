source("NLPfuncs.R")




# Quiz 1: bash is important. grep & wc ------------------------------------



# Q1 ----------------------------------------------------------------------

# The en_US.blogs.txt file is how many megabytes?
# Your Answer        Score	Explanation
# 100			
# 150			
# 200	Correct	1.00	
# 250			
# Total		1.00 / 1.00	
# Question Explanation
# 

# Ans:
# Do ls -alh in the Coursera-Swiftkey/final/en_US directory.


# count lines of en_US.twitter.txt 
f <- file("./Coursera-SwiftKey/final//en_US//en_US.twitter.txt", open="rb")
lineCounter(f)

chunk <- readBin(f, "raw", 65536)
length(chunk)

# Question 2-----------------------------------
# The en_US.twitter.txt has how many lines of text?
# Your Answer    	Score	Explanation
# Around 1 million			
# Over 2 million	Correct	1.00	
# Around 2 hundred thousand			
# Around 5 hundred thousand			
# Total		1.00 / 1.00	
# Question Explanation


# Ans: 
# Do wc -l en_US.twitter.txt at the prompt (or git bash on windows) or length(readLines("en_US.twitter.txt")) in R

# Do wc -l en_US.twitter.txt at the prompt (or git bash on windows) or length(readLines("en_US.twitter.txt")) in R


# Q3--------------------
# Question 3
# What is the length of the longest line seen in any of the three en_US data sets?
# Over 11 thousand in the news data set
# Over 11 thousand in the blogs data set
# Over 40 thousand in the blogs data set ***
# Over 40 thousand in the news data set


# Anws:
# Question Explanation

Again a simple wc command suffices wc -L *.txt inthe directory with the three files. Note, we had a small discrepancy between doing thin in R versus WC.wc -L *.txt

dir <-"./Coursera-SwiftKey/final//en_US//"
filelist <- list.files(dir)
filelist

for (f in filelist){
    fname <- paste0(dir, f)
    print(fname)
    con <- readLines(fname)  
    print(max(nchar(con)))
    rm(con) 
}


# Q4 ----------------------------------------------------------------------

# In the en_US twitter data set, if you divide the number of lines where the word "love" (all lowercase) occurs by the number of lines the word "hate" (all lowercase) occurs, about what do you get?
# 0.25
# 2
# 0.5
# 4

# Question Explanation
# 
# grep "love" en_US.twitter | wc -l and grep "hate" en_US.twitter | wc -l 
# gives you the counts. Then you could divide in whatever. 
# If you never want to leave the console, 
# you can use bc (not present on gitbash in windows). 
# You could also read into R (readLines) and use character search. 
# This worked on gitbash love=$(grep "love" en_US.twitter.txt | wc -l) 
# then hate=$(grep "hate" en_US.twitter.txt | wc -l) 
# then let m=love/hate then echo $m


twit <- readLines("./Coursera-SwiftKey/final//en_US//en_US.twitter.txt")
twit_love_Index <- grepl(".*love.*", twit)
length(twit_love_Index)
sum(twit_love_Index)
# [1] 90956
twit_hate_Index <- grepl(".*hate.*", twit)
sum(twit_hate_Index)
# [1] 22138
sum(twit_love_Index)/sum(twit_hate_Index)
# [1] 4.108592
rm(twit)



# Q5 ----------------------------------------------------------------------

# The one tweet in the en_US twitter data set that matches the word "biostats" says what?
# It's a tweet about Jeff Leek from one of his students in class
# They need biostats help on their project
# They haven't studied for their biostats exam
# They just enrolled in a biostat program

# Question Explanation
# 
# grep -i "biostat" en_US.twitter.txt (note the -i doesn't matter since there's only one line ignoring case).


twit <- readLines("./Coursera-SwiftKey/final//en_US//en_US.twitter.txt")

twit[[grep(".*biostats.*", twit)]]
rm(twit)
# [1] "i know how you feel.. i have biostats on tuesday and i have yet to study =/"



# Q6 ----------------------------------------------------------------------

# How many tweets have the exact characters "A computer once beat me at chess, but it was no match for me at kickboxing". (I.e. the line matches those characters exactly.)
# 1
# 2
# 0
# 3

# Question Explanation
# 
# grep -x "A computer once beat me at chess, but it was no match for me at kickboxing" en_US.twitter.txt | wc -l

twit <- readLines("./Coursera-SwiftKey/final//en_US//en_US.twitter.txt")
grep("A computer once beat me at chess, but it was no match for me at kickboxing", twit)





