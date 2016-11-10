
# plot6.R
# emissions from motor vehicle sources in Baltimore City and Los Angeles County.
# uses ggplot2 system.


library(dplyr)
library(ggplot2)

SCCPM25 <- readRDS("summarySCC_PM25.Rds")
SCCode <- readRDS("Source_Classification_Code.Rds")

names = list("24510" = "Baltimore", "06037" = "Los Angeles")
b_more_LA <- filter(SCCPM25, fips == "24510" |  fips == "06037")
SCCClass <- inner_join(b_more_LA, SCCode, by=c("SCC" = "SCC"))
sectors <- unique(SCCClass$EI.Sector)
motov_sectors <- sectors[grep("Vehicles$", sectors)]
motov_d1 <- filter(SCCClass, EI.Sector %in% motov_sectors)
motov_d2 <- mutate(motov_d1, fips=sapply(fips, function(index) { names[[index]] }))
group <- group_by(motov_d2, year, fips)
data <- summarise(group, total=sum(Emissions))

png("myplots/plot6.png")
g <- ggplot(data, aes(year, total))
g+geom_smooth(aes(color=fips))+labs(title="Motor Vehicle Emissions\nBaltimore City and Los Angeles County",x="Year", y="Total PM2.5 Emissions")
dev.off()



