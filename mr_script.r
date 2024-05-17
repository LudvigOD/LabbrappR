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



#plot_data2(data)


# #List
# plot_two_datas(list(file_get_data(input_files[1]), file_get_data(input_files[6])), "Osorterad ArrayList & DLinkedList")

# #List
# plot_two_datas(list(file_get_data(input_files[2]), file_get_data(input_files[3])), "OsorteradIBlock ArrayList & DLinkedList")

# #List
# plot_two_datas(list(file_get_data(input_files[9]), file_get_data(input_files[10])), "SorteradIBlock ArrayList & DLinkedList")

# #Hash
# plot_two_datas(list(file_get_data(input_files[8]), file_get_data(input_files[7])), "Osorterad TreeSet & HashSet")

# #Hash
# plot_two_datas(list(file_get_data(input_files[5]), file_get_data(input_files[4])), "OsorteradIBlock TreeSet & HashSet")

# #Hash
# plot_two_datas(list(file_get_data(input_files[12]), file_get_data(input_files[11])), "SorteradIBlock TreeSet & HashSet")



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

