library(readr)
library(dplyr)
library(ggplot2)
library(patchwork)

pc_error <- read_csv("data_Julia/ErrRnd1.csv")
pc_time <- read_csv("data_Julia/tRnd1.csv")

pc_df <- data.frame("Error" = pc_error$Column1,
                    "ExecutionTime" = pc_time$Column1,
                    "Method" = "PC")

nr_error <- read_csv("data_Julia/ErrRnd2.csv")
nr_time <- read_csv("data_Julia/tRnd2.csv")

nr_df <- data.frame("Error" = nr_error$Column1,
                    "ExecutionTime" = nr_time$Column1,
                    "Method" = "NR")

# pece_error <- read_csv("data_Julia/ErrRnd3.csv")
# pece_time <- read_csv("data_Julia/tRnd3.csv")
# 
# pece_df <- data.frame("Error" = pece_error$Column1,
#                       "ExecutionTime" = pece_time$Column1,
#                       "Method" = "PECE")

matlab1_df <- read_csv("data_matlab/RndEx1.csv")
matlab2_df <- read_csv("data_matlab/RndEx2.csv")
matlab3_df <- read_csv("data_matlab/RndEx3.csv")
matlab4_df <- read_csv("data_matlab/RndEx4.csv")

matlab_method1_time <- c(matlab1_df$Bench1_1,
                         matlab2_df$Bench2_1,
                         matlab3_df$Bench3_1,
                         matlab4_df$Bench4_1)

matlab_method1_error <- c(matlab1_df$Bench1_5,
                          matlab2_df$Bench2_5,
                          matlab3_df$Bench3_5,
                          matlab4_df$Bench4_5)

matlab_method1_df <- data.frame("Error" = matlab_method1_error,
                                "ExecutionTime" = matlab_method1_time,
                                "Method" = "M-PI-EX")

matlab_method2_time <- c(matlab1_df$Bench1_2,
                         matlab2_df$Bench2_2,
                         matlab3_df$Bench3_2,
                         matlab4_df$Bench4_2)

matlab_method2_error <- c(matlab1_df$Bench1_6,
                          matlab2_df$Bench2_6,
                          matlab3_df$Bench3_6,
                          matlab4_df$Bench4_6)

matlab_method2_df <- data.frame("Error" = matlab_method2_error,
                                "ExecutionTime" = matlab_method2_time,
                                "Method" = "M-PI-PC")

matlab_method3_time <- c(matlab1_df$Bench1_3,
                         matlab2_df$Bench2_3,
                         matlab3_df$Bench3_3,
                         matlab4_df$Bench4_3)

matlab_method3_error <- c(matlab1_df$Bench1_7,
                          matlab2_df$Bench2_7,
                          matlab3_df$Bench3_7,
                          matlab4_df$Bench4_7)

matlab_method3_df <- data.frame("Error" = matlab_method3_error,
                                "ExecutionTime" = matlab_method3_time,
                                "Method" = "M-PI-IM1")

matlab_method4_time <- c(matlab1_df$Bench1_4,
                         matlab2_df$Bench2_4,
                         matlab3_df$Bench3_4,
                         matlab4_df$Bench4_4)

matlab_method4_error <- c(matlab1_df$Bench1_8,
                          matlab2_df$Bench2_8,
                          matlab3_df$Bench3_8,
                          matlab4_df$Bench4_8)

matlab_method4_df <- data.frame("Error" = matlab_method4_error,
                                "ExecutionTime" = matlab_method4_time,
                                "Method" = "M-PI-IM2")

benchmark_df <- pc_df %>%
  full_join(nr_df) %>%
  full_join(matlab_method1_df) %>%
  full_join(matlab_method2_df) %>%
  full_join(matlab_method3_df) %>%
  full_join(matlab_method4_df)

# write_csv(benchmark_df,
#           "data/rnd_params_benchmark.csv")

# benchmark_df <- benchmark_df %>%
#   filter(Error < 500)

# p1 <- ggplot(pc_df, aes(x = ExecutionTime, y = Error)) +
#   geom_point() +
#   theme_classic()

# p2 <- ggplot(nr_df, aes(x = ExecutionTime, y = Error)) +
#   geom_point() +
#   theme_classic()

# p3 <- ggplot(pece_df, aes(x = ExecutionTime, y = Error)) +
#   geom_point() +
#   theme_classic()

# p <- p1 + p2 + p3

# ggsave("random_benchmark.pdf",
#        plot = p,
#        width = 15,
#        height = 7)

# p4 <- ggplot(benchmark_df, aes(x = ExecutionTime,
#                                y = Error,
#                                colour = Method)) +
#   geom_point() +
#   theme_classic()

# foreign function from:
# https://stackoverflow.com/questions/11610377/how-do-i-change-the-formatting-of-numbers-on-an-axis-with-ggplot
fancy_scientific <- function(l) {
  # turn in to character string in scientific notation
  l <- format(l, scientific = TRUE)
  # quote the part before the exponent to keep all the digits
  l <- gsub("^(.*)e", "'\\1'e", l)
  # turn the 'e+' into plotmath format
  l <- gsub("e", "%*%10^", l)
  # return this as an expression
  parse(text = l)
}

pb1 <- ggplot(benchmark_df, aes(x = Method, y = Error)) +
  geom_boxplot() +
  scale_y_log10(labels = fancy_scientific) +
  theme_classic()

pb2 <- ggplot(benchmark_df, aes(x = Method, y = ExecutionTime)) +
  geom_boxplot() +
  scale_y_log10(labels = fancy_scientific) +
  theme_classic()

pb <- pb1 / pb2

ggsave("boxes.pdf",
       path = "figs",
       plot = pb,
       width = 10,
       height = 7)
