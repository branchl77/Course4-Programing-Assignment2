
# plot5.R
# emissions from motor vehicles from 1999–2008 in Baltimore City.
# Using ggplot2 system.



library(dplyr)
library(ggplot2)

SCCPM25 <- readRDS("summarySCC_PM25.Rds")
SCCode <- readRDS("Source_Classification_Code.Rds")

b_more <- filter(SCCPM25, fips == "24510")
SCCClass <- inner_join(b_more, SCCode, by=c("SCC" = "SCC"))
sectors <- unique(SCCClass$EI.Sector)
motov_sectors <- sectors[grep("Vehicles$", sectors)]
motov_data <- filter(SCCClass, EI.Sector %in% motov_sectors)
group <- group_by(motov_data, year, EI.Sector)
data <- summarise(group, total=sum(Emissions))

png("myplots/plot5.png")
g <- ggplot(data, aes(year, total))
g+geom_smooth(aes(color=EI.Sector))+labs(title="Motor Vehicle Emissions in Baltimore City")+labs(x="Year", y="Total PM2.5 Emissions")
dev.off()




