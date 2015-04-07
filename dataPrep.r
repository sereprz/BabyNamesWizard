nm <- read.csv('namesDataset.csv', header = FALSE, stringsAsFactors = FALSE)
names(nm) <- c('Year','Name','Sex','Freq')
counts <- aggregate(nm$Freq, list(nm$Year, nm$Sex), sum)
names(counts) <- c('Year','Sex','Total')
nm$Prop <- nm$Freq/counts$Total[ match(paste(nm$Year, nm$Sex), paste(counts$Year, counts$Sex))]


# out <- split(nm[ nm$Year == 1880 & nm$Sex %in% c('F','M'), ], nm$Sex[nm$Year == 1880 & nm$Sex %in% c('F','M')])
# out <- lapply(out, function(x) { x[ order(-x$Freq),]})
# top20 <- do.call('rbind', lapply(out, function(x) { x[ 1:20, ]}))
# top20$x <- sample(1:1000, nrow(top20), replace = TRUE)
# top20$y <- sample(1:1000, nrow(top20), replace = TRUE)
# top20$color <- ifelse(top20$Sex == 'F', 'pink', 'steelblue2')
# par(xaxt = 'n', yaxt = 'n', xlab = '', ylab='')
# with(top20, textplot(x, y, Name, log(Freq/mean(Freq)), show.lines = FALSE, xlab = '', ylab = '', xlim = c(-100, 1100), ylim = c(-100, 1100), col = color))
