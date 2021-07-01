#once installed don't need to redo.
#install.packages('googledrive')  

library(googledrive)

#set working directory
setwd("e:/FWDP2020/INFISH/guild/drive")

#allow some options/authentication and access to google account.
drive_find(type='csv')

drive_download("allwt2.csv", overwrite = T)

a=read.csv('allwt2.csv', sep = ',', h=T, na.strings = c(NA))


spdog=subset(a, a$svspp==15&a$season=='FALL'&a$epu=='GB'&a$prey=='FISH')

plot(spdog$year, spdog$relmsw2, type='l', xlab='', ylab='% diet by mass', col='blue')

#easier to loop over all svspp, epu, season, prey
