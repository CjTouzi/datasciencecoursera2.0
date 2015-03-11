lineCounter <- function(file){
    
    nlines <- 0L
    while (length(chunk <- readBin(file, "raw", 65536)) > 0) {
        nlines <- nlines + sum(chunk == as.raw(10L))
    }
    close(file)
    nlines
  
}

