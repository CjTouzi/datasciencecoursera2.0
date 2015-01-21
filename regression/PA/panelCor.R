# cite: http://gettinggeneticsdone.blogspot.sg/2011/07/scatterplot-matrices-in-r.html

# by Stephen Turner is an assistant professor of public health sciences and director of the Bioinformatics Core at the University of Virginia.

# The panel.cor() function below can compute the absolute correlation between pairs of 
# variables, and display these in the upper panels, 
# with the font size proportional to the absolute value of the correlation.

panel.cor <- function(x, y, digits=2, prefix="", cex.cor, ...)
{
        usr <- par("usr"); on.exit(par(usr))
        par(usr = c(0, 1, 0, 1))
        r <- abs(cor(x, y))
        txt <- format(c(r, 0.123456789), digits=digits)[1]
        txt <- paste(prefix, txt, sep="")
        if(missing(cex.cor)) cex.cor <- 0.8/strwidth(txt)
        text(0.5, 0.5, txt, cex = cex.cor * r)
}