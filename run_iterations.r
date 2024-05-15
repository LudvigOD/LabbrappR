source("./mr_script.r")

iterations <- 5;

#data_vault stores the iteration results in a matrice grouped by row
data_vault <- data.frame(
    `Osorterad` = NA, 
    `Osorterad I Block` = NA,
    `Sorterad I Block` = NA
)

data_vault

for(i in 1:iterations){
    print(i)
}


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

