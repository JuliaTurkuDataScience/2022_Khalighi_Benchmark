library(readr)
library(dplyr)

### NONSTIFF EXAMPLE ###
matlab_nonstiff <- read_csv("data_matlab/BenchNonStiff.csv", col_names = FALSE)

matlab_nonstiff1 <- data.frame("Error" = matlab_nonstiff$X5,
                               "ExecutionTime" = matlab_nonstiff$X1,
                               "Method" = "M-PI-EX")
matlab_nonstiff2 <- data.frame("Error" = matlab_nonstiff$X6,
                               "ExecutionTime" = matlab_nonstiff$X2,
                               "Method" = "M-PI-PC")
matlab_nonstiff3 <- data.frame("Error" = matlab_nonstiff$X7,
                               "ExecutionTime" = matlab_nonstiff$X3,
                               "Method" = "M-PI-IM1")
matlab_nonstiff4 <- data.frame("Error" = matlab_nonstiff$X8,
                               "ExecutionTime" = matlab_nonstiff$X4,
                               "Method" = "M-PI-IM2")

julia_nonstiff_error1 <- read_csv("data_Julia/NonStiff_E1.csv")
julia_nonstiff_error2 <- read_csv("data_Julia/NonStiff_E2.csv")
julia_nonstiff_time1 <- read_csv("data_Julia/NonStiff_T1.csv")
julia_nonstiff_time2 <- read_csv("data_Julia/NonStiff_T2.csv")

julia_nonstiff1 <- data.frame("Error" = julia_nonstiff_error1$Column1,
                              "ExecutionTime" = julia_nonstiff_time1$Column1,
                              "Method" = "J-PC")
julia_nonstiff2 <- data.frame("Error" = julia_nonstiff_error2$Column1,
                              "ExecutionTime" = julia_nonstiff_time2$Column1,
                              "Method" = "J-NR")

nonstiff_benchmark_df <- julia_nonstiff1 %>%
  full_join(julia_nonstiff2) %>%
  full_join(matlab_nonstiff1) %>%
  full_join(matlab_nonstiff2) %>%
  full_join(matlab_nonstiff3) %>%
  full_join(matlab_nonstiff4)

write_csv(nonstiff_benchmark_df,
          file = "data/nonstiff_benchmark.csv")

### STIFF EXAMPLE ###
matlab_stiff <- read_csv("data_matlab/BenchStiff.csv", col_names = FALSE)

matlab_stiff1 <- data.frame("Error" = matlab_stiff$X5,
                            "ExecutionTime" = matlab_stiff$X1,
                            "Method" = "M-PI-EX")
matlab_stiff2 <- data.frame("Error" = matlab_stiff$X6,
                            "ExecutionTime" = matlab_stiff$X2,
                            "Method" = "M-PI-PC")
matlab_stiff3 <- data.frame("Error" = matlab_stiff$X7,
                            "ExecutionTime" = matlab_stiff$X3,
                            "Method" = "M-PI-IM1")
matlab_stiff4 <- data.frame("Error" = matlab_stiff$X8,
                            "ExecutionTime" = matlab_stiff$X4,
                            "Method" = "M-PI-IM2")

julia_stiff_error1 <- read_csv("data_Julia/Stiff_E1.csv")
julia_stiff_error2 <- read_csv("data_Julia/Stiff_E2.csv")
julia_stiff_time1 <- read_csv("data_Julia/Stiff_T1.csv")
julia_stiff_time2 <- read_csv("data_Julia/Stiff_T2.csv")

julia_stiff1 <- data.frame("Error" = julia_stiff_error1$Column1,
                              "ExecutionTime" = julia_stiff_time1$Column1,
                              "Method" = "J-PC")
julia_stiff2 <- data.frame("Error" = julia_stiff_error2$Column1,
                              "ExecutionTime" = julia_stiff_time2$Column1,
                              "Method" = "J-NR")

stiff_benchmark_df <- julia_stiff1 %>%
  full_join(julia_stiff2) %>%
  full_join(matlab_stiff1) %>%
  full_join(matlab_stiff2) %>%
  full_join(matlab_stiff3) %>%
  full_join(matlab_stiff4)

write_csv(stiff_benchmark_df,
          file = "data/stiff_benchmark.csv")
