library(readr)
library(dplyr)

integrate_data <- function(file_name, matlab_file,
                           julia_error1, julia_time1,
                           julia_error2, julia_time2) {
  
  raw_matlab_df <- read_csv(matlab_file, col_names = FALSE)
  
  matlab_df1 <- data.frame("Error" = raw_matlab_df$X5,
                           "ExecutionTime" = raw_matlab_df$X1,
                           "Method" = "M-PI-EX")
  matlab_df2 <- data.frame("Error" = raw_matlab_df$X6,
                           "ExecutionTime" = raw_matlab_df$X2,
                           "Method" = "M-PI-PC")
  matlab_df3 <- data.frame("Error" = raw_matlab_df$X7,
                           "ExecutionTime" = raw_matlab_df$X3,
                           "Method" = "M-PI-IM1")
  matlab_df4 <- data.frame("Error" = raw_matlab_df$X8,
                           "ExecutionTime" = raw_matlab_df$X4,
                           "Method" = "M-PI-IM2")
  
  julia_time_df1 <- read_csv(julia_time1)
  julia_error_df1 <- read_csv(julia_error1)
  julia_time_df2 <- read_csv(julia_time2)
  julia_error_df2 <- read_csv(julia_error2)
  
  julia_df1 <- data.frame("Error" = julia_error_df1$Column1,
                          "ExecutionTime" = julia_time_df1$Column1,
                          "Method" = "J-PC")
  julia_df2 <- data.frame("Error" = julia_error_df2$Column1,
                          "ExecutionTime" = julia_time_df2$Column1,
                          "Method" = "J-NR")
  
  benchmark_df <- julia_df1 %>%
    full_join(julia_df2) %>%
    full_join(matlab_df1) %>%
    full_join(matlab_df2) %>%
    full_join(matlab_df3) %>%
    full_join(matlab_df4)
  
  write_csv(benchmark_df,
            file = file_name)
}

integrate_data("data/nonstiff_benchmark.csv", "data_matlab/BenchNonStiff.csv",
               "data_Julia/NonStiff_E1.csv", "data_Julia/NonStiff_T1.csv",
               "data_Julia/NonStiff_E2.csv", "data_Julia/NonStiff_T2.csv")

integrate_data("data/stiff_benchmark.csv", "data_matlab/BenchStiff.csv",
               "data_Julia/Stiff_E1.csv", "data_Julia/Stiff_T1.csv",
               "data_Julia/Stiff_E2.csv", "data_Julia/Stiff_T2.csv")

integrate_data("data/harmonic_benchmark.csv", "data_matlab/BenchHarmonic.csv",
               "data_Julia/Harmonic_E1.csv", "data_Julia/Harmonic_T1.csv",
               "data_Julia/Harmonic_E2.csv", "data_Julia/Harmonic_T2.csv")

integrate_data("data/lotka_volterra_benchmark.csv", "data_matlab/BenchLV.csv",
               "data_Julia/LV_E1.csv", "data_Julia/LV_T1.csv",
               "data_Julia/LV_E2.csv", "data_Julia/LV_T2.csv")

sir_time_df1 <- read_csv("data_Julia/SIR_T1.csv")
sir_error_df1 <- read_csv("data_Julia/SIR_E1.csv")
sir_time_df2 <- read_csv("data_Julia/SIR_T2.csv")
sir_error_df2 <- read_csv("data_Julia/SIR_E2.csv")
sir_time_df3 <- read_csv("data_Julia/SIR_T3.csv")
sir_error_df3 <- read_csv("data_Julia/SIR_E3.csv")
sir_time_df4 <- read_csv("data_Julia/SIR_T4.csv")
sir_error_df4 <- read_csv("data_Julia/SIR_E4.csv")
sir_time_df5 <- read_csv("data_Julia/SIR_T5.csv")
sir_error_df5 <- read_csv("data_Julia/SIR_E5.csv")
sir_time_df6 <- read_csv("data_Julia/SIR_T6.csv")
sir_error_df6 <- read_csv("data_Julia/SIR_E6.csv")
sir_time_df7 <- read_csv("data_Julia/SIR_T7.csv")
sir_error_df7 <- read_csv("data_Julia/SIR_E7.csv")
sir_time_df8 <- read_csv("data_Julia/SIR_T8.csv")
sir_error_df8 <- read_csv("data_Julia/SIR_E8.csv")
sir_time_df9 <- read_csv("data_Julia/SIR_T9.csv")
sir_error_df9 <- read_csv("data_Julia/SIR_E9.csv")

sir_df1 <- data.frame("Error" = sir_error_df1$Column1,
                      "ExecutionTime" = sir_time_df1$Column1,
                      "Method" = "J-1")
sir_df2 <- data.frame("Error" = sir_error_df2$Column1,
                      "ExecutionTime" = sir_time_df2$Column1,
                      "Method" = "J-2")
sir_df3 <- data.frame("Error" = sir_error_df3$Column1,
                      "ExecutionTime" = sir_time_df3$Column1,
                      "Method" = "J-3")
sir_df4 <- data.frame("Error" = sir_error_df4$Column1,
                      "ExecutionTime" = sir_time_df4$Column1,
                      "Method" = "J-PI-EX")
sir_df5 <- data.frame("Error" = sir_error_df5$Column1,
                      "ExecutionTime" = sir_time_df5$Column1,
                      "Method" = "J-NonLinearAlg")
sir_df6 <- data.frame("Error" = sir_error_df6$Column1,
                        "ExecutionTime" = sir_time_df6$Column1,
                        "Method" = "J-FLMMBDF")
sir_df7 <- data.frame("Error" = sir_error_df7$Column1,
                      "ExecutionTime" = sir_time_df7$Column1,
                      "Method" = "J-FLMMNewtonG")
sir_df8 <- data.frame("Error" = sir_error_df8$Column1,
                      "ExecutionTime" = sir_time_df8$Column1,
                      "Method" = "J-FLMMTrap")
sir_df9 <- data.frame("Error" = sir_error_df9$Column1,
                      "ExecutionTime" = sir_time_df9$Column1,
                      "Method" = "J-PECE")

sir_matlab_df <- read_csv("data_matlab/BenchSIR.csv", col_names = FALSE)

sir_matlab_df1 <- data.frame("Error" = sir_matlab_df$X5,
                             "ExecutionTime" = sir_matlab_df$X1,
                             "Method" = "M-PI-EX")
sir_matlab_df2 <- data.frame("Error" = sir_matlab_df$X6,
                             "ExecutionTime" = sir_matlab_df$X2,
                             "Method" = "M-PI-PC")
sir_matlab_df3 <- data.frame("Error" = sir_matlab_df$X7,
                             "ExecutionTime" = sir_matlab_df$X3,
                             "Method" = "M-PI-IM1")
sir_matlab_df4 <- data.frame("Error" = sir_matlab_df$X8,
                             "ExecutionTime" = sir_matlab_df$X4,
                             "Method" = "M-PI-IM2")

sir_benchmark_df <- sir_df1 %>%
  full_join(sir_df2) %>%
  full_join(sir_df3) %>%
  full_join(sir_df4) %>%
  full_join(sir_df5) %>%
  full_join(sir_df6) %>%
  full_join(sir_df7) %>%
  full_join(sir_df8) %>%
  full_join(sir_df9) %>%
  full_join(sir_matlab_df1) %>%
  full_join(sir_matlab_df2) %>%
  full_join(sir_matlab_df3) %>%
  full_join(sir_matlab_df4)

write_csv(sir_benchmark_df,
          file = "data/sir_benchmark.csv")
