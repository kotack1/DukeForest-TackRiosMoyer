# Tracking White-Tailed Deer Movement Patterns in the Duke Forest using Camera Traps

## Summary

**Repository Summary**  
This repository was created to house the final Environmental Data Analysis project for Katie Tack, Ale Rios, Grace Randall, and Sophie Moyer. Their project focuses on white-tailed deer in the Duke Forest (Durham, Blackwood, and Korstian divisions)

**Data Collection**  
The data was collected through the lab of Dr. Sarah Roberts, whose team (including Katie Tack) placed camera traps along known migration paths. The information collected includes common_name, deployment_id, start_date, start_time, end_date, end_time, cam_id, and group_size. There is another file that contains the longitude and latitude for each camera (deployment_id).

**Project Goals**  
The analysis goals of this project are to determine the movements of white-tailed deer in the Duke Forest based on time of day and moon phase.

## Investigators

**Katie Tack**  
Master of Environmental Management Canidate, Duke University '25  
katie.tack@duke.edu

**Alejandra Rios**  
Master of Environmental Management Canidate, Duke University '25  
alejandra.rios@duke.edu

**Grace Randall**  
Master of Environmental Management Canidate, Duke University '25  
grace.randall@duke.edu

**Sophie Moyer**  
Master of Environmental Management Canidate, Duke University '25  
sophie.moyer@duke.edu

## Keywords
- Duke University
- Duke Forest
- Nicholas School of the Environment
- camera traps
- white-tailed deer
- moon phases
- trail camera survey
- deer migration
- deer management
- deer migration
- Durham
- Blackwood
- Korstian
- deer population

## Database Information

sequences.csv - Provided by Dr. Sarah Roberts at Duke University. 

camera_coords.csv - Provided by Dr. Sarah Roberts at Duke University. 

moon_phases.csv - Created by Katie Tack using https://www.moongiant.com/phase/today/#google_vignette

City_of_Durham_Boundary.shp - Retrieved from the Durham, NC Open Data Portal. 


## Folder structure, file formats, and naming conventions 

Parent Folder: DukeForest-TackRiosMoyer

working_project.rmd - edited file for code input, and statistical and spacial analysis. 

working_project.html - file used to submit final product

README.md - metadata 

TackRiosRandallMoyer_ENV872_Project.rmd - final code for project

Images - images used for powerpoint presentation on project

Data
 
 City_of_Durham_Boundary.shp - working shapefile for spatial analysis
 
 Duke_Forest_Boundary.shp - NOT working shapefile 
 
 Duke_Forest_Boundary_Mar2022 - NOT working shapefile
 
 camera_coords.csv - trail camera coordinates
 
 moon_phases.csv - moon phases 
 
 sequences.csv - deer sighting data

## Metadata

sequences.csv - data collected from trail cameras in the Duke forest including camera id, species sighted, and date and time sighted. 

camera_coords.csv - coordinates of cameras (longitude and latitude), camera id

moon_phases.csv - describes the phase of moon.

City_of_Durham_Boundary.shp - boundary used for spatial analysis within Duke forest.

## Scripts and code

here() - constructing file paths relative to the top-level directory of your R project.

theme() - part of ggplot package, customizes non-data components of plots

read.csv() - importing data from CSV (Comma-Separated Values) files into R as data frames

knitr::include_graphics() - part of the knitr package used to include external images

ymd_hms() - used for sorting, storing, and manipulating date-time data 

as.Date() - used to convert various types of data into date objects

filter() - part of the dplyr package used to select rows from a data frame

select() - part of the dplyr package used to select columns

mutate() - part of the dplyr package used to creating new columns in a data frame or modify existing ones.

left_join() - part of the dplyr package used to merge two data frames by columns

as.numeric() - function used to convert an object to numeric 

ifelse() - used to evaluate a condition and return one value if the condition is true and another value if it is false. 

cut() - used to divide the range of a numeric vector 

st_read() - part of the sf package used to read simple features from a file

mapview() - part of mapview package used for viewing of spatial data

ggplot() - part of ggplot2 package used for creating plots and charts 

print() - used to output an R product

min() - finds the minimum value in a dataset

max() - finds the maximum value in a dataset

median() - finds the median value in a dataset

ts() - used to create a time series object from a numeric vector 

Kendall::SeasonalMannKendall() - used to perform the Seasonal Mann-Kendall test, a non-parametric method for identifying trends in seasonal time series data

stl() - used for performing a Seasonal Decomposition of Time Series by Loess, a method for decompsing a time series into seasonal, trend, and irregular components using loess smoothing. 

## Quality assurance/quality control

<describe any relevant QA/QC procedures taken with your data. Some ideas can be found here:>
<https://www.dataone.org/best-practices/develop-quality-assurance-and-quality-control-plan>
<https://www.dataone.org/best-practices/ensure-basic-quality-control>
<https://www.dataone.org/best-practices/communicate-data-quality>
<https://www.dataone.org/best-practices/identify-outliers>
<https://www.dataone.org/best-practices/identify-values-are-estimated>
