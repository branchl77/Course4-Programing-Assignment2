
#plot2.R  Total Emissions in Baltimore City, Maryland from 1999 to 2008 Uses base plotting.

library(dplyr)

SCCPM25 <- readRDS("summarySCC_PM25.Rds")

b_more <- filter(SCCPM25, fips == "24510")
group <- group_by(b_more, year)
data <- summarise(group, total=sum(Emissions))
yr_rng <- range(data$total)
minEM <- paste(sprintf("%.1f", yr_rng[1]/ 1000), "K", sep = "")
maxEM <- paste(sprintf("%.1f", yr_rng[2]/ 1000), "K", sep = "")
ylabels <- c(minEM, maxEM )

png("myplots/plot2.png")
plot(data, pch=19, xlab="Year", ylab="PM2.5 Emission", xlim=c(1999, 2008), yaxt="n", main="PM2.5 Emissions in Baltimore City")
axis(2, at=yr_rng, labels=ylabels)
lines(data, lwd = 2, col="blue")
dev.off()