
# plot1.R
# total emissions from PM2.5 across United States from 1999 to 200. 
# Using base plotting system.



library(dplyr)

SCCPM25 <- readRDS("summarySCC_PM25.Rds")

group <- group_by(SCCPM25, year)
data <- summarise(group, total=sum(Emissions))
yr_rng <- range(data$total)
minEM <- paste(sprintf("%.1f", yr_rng[1]/ 1000000), "M", sep = "")
maxEM <- paste(sprintf("%.1f", yr_rng[2]/ 1000000), "M", sep = "")
ylabels <- c(minEM, maxEM )

png("myplots/plot1.png")
plot(data, pch=19, xlab="Year", ylab="PM2.5 Emissions", xlim=c(1999, 2008), yaxt="n", main="PM2.5 Emissions in United States")
axis(2, at=yr_rng, labels=ylabels)
lines(data, lwd = 2, col="blue")
dev.off()




