source("./mr_script.r")

# Initialize data_vault as a named list of empty lists




run_iterations <- function(iterations, files){

    vaults <- list()

    prefix <- c(
        "./Results/resultOsorterad", 
        "./Results/resultOsorteradIBlock", 
        "./Results/resultSorteradIBlock"
    )

    names <- c(
        "Osorterad", 
        "OsorteradIBlock", 
        "SorteradIBlock"
    )

    for(i in 1:iterations){
        data_vault <- list(
            Osorterad = list(),
            OsorteradIBlock = list(),
            SorteradIBlock = list()
        )
        system(
            'cd "/Users/ludvigolunddanielsson/Desktop/progkurs/R-language/Labbproj/LabbrappR/" && javac Main.java && java Main'
        )
        for(file in files){
            for(j in seq_along(prefix)){
                if(startsWith(file, prefix[j])){
                    # Read the data from the file into a data frame
                    data <- file_get_data(file)

                    data_vault[[names[j]]] <- c(data_vault[[names[j]]], list(data))
                    break
                }
            }
        }
        vaults <- append(vaults, data_vault)
    }
    return(vaults)
}

reformat_vaults <- function(vaults) {

    prefix <- c(
        "resultOsorteradIBlock", 
        "resultSorteradIBlock",
        "resultOsorterad"
    )

    data_structure <- c(
        "ArrayList",
        "LinkedList",
        "TreeSet",
        "HashSet"
    )

    reformat_vault <- list(
        list(
            Osorterad = list(
                ArrayList = list(),
                LinkedList = list(),
                TreeSet = list(),
                HashSet = list()
            ),
            OsorteradIBlock = list(
                ArrayList = list(),
                LinkedList = list(),
                TreeSet = list(),
                HashSet = list()
            ),
            SorteradIBlock = list(
                ArrayList = list(),
                LinkedList = list(),
                TreeSet = list(),
                HashSet = list()
            )
        )
    )

    

  for(data_vault in vaults){
    for(data in data_vault){
        for(pref in prefix){
            # print("----------------------")
            # print(pref)
            # print("&&&&&&&")
            # print(data[[3]])
            # print("----------------------")

            if(grepl(pref, data[[3]])){
                print("__Inside if___")
                key <- substr(pref, start = 7, stop = nchar(pref))
                reformat_vault[[key]][[data[[1]]]] <- 
                    c(reformat_vault[[key]][[data[[1]]]], data[[2]])
                break
            }
            
        }
    }
  }


  return(reformat_vault)
}

tmp <- run_iterations(2, input_files)

reformat_vaults(tmp)

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

