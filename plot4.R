
# plot4.R
# coal combustion-related emissions across the United States from 1999–2008
# uses ggplot2 system.


library(dplyr)
library(ggplot2)

SCCPM25 <- readRDS("summarySCC_PM25.Rds")
SCCode <- readRDS("Source_Classification_Code.Rds")

SCCClass <- inner_join(SCCPM25, SCCode, by=c("SCC" = "SCC"))
sectors <- unique(SCCClass$EI.Sector)
coal_sectors <- sectors[grep("Coal$", sectors)]
coal_data <- filter(SCCClass, EI.Sector %in% coal_sectors)
group <- group_by(coal_data, year, EI.Sector)
data <- summarise(group, total=sum(Emissions))

png("myplots/plot4.png")
g <- ggplot(data, aes(year, total))
g+geom_smooth(aes(color=EI.Sector))+labs(title="Coal Related PM2.5 Emissions")
dev.off()