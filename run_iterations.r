source("./mr_script.r")

# Initialize data_vault as a named list of empty lists

list_func <- c(
        "timeAddAll",
        "timeSort",
        "timeContains",
        "timeGet",
        "timeRemove",
        "timeSize"
    )

    set_func <- c(
        "timeAddAll",
        "timeContains",
        "timeRemove",
        "timeSize"
    )



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
    it <- 0

    for(i in 1:iterations){
        data_vault <- list(
            Osorterad = list(),
            OsorteradIBlock = list(),
            SorteradIBlock = list()
        )
        print(it)
        system(
            'cd "/Users/ludvigolunddanielsson/Desktop/progkurs/R-language/Labbproj/LabbrappR/" && javac Main.java && java Main'
        )
        i <- i + 1
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

    

  for(data_vault in vaults){
    for(data in data_vault){
        for(pref in prefix){
            if(grepl(pref, data[[3]])){
                key <- substr(pref, start = 7, stop = nchar(pref))
                tmpList <- data[[2]]$Values
                
                reformat_vault[[key]][[data[[1]]]] <- 
                    append(reformat_vault[[key]][[data[[1]]]], list(tmpList))

                break
            }
            
        }
        
    }
  }
  return(reformat_vault)
}

make_dataframe <- function(reformat_vaults){
    sorters <- c("OsorteradIBlock", "SorteradIBlock", "Osorterad")

    df_list <-  list(
        OsorteradIBlock = list(
            ArrayList = NULL,
            LinkedList = NULL,
            TreeSet = NULL,
            HashSet = NULL
        ),
        SorteraIBlock = list(
            ArrayList = NULL,
            LinkedList = NULL,
            TreeSet = NULL,
            HashSet = NULL
        ),
        Osorterad = list(
            ArrayList = NULL,
            LinkedList = NULL,
            TreeSet = NULL,
            HashSet = NULL
        )
    )

    for(sorting in names(reformat_vaults)){
        tmpArr <- data.frame(
            "timeAddAll" = c(0),
            "timeSort" = c(0),
            "timeContains" = c(0),
            "timeGet" = c(0),
            "timeRemove" = c(0),
            "timeSize" = c(0)
        )

        tmpLinked <- data.frame(
            "timeAddAll" = c(0),
            "timeSort" = c(0),
            "timeContains" = c(0),
            "timeGet" = c(0),
            "timeRemove" = c(0),
            "timeSize" = c(0)
        
        )

        tmpTree <- data.frame(
            "timeAddAll" = c(0),
            "timeContains" = c(0),
            "timeRemove" = c(0),
            "timeSize" = c(0)
        
        )

        tmpHash <- data.frame(
            "timeAddAll" = c(0),
            "timeContains" = c(0),
            "timeRemove" = c(0),
            "timeSize" = c(0)
        
        )

        for(struct in names(reformat_vaults[[sorting]])){
            i <- 0
                for(values in reformat_vaults[[sorting]][[struct]]){
                    print(struct)
                    if(struct == "ArrayList")
                    {
                        tmpArr <- rbind(tmpArr, values)
                    }
                    else if(struct == "LinkedList")
                    {
                        tmpLinked <- rbind(tmpLinked, values)
                    }
                    else if(struct == "TreeSet")
                    {
                        tmpTree <- rbind(tmpTree, values)

                    }
                    else if(struct == "HashSet")
                    {
                        tmpHash <- rbind(tmpHash, values)
                    }
                }
        }
        
        tmpArr <- tmpArr[-1,]
        tmpLinked <- tmpLinked[-1,]
        tmpTree <- tmpTree[-1,]
        tmpHash <- tmpHash[-1,]
        
        df_list[[sorting]][["ArrayList"]] <- tmpArr
        df_list[[sorting]][["LinkedList"]] <- tmpLinked
        df_list[[sorting]][["TreeSet"]] <- tmpTree
        df_list[[sorting]][["HashSet"]] <- tmpHash
    }
    return(df_list)
}

tmp <- run_iterations(100, input_files)
reform <- reformat_vaults(tmp)
tmp_df_list <- make_dataframe(reform)




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


get_t.test <- function(method){
}

to_text <- function(df_list){
  
  file <- "iteration_res.txt"
  
  print(names(df_list))
  
  write("ITERATION_DATA", file)
  
  
  for(sorting in names(df_list)){
    write("~~~~~~~~~~~~~~~~~~~~~~~START-SORTING~~~~~~~~~~~~~~~~~~~~~~~~~~~~", file, append = TRUE)
    write(sorting, file, append = TRUE)
    for(struct in names(df_list[[sorting]])){
      write("---------START-STRUCTURE---------", file, append = TRUE)
      write(struct, file, append = TRUE)
      write.table(df_list[[sorting]][[struct]], file, sep = "\t", row.names = FALSE, append = TRUE)
      write("---------END-STRUCTURE---------\n", file, append = TRUE)
    }
    write("~~~~~~~~~~~~~~~~~~~~~~~END-SORTING~~~~~~~~~~~~~~~~~~~~~~~~~~~~\n", file, append = TRUE)
    
  }
}


get_mean <- function(df_list){
  file <- "ttest_res.txt"
  
  print(names(df_list))
  
  write("MEAN_RESULTS", file)
  
  
  for(sorting in names(df_list)){
    write("~~~~~~~~~~~~~~~~~~~~~~~START-SORTING~~~~~~~~~~~~~~~~~~~~~~~~~~~~", file, append = TRUE)
    write(sorting, file, append = TRUE)
    for(struct in names(df_list[[sorting]])){
      write("---------START-STRUCTURE---------", file, append = TRUE)
      write(struct, file, append = TRUE)
      print(t.test(df_list[[sorting]][[struct]])$estimate)
      write(t.test(df_list[[sorting]][[struct]])$estimate, file, append = TRUE)
      write("---------END-STRUCTURE---------\n", file, append = TRUE)
    }
    write("~~~~~~~~~~~~~~~~~~~~~~~END-SORTING~~~~~~~~~~~~~~~~~~~~~~~~~~~~\n", file, append = TRUE)
    
  }
}


# The function get_pvalue is not finished, I didnt have the energy for it.

# get_pvalue <- function(df_list){
#   file <- "pvalue_res.txt"
  
  
  
#   write("PVALUE_RESULTS", file)
  
  
#   for(sorting in names(df_list)){
#     write("~~~~~~~~~~~~~~~~~~~~~~~START-SORTING~~~~~~~~~~~~~~~~~~~~~~~~~~~~", file, append = TRUE)
    
    
    
#     for(struct in names(df_list[[sorting]])){
      
#       if(struct == "ArrayList" || struct == "LinkedList"){
        
#         print(df_list[[sorting]][[struct]])
#       }
#       else{
        
#       }
#     }
#     print("hej")
#     write("____Lists____", file, append = TRUE)
#     #write(, file, append = TRUE)
#     write("____Sets____",file,append = TRUE)
#     #write(, file, append = TRUE)
    
    
#     write("~~~~~~~~~~~~~~~~~~~~~~~END-SORTING~~~~~~~~~~~~~~~~~~~~~~~~~~~~\n", file, append = TRUE)
    
#   }
  
  
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

