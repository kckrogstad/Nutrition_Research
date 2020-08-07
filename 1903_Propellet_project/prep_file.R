#Load file, WD, and packages####

setwd("C:/Users/kirby/Box/UNL Dairy Lab File/1903 - ProPellet/Data/R.Code")

library(lme4)
library(lmerTest)
library(emmeans)
library(pbkrtest)
library(ggpubr)
library(readxl)
library(dplyr)
library(tidyr)
library(broom)

d <- read_xlsx("C:/Users/kirby/Box/UNL Dairy Lab File/1903 - ProPellet/Data/Data-Raw/Raw Data.xlsx", sheet = "StatsSheet", na = ".")

