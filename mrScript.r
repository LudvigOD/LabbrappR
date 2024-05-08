# List of input file names
input_files <- c("resultOsorterad.txt", "resultOsorteradIBlock.txt", "resultOsorteradIBlockSets.txt", "resultOsorteradSets.txt", "resultSorteradIBlock.txt", "resultSorteradIBlockSets.txt")

# List of methods
methods <- c("timeAddAll", "timeSort", "timeContains", "timeGet", "timeRemove", "timeSize")

#process_input_file("resultOsorterad.txt")

# Function to read and process each input file
process_input_file <- function(file_name) {
  # Read the content of the file
  content <- readLines(file_name) 
  
  method_names <- character()
  
  # Iterate over each line in the content
  for (line in content[-1]) {
    # Extract the method name from the line and append it to the method_names vector
    method_name <- gsub("\\s*([a-zA-Z]+)\\s+([0-9.-]+).*", "\\1", line)
    method_names <- c(method_names, method_name)
  }

  values <- c() 
  
  # Create a dataframe
  df <- data.frame(Method = method_names)
  
  return(c(content ,df))
}

# Create a list to store dataframes for each method
method_dfs <- lapply(methods, function(method) data.frame(Method = character(), Value = numeric(), DataStructure = character()))

# Process each input file and store the dataframes
for (file in input_files) {
  df <- process_input_file(file)
  for (method in methods) {
    method_df <- df[df$Method == method, ]
    method_dfs[[method]] <- rbind(method_dfs[[method]], method_df)
  }
}

# Write the dataframes to files for each method
for (method in methods) {
  write.csv(method_dfs[[method]], paste0(method, ".csv"), row.names = FALSE)
}

