input_files <- list.files("./Results", full.names = TRUE)

# Function to read and process each input file
file_get_data <- function(file_name) {
  tmp_data <- read.csv(
    file_name,
    sep = " "
    )
  df <- data.frame(
      Functions = row.names(tmp_data),
      Values = unlist(tmp_data),
      row.names = NULL
    )

  extracted_name <- gsub(".*/([^/]+)\\.txt", "\\1", file_name)

  list <- list(colnames(tmp_data)[1], df, extracted_name)

  return(list)
}


data <- file_get_data(input_files[1])


plot_data <- function(data) {
  if (length(data) >= 2) {  # Check if dataframe has at least two columns
    # Set up PDF output device
    pdf(paste("./Plots/", data[[3]], ".pdf", sep = ""))
    barplot(
      height = data[[2]]$Values, 
      names.arg = data[[2]]$Functions, 
      col = "red", 
      xlab = "Functions", 
      ylab = "Values",
      main = data[[3]],
      cex.names = 0.8
    )
    dev.off()  # Close the output device after plotting
    print("Plot saved as 'plot.pdf'")
  } else {
    print("Dataframe does not contain enough data for plotting.")
  }
}

plot_data2 <- function(data) {
  if (length(data) >= 2) {  # Check if dataframe has at least two columns
    # Set up PDF output device
    pdf(paste("./Plots/", data[[3]], "test", ".pdf", sep = ""))
    plot(
      data[[2]]$Values,
      type = "l",
      col = "red", 
      xlab = "Functions", 
      ylab = "Values",
      main = data[[3]],
      xaxt = "n",
    )
    axis(
      1,
      at = seq_len(nrow(data[[2]])),
      labels = data[[2]]$Functions,
      cex.axis = 0.8
      )
    dev.off()  # Close the output device after plotting
    print("Plot saved as 'plot.pdf'")
  } else {
    print("Dataframe does not contain enough data for plotting.")
  }
}

plot_two_datas <- function(datas, sorting) {
  if (length(datas[[1]]) >= 2) {  # Check if dataframe has at least two columns
    # Set up PDF output device
    pdf(
      paste(
        "./Plots/", 
        datas[[1]][[3]],
        "_",
        datas[[2]][[3]],
        "test_with_2datas",
        ".pdf",
        sep = ""
        )
      )
    plot(
      datas[[1]][[2]]$Values,
      type = "l",
      col = "red", 
      xlab = "Functions", 
      ylab = "Values",
      main = sorting,
      xaxt = "n",
    )

    lines(
        datas[[2]][[2]]$Values,
        col = "blue", 
      )

    axis(
      1,
      at = seq_len(nrow(datas[[1]][[2]])),
      labels = datas[[1]][[2]]$Functions,
      cex.axis = 0.8
      )

    legend(
      "topright",
      legend = c(datas[[1]][[1]], datas[[2]][[1]]),
      col = c("red", "blue"),
      lty = 1
    )

    dev.off()  # Close the output device after plotting
    print("Plot saved as 'plot.pdf'")
  } else {
    print("Dataframe does not contain enough data for plotting.")
  }
}

#plot_data2(data)


#List
plot_two_datas(list(file_get_data(input_files[1]), file_get_data(input_files[6])), "Osorterad ArrayList & DLinkedList")

#List
plot_two_datas(list(file_get_data(input_files[2]), file_get_data(input_files[3])), "OsorteradIBlock ArrayList & DLinkedList")

#List
plot_two_datas(list(file_get_data(input_files[9]), file_get_data(input_files[10])), "SorteradIBlock ArrayList & DLinkedList")

#Hash
plot_two_datas(list(file_get_data(input_files[8]), file_get_data(input_files[7])), "Osorterad TreeSet & HashSet")

#Hash
plot_two_datas(list(file_get_data(input_files[5]), file_get_data(input_files[4])), "OsorteradIBlock TreeSet & HashSet")

#Hash
plot_two_datas(list(file_get_data(input_files[12]), file_get_data(input_files[11])), "SorteradIBlock TreeSet & HashSet")



# # Process each input file and store the dataframes
# for (file in input_files) {
#   df <- process_input_file(file)
#   for (method in methods) {
#     method_df <- df[df$Method == method, ]
#     method_dfs[[method]] <- rbind(method_dfs[[method]], method_df)
#   }
# }

# # Write the dataframes to files for each method
# for (method in methods) {
#   write.csv(method_dfs[[method]], paste0(method, ".csv"), row.names = FALSE)
# }

