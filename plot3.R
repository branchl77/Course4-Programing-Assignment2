
# plot3.R
# (point, nonpoint, onroad, nonroad) emissions from 1999–2008 for Baltimore City.
# Use the ggplot2 plotting system


library(dplyr)
library(ggplot2)

SCCPM25 <- readRDS("summarySCC_PM25.Rds")

b_more <- filter(SCCPM25, fips == "24510")
group <- group_by(b_more, year, type)
data <- summarise(group, total=sum(Emissions))

png("myplots/plot3.png")
qplot(year, total, data=data, color=type, geom=c("point", "smooth"), main="PM2.5 Emissions in Baltimore City")
dev.off()
