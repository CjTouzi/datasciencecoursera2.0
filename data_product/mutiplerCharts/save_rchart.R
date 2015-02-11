library(rCharts)
library(base64enc)
a <- hPlot(Pulse ~ Height, data = MASS::survey, type = "bubble", title = "Zoom demo", subtitle = "bubble chart", size = "Age", group = "Exer")
a$chart(zoomType = "xy")
a$chart(backgroundColor = NULL)
a$set(dom = 'chart3')
a
a$save('mychart2.html', standalone = TRUE)
