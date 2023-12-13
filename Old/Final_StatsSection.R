library(tidyverse);library(lubridate);library(viridis);library(here);library(rvest);
library(dataRetrieval);library(dplyr); library(readr);library(stringr);library(sf); 
library(mapview); mapviewOptions(fgb = FALSE);library(RColorBrewer)

here()
trailcam_csv <- read.csv(here("sequences.csv"))

#date as objects
trailcam_csv$start_time <- ymd_hms(trailcam_csv$start_time)
trailcam_csv$end_time <- ymd_hms(trailcam_csv$end_time)

#separate date and time
trailcam_csv$start_date <- as.Date(trailcam_csv$start_time)
trailcam_csv$start_time <- format(trailcam_csv$start_time, "%H:%M:%S")

trailcam_csv$end_date <- as.Date(trailcam_csv$end_time)  
trailcam_csv$end_time <- format(trailcam_csv$end_time, "%H:%M:%S") 

#filter for white- tailed deer, select relevant columns, and isolate trail camera id number.
deer_data <- trailcam_csv %>%
  filter(common_name == "White-tailed Deer") %>%
  select(common_name, deployment_id, start_date, start_time, end_date, end_time, group_size) %>%
  mutate(cam_id = as.numeric(str_extract(deployment_id, "\\d+")))
#cam_id refers to the camera id number

#read file with trail camera coordinates
cam_coordinates <- read.csv(here("forest_coordinates.csv"))

#Select id number and coordinates, and rename "No." column to match "cam_id". 
cam_coordinates <- cam_coordinates %>%
  select(No., Longitude, Latitude) %>%
  rename(cam_id = No.)
  #NEED TO FIGURE OUT COORDINATES FOR TRAIL CAMS 
  
  #join deer data with trail camera coordinate data to find where 
  deer_cam_data <- left_join(deer_data, cam_coordinates, by = "cam_id")

#read Duke forest boundary shapefile into project
here("Duke University/Documents/EDE_Fall2023/DukeForest-TackRiosMoyer/duke-forest-spatial-data/duke-forest-spatial-data/Boundary")
forest_sf <- st_read("Duke_Forest_Boundary_Mar2022.shp")
mapview(forest_sf)

#convert coordinates to a spatial dataframe
deer_cam_data_sf <- deer_cam_data_sf %>% st_as_sf(coords = c("Longtitude","Latitude"), crs=4326)

#Step 2: Statistical Tests - Sophie Moyer
#We are trying to determine if time of day has any effect on when deer are seen in the Duke Forest
#Could also run a multi-linear regression to determine if deer presence is dependent on both time of day and temperature. (Could obtain temperature data from the US Forest Service)
library(agricolae)

min(deer_data$Time)
max(deer_data$Time)
median(deer_data$Time)


deer_data <- deer_data %>% mutate(Date = start_date) %>% arrange(Date)
deer_data <- deer_data %>% mutate(Time = start_time) %>% arrange(Time)


ggplot(deer_data, aes(Time, group_size)) + geom_point() + theme_classic() + labs(x = "Time Recorded", y = "Group Size")



first_day <- day(first(deer_data$Date))
first_month <- month(first(deer_data$Date))
deer_ts <- ts(deer_data$group_size, start = c(first_month, first_day), frequency = 31)
full_decomp <- stl(deer_ts,s.window = "periodic")
plot(full_decomp)
deer_trend <- Kendall::SeasonalMannKendall(deer_ts)
deer_trend
#tau = -0.101, 2-sided pvalue = 0.00060103

#Seperate Months
deer_data_march <- deer_data %>% mutate(Month = month(start_date)) %>% filter(Month == 3)
deer_data_april <- deer_data %>% mutate(Month = month(start_date)) %>% filter(Month == 4)
deer_data_may <- deer_data %>% mutate(Month = month(start_date)) %>% filter(Month == 5)

#Looking at the data to determine which statistcal tests to run
ggplot(deer_data_march, aes(start_time, group_size)) + geom_point() + theme_classic() + labs(x = "Time Seen on Camera Trap", y = "Size of Group Seen")

#There seems to be some kind of time series with deer in a group greater than two. 
#Since it seems like 1 group is a large amount of the data, maybe we remove those and 
#see if there is a time relationship
march_biggroups <- deer_data_march %>% filter(group_size >= 2)
ggplot(march_biggroups, aes(start_time, group_size)) + geom_point() + theme_classic() + labs(x = "Time Seen on Camera Trap", y = "Size of Group Seen")

#maybe there is a relationship - lets check another month to see if it is just March 
ggplot(deer_data_april, aes(start_time, group_size)) + geom_point() + theme_classic() + labs(x = "Time Seen on Camera Trap", y = "Size of Group Seen")
april_biggroups <- deer_data_april %>% filter(group_size >= 2)
ggplot(april_biggroups, aes(start_time, group_size)) + geom_point() + theme_classic() + labs(x = "Time Seen on Camera Trap", y = "Size of Group Seen")

#may
ggplot(deer_data_may, aes(start_time, group_size)) + geom_point() + theme_classic() + labs(x = "Time Seen on Camera Trap", y = "Size of Group Seen")
may_biggroups <- deer_data_may %>% filter(group_size >= 2)
ggplot(may_biggroups, aes(start_time, group_size)) + geom_point() + theme_classic() + labs(x = "Time Seen on Camera Trap", y = "Size of Group Seen")

#not sure where to go from here, the plots don't necessarily suggest any relationship between group size and time seen. 
#could look just at the april data, as it seems like there is the most observations from then (almost half the observations were recorded in april)

#time series for april, group size by day
f_day <- day(first(deer_data_april$start_date))
f_month <- month(first(deer_data_april$start_date))
april_ts <- ts(deer_data_april$group_size, start = c(f_month, f_day), frequency = 31)

#decompose
deer_decomp <- stl(april_ts,s.window = "periodic")
plot(deer_decomp)

# Run SMK test
april_trend <- Kendall::SeasonalMannKendall(april_ts)
april_trend 
#tau = 0.0102, 2-sided p-value = 0.80434

#where to go from here: look at the other two months worth of data (could be a problem, may not have enough observations)
#potentially bring in weather data to see if temperature plays a role in how active the deer population is in the Duke Forest: https://wrcc.dri.edu/cgi-bin/rawMAIN.pl?laNDUK
#scrape data for moon phases from: https://tidesandcurrents.noaa.gov/moon_phases.shtml?year=2023&data_type=monApr (try to find data source with moon phase of each day)


