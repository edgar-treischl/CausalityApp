#Confounder/Collider Functions###################
#library(tidyverse)

confounder <- function(n, r) {
  set.seed(5)
  z <- stats::rnorm(n, 0, 1)          # zero-mean latent confounder
  x <- r * z + stats::rnorm(n, 0, 1)  # noise with mean 0
  y <- r * z + stats::rnorm(n, 0, 1)
  df <- data.frame(x, y, z)
  return(df)
}

#confounder(n = 500, r = 0.2)

collider <- function(n, rx, ry) {
  set.seed(5)
  x <- stats::rnorm(n, 5, 3)
  y <- stats::rnorm(n, 10, 1)
  collider <- rx * x + ry * y + stats::rnorm(n, 0, 1)  # zero-mean noise
  df <- data.frame(x, y, collider)
  return(df)
}

#df_coll <- collider(n = 1000, rx = 0.5, ry = 0.5)

mediator <- function(n, m, w) {
  set.seed(5)
  x <- stats::rnorm(n, 10, 3)
  random1 <- stats::runif(n, min = min(x), max = max(x))
  
  # Important step 1: mediator = m*x + (1 - m)*random
  mediator <- x * m + random1 * (1 - m)
  
  random2 <- stats::runif(n, min = min(mediator), max = max(mediator))
  
  # Important step 2: y = m*mediator + (1 - m)*random + w*x
  y <- m * mediator + (1 - m) * random2 + w * x
  
  df <- data.frame(x, y, mediator)
  return(df)
}

#df_mediator <- mediator(100, 0.5)

mediator_new <- function(fallzahl, mediation, xeffect) {
  set.seed(5)
  x <- stats::rnorm(fallzahl, 10, 3)
  random1 <- stats::runif(fallzahl, min = min(x), max = max(x))
  
  # Important step 1: mediator = mediation*x + (1 - mediation)*random
  mediator <- x * mediation + random1 * (1 - mediation)
  
  random2 <- stats::runif(fallzahl, min = min(mediator), max = max(mediator))
  
  # Important step 2: y = 0.5*mediator + 0.5*random + xeffect*x
  y <- 0.5 * mediator + 0.5 * random2 + xeffect * x
  
  df <- data.frame(x, y, mediator)
  return(df)
}

#df <- mediator(n = 2000, m = 0.5)
#fm <- lm(y ~ x, df)
#summary(fm)
#fm <- lm(y ~ x + mediator, df)
#summary(fm)

#ggplot(data = df, aes(x = x, y = y)) +
#  geom_smooth() +
#  geom_point()

#Shoesexexample#######################

var_confounder <- function(n, y, sd, bonus) {
  set.seed(12334)
  sex <- stats::rbinom(n, 1, 0.5)
  
  # Simulate shoe size with male effect
  schoesize <- stats::rnorm(n, 36, 4) + sex * stats::rnorm(n, 4, 2)
  
  # Simulate income with user-defined bonus for males
  income <- stats::rnorm(n, y, sd) + sex * stats::rnorm(n, bonus, sd)
  
  sex <- factor(sex, levels = c(0, 1), labels = c("Female", "Male"))
  
  df <- data.frame(sex, schoesize, income)
  return(df)
}

simulated_data <- function(n = 500, y, sd = 333, bonus) {
  set.seed(12334)
  sex <- stats::rbinom(n, 1, 0.5)
  
  # Apply income boost to males (sex == 1)
  income <- stats::rnorm(n, y, sd) + sex * stats::rnorm(n, bonus, sd)
  
  sex <- factor(sex, levels = c(0, 1), labels = c("Female", "Male"))
  
  df <- data.frame(sex, income)
  return(df)
}
