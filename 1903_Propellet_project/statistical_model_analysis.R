####Statistical Analysis####

fac <- colnames(d)[2:8]
d[fac] <- lapply(d[fac], factor) #set factors for experiment

str(d)                           #check structure of data frame 
summary(d)                      #Look at data - min, maxes to make sure no typos

fit <- lmer(Less5.6 ~ F + D + F:D + (1|Cow) + (1|Period), data = tmp)  #run linear model 
ano <- tidy(anova(fit, type = 3, ddf="Kenward-Roger"))  #anova table with pvalues
lsm <- lsmeans(fit, ~F:D)                               #get least square mean and SE 
lsm

model.inputs <- colnames(d)[c(10:length(d))]  #Create Model inputs List
length(model.inputs)                          #Check Length of model input list


out <- function(x){                                         #For Loop that Runs and outputs all relevant analysis 
  tmp <- d[c("F", "D", "Cow", "Period", x)]
  eq <- paste(x, "~" , "F + D + F:D + (1|Cow) + (1|Period)") # X is the R object and the tilda as the separator
  fit <- lmer(as.formula(eq), data = tmp)
  ano <- tidy(anova(fit, type = 3, ddf="Kenward-Roger"))
  lsm <- tidy(lsmeans(fit, ~F:D))
  out <- c("Variable" = x, "MLF" = lsm$estimate[2], "MHF" = lsm$estimate[1],"PLF" = lsm$estimate[4], "PHF" = lsm$estimate[3],
                  "SE" = max(lsm$std.error), "F" = ano$p.value[1], "D" = ano$p.value[2], "FxD" = ano$p.value[3])
}

output <- lapply(model.inputs, out) %>% bind_rows()

write.csv(output,"stats.csv")


