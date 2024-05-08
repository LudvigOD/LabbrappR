package Banan;

import java.io.BufferedWriter;
import java.io.FileWriter;
import java.io.IOException;
import java.text.DecimalFormat;
import java.util.ArrayList;
import java.util.LinkedList;
import java.util.List;
import java.util.Random;

import Banan.Creator;
public class TestList {
    int reps;
    public TestList(int reps){
        this.reps = reps;
    }

    public void testLists(){
        Creator osorteradIBlock = new Creator("Banan/Osorterad_I_Block.txt", "resultOsorteradIBlock");
        Creator sorteradHundraTal = new Creator("Banan/Sorterad_I_Block.txt", "resultSorteradIBlock");
        Creator osorterad = new Creator("Banan/Osorterad.txt", "resultOsorterad");

        runAndWriteTestResults(osorteradIBlock);
        runAndWriteTestResults(sorteradHundraTal);
        runAndWriteTestResults(osorterad);
    }
    private void runAndWriteTestResults(Creator c) {
        try {
            BufferedWriter writer = new BufferedWriter(new FileWriter(c.outPutName + ".txt"));

            
            double[] result1 = timeAddAll(c, reps);
            double[] result2 = timeSort(c, reps);
            double[] result3 = timeContains(c, reps);
            double[] result4 = timeGet(c, reps);
            double[] result5 = timeRemove(c, reps);
            double[] result7 = timeSize(c, reps);

            writer.write("LinkedList ");
            writer.newLine();
            writer.write("timeAddAll " + result1[0]); 
            writer.newLine();
            writer.write("timeSort " + result2[0]);
            writer.newLine();
            writer.write("timeContains " + result3[0]);
            writer.newLine();
            writer.write("timeGet " + result4[0]);
            writer.newLine();
            writer.write("timeRemove " + result5[0]);
            writer.newLine();
            writer.write("timeSize " + result7[0]);

            writer.newLine();
            writer.write("ArrayList ");
            writer.newLine();
            writer.write("timeAddAll " + result1[1]); 
            writer.newLine();
            writer.write("timeSort " + result2[1]);
            writer.newLine();
            writer.write("timeContains " + result3[1]);
            writer.newLine();
            writer.write("timeGet " + result4[1]);
            writer.newLine();
            writer.write("timeRemove " + result5[1]);
            writer.newLine();
            writer.write("timeSize " + result7[1]);
        

            writer.close();
        } catch (IOException e) {
            e.printStackTrace();
        }
    }


  public double[] timeAddAll(Creator c, int iterations) {
    List<Integer> linkedList = new LinkedList<>();
    List<Integer> arrayList = new ArrayList<>();

    double totalLinkedListTime;
    double totalArrayListTime;
    double t0 = System.nanoTime();
    for (int iter = 0; iter < iterations; iter++) {
        for (int numb : c.theInts) {
            linkedList.add(numb);
        }
        linkedList.clear();
        
    }
    totalLinkedListTime = (System.nanoTime() - t0);
    double t0_2 = System.nanoTime();
    for(int iter = 0; iter < iterations; iter++){
        for (int numb : c.theInts) {
            arrayList.add(numb);
        }
        arrayList.clear();
    }
    totalArrayListTime = (System.nanoTime() - t0_2);

   

    double[] result = new double[2];
    result[0] = totalLinkedListTime;
    result[1] = totalArrayListTime;
    return result;
}

public double[] timeSort(Creator c, int iterations) {
    List<Integer> linkedList = new LinkedList<>();
    List<Integer> arrayList = new ArrayList<>();

    for (int numb : c.theInts) {
            linkedList.add(numb);
        }
    for (int numb : c.theInts) {
            arrayList.add(numb);
    }

    double totalLinkedListTime;
    double totalArrayListTime;

    double t0 = System.nanoTime();
    for (int iter = 0; iter < iterations; iter++) {
        List<Integer> copyLinkedList = new LinkedList<>(linkedList);
        copyLinkedList.sort((e1, e2) -> e1 - e2);
    }
    totalLinkedListTime = (System.nanoTime() - t0);


    double t0_2 = System.nanoTime();
    for (int iter = 0; iter < iterations; iter++){
        List<Integer> copyArrayList = new ArrayList<>(arrayList);
        copyArrayList.sort((e1, e2) -> e1 - e2);
        
    }
    totalArrayListTime = (System.nanoTime() - t0_2);

    double[] result = new double[2];
    result[0] = totalLinkedListTime;
    result[1] = totalArrayListTime;
    return result;
}


    public double[] timeContains(Creator c, int iterations) {
    List<Integer> linkedList = new LinkedList<>();
    List<Integer> arrayList = new ArrayList<>();

    for (int numb : c.theInts) {
        linkedList.add(numb);
    }
    for (int numb : c.theInts) {
        arrayList.add(numb);
    }

    double totalLinkedListTime;
    double totalArrayListTime;

    double t0 = System.nanoTime();
  
    for (int iter = 0; iter < iterations; iter++){
        linkedList.contains(c.theInts[iter]);
    }

    totalLinkedListTime = (System.nanoTime() - t0);

    double t0_2 = System.nanoTime();
  
    for (int iter = 0; iter < iterations; iter++){
        arrayList.contains(c.theInts[iter]); 
    }
    
    totalArrayListTime = (System.nanoTime() - t0_2);

    double[] result = new double[2];
    result[0] = totalLinkedListTime;
    result[1] = totalArrayListTime;
    return result;
    } 

    public double[] timeGet(Creator c, int iterations) {
        List<Integer> linkedList = new LinkedList<>();
        List<Integer> arrayList = new ArrayList<>();

        for (int numb : c.theInts) {
            linkedList.add(numb);
        }
        for (int numb : c.theInts) {
            arrayList.add(numb);
        }

        double totalLinkedListTime;
        double totalArrayListTime;

        double t0 = System.nanoTime();
        
        for (int iter = 0; iter < iterations; iter++) {
            linkedList.get(c.theInts[iter] - 1);
        }
       
        totalLinkedListTime = (System.nanoTime() - t0);

        double t0_2 = System.nanoTime();
        for (int iter = 0; iter < iterations; iter++){
            arrayList.get(c.theInts[iter] - 1);   
        }
        
        totalArrayListTime = (System.nanoTime() - t0_2);
        

        double[] result = new double[2];
        result[0] = totalLinkedListTime;
        result[1] = totalArrayListTime;
        return result;
    } 

    public double[] timeRemove(Creator c, int iterations) {
        List<Integer> linkedList = new LinkedList<>();
        List<Integer> arrayList = new ArrayList<>();

        for (int numb : c.theInts) {
            linkedList.add(numb);
        }
        for (int numb : c.theInts) {
            arrayList.add(numb);
        }

        double totalLinkedListTime;
        double totalArrayListTime;

        double t0 = System.nanoTime();
        for (int iter = 0; iter < iterations; iter++) {
            List<Integer> copyLinkedList = new LinkedList<>(linkedList);
            for (int i = 0; i < 10000; i++) {
                copyLinkedList.remove((Object) c.theInts[i]);
            }

        }
        totalLinkedListTime = (System.nanoTime() - t0);

        double t0_2 = System.nanoTime();
        for (int iter = 0; iter < iterations; iter++) {
            List<Integer> copyArrayList = new ArrayList<>(arrayList);
            for (int i = 0; i < 10000; i++) {
                copyArrayList.remove((Object) c.theInts[i]);
            }
        }
        totalArrayListTime = (System.nanoTime() - t0_2);

        double[] result = new double[2];
        result[0] = totalLinkedListTime;
        result[1] = totalArrayListTime;
        return result;
    }

    public double[] timeSize(Creator c, int iterations) {
        List<Integer> linkedList = new LinkedList<>();
        List<Integer> arrayList = new ArrayList<>();

        for (int numb : c.theInts) {
            linkedList.add(numb);
        }
        for (int numb : c.theInts) {
            arrayList.add(numb);
        }
        double totalLinkedListTime;
        double totalArrayListTime;

        double t0 = System.nanoTime();

       
        for (int iter = 0; iter < iterations; iter++){
            int hej = linkedList.size();    
        }   

    
        totalLinkedListTime = (System.nanoTime() - t0);

        double t0_2 = System.nanoTime(); 

        for (int iter = 0; iter < iterations; iter++){
            int tja = arrayList.size();
        }
        totalArrayListTime = (System.nanoTime() - t0_2);

       

        double[] result = new double[2];
        result[0] = totalLinkedListTime;
        result[1] = totalArrayListTime;
        return result;
    }

}