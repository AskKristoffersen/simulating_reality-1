

rm(list = ls()) # clear work space


######## load packages

library(ggplot2) # sweet plots
library(reshape2) # melt function 


######## source functions

source("functions/simulate_GBM.R")


######## initialize

x0 <- 100 
mu <- 0.01
sigma <- 0.1
n_sim <- 10
end_time <- 1
dt <- 1 / 200
time_vector <- seq(0, end_time, by = dt)


######## simulate paths from GBM


simulated_paths <- simulate_GBM(x0 = x0,
                                mu = mu,
                                sigma = sigma,
                                n_sim = n_sim,
                                time_vector = time_vector)



######### plot simulated paths


#### R plot

plot(time_vector, simulated_paths[, 1], type = "l")

#### ggplot

data_plot <- data.frame('time' = time_vector, "GBM" = simulated_paths)
data_plot <- melt(data_plot,  id = c('time'))

plot_gbm <- ggplot(data_plot, aes(time, value)) +
  geom_line(aes(colour = variable)) +
  theme(legend.position = "none")



#### save ggplot

ggsave(filename = "plots/gbm_paths.png", 
       plot = plot_gbm)
