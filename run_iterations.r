source("./mr_script.r")

#data_vault stores the iteration results in a matrice grouped by row
data_vault <- data.frame(
    `Osorterad` = c(),
    `Osorterad I Block` = c(),
    `Sorterad I Block` = c()
)

data_vault

#give files input_files as argument
run_iterations <- function(iterations, files){

    prefix <- c(
        "resultOsorterad", 
        "resultOsorteradIBlock", 
        "resultSorteradIBlock"
        )



    run_iterations <- function(iterations, files){
    prefix <- c(
        "resultOsorterad", 
        "resultOsorteradIBlock", 
        "resultSorteradIBlock"
    )

    for(i in 1:iterations){
        system(
            'cd "/Users/ludvigolunddanielsson/Desktop/progkurs/R-language/Labbproj/LabbrappR/" && javac Main.java && java Main'
        )

        for(file in files){
            for(j in 1:length(prefix)){
                if(startsWith(file, prefix[j])){
                    # Extract the data from the file (You need to define file_get_data function)
                    data <- file_get_data(file)
                    
                    # Add the data to the appropriate column in data_vault
                    data_vault[i, j] <- data
                    break
                }
            }
        }
    }
}



}


run_iterations(1, input_files)



# for(file in input_files){
    
# }










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

