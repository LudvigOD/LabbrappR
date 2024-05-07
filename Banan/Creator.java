package Banan;

import java.io.*;
import java.sql.Array;
import java.util.*;

public class Creator {
    String pathName;
    String outPutName;
    int[] theInts;



    public Creator(String pathName, String outPutName) {
        this.pathName = pathName;
        this.outPutName = outPutName;
        this.theInts = new int[10000];


        try{
                BufferedReader reader = new BufferedReader(new FileReader(pathName));
                String line;

                int i = 0;

                while((line = reader.readLine()) != null){
                    theInts[i] = Integer.parseInt(line);
                    i++;
                }
                reader.close();
        }
        catch (IOException err){
            System.out.println("Det gick åt helvete: " + err);
        }
    }
    
}

   