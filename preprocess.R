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
