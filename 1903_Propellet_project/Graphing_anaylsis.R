####Graphing results####

fac <- colnames(d)[2:8]
d[fac] <- lapply(d[fac], factor) #set factors for experiment

str(d)                           #check structure of data frame 
summary(d)                      #Look at data - min, maxes to make sure no typos

graph_boxplots <- function(x){
  tmp <- d[c("Treatment", "F", "D", "Cow", "Period", x)]
  eq <- paste(x, "~" , "F + D + F:D + (1|Cow) + (1|Period)") # X is the R object and the tilda as the separator
  fit <- lmer(as.formula(eq), data = tmp)
  output <- as.numeric(fitted(fit))
  tmp[6] <- output
  p <- tmp %>% ggplot(aes(Treatment, output , linetype = F, fill= D)) + 
    geom_boxplot(outlier.shape = NA) + 
    scale_fill_manual("DDGS Form", values = c("Meal" = '#CC0000', "Pellet" = 'White')) + 
    scale_linetype_manual("Forage Concentration", values = c("Low Forage" = "solid", "High Forage" = "dashed")) + 
    scale_y_continuous(name = colnames(tmp)[6]) + 
    scale_x_discrete(name = NULL) + 
    theme(axis.text.x = element_blank(), 
          axis.ticks.x = element_blank(),
          axis.line = element_line(color = "Black"))
}

graph.inputs <- colnames(d)[14:length(d)]

lapply(graph.inputs, graph_boxplots)

