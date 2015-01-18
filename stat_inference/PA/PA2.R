# Now in the second portion of the class, we're going to analyze the ToothGrowth data in the R datasets package. 
# Load the ToothGrowth data and perform some basic exploratory data analyses 
# Provide a basic summary of the data.
# Use confidence intervals and/or hypothesis tests to compare tooth growth by supp and dose. (Only use the techniques from class, even if there's other approaches worth considering)
# State your conclusions and the assumptions needed for your conclusions. 
# Some criteria that you will be evaluated on
# Did you  perform an exploratory data analysis of at least a single plot or table highlighting basic features of the data?
# Did the student perform some relevant confidence intervals and/or tests?
# Were the results of the tests and/or intervals interpreted in the context of the problem correctly? 
# Did the student describe the assumptions needed for their conclusions?


# part 1 ------------------------------------------------------------------

# Load the ToothGrowth data and perform some basic exploratory data analyses 

library(datasets)
data(ToothGrowth)
?ToothGrowth
str(ToothGrowth)

# factorising dose 
ToothGrowth$dose <- factor(ToothGrowth$dose)
summary(ToothGrowth)

with(ToothGrowth, table(dose,supp))

# NA data
sum(is.na(ToothGrowth))

# dose & Supp
par(mfrow=c(1,2))
boxplot(len ~ dose, data = ToothGrowth, main="Dose",xlab="mg", ylab="length(mm)")
boxplot(len ~ supp, data = ToothGrowth, main="Supp")


par(mfrow=c(1,1))
boxplot(len ~ dose*supp, data = ToothGrowth,ylab="length(mm)")



# t-test regarding supp
with(ToothGrowth, t.test(len~supp))

# t-test regarding dose
with(ToothGrowth, pairwise.t.test(len,dose, pool.sd=FALSE))


levels <- levels(ToothGrowth$dose);levels

# t-test regarding dose grouped by supp

re <- lapply(1:length(levels), function(i) 
    with(ToothGrowth,
         t.test(len[dose==levels[[i]]]~supp[dose==levels[[i]]])
         )
    )
lapply(1:3, function(i) re[[i]]$conf.int)





