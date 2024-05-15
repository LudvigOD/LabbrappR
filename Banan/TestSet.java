package Banan;

import java.io.BufferedWriter;
import java.io.FileWriter;
import java.io.IOException;
import java.util.ArrayList;
import java.util.HashSet;
import java.util.LinkedList;
import java.util.List;
import java.util.Random;
import java.util.TreeSet;
import java.io.File;

public class TestSet {
    int reps;

    public TestSet(int reps){
        this.reps = reps;
    }

    public void testSets(){
        Creator osorteradIBlock = new Creator("Banan/Osorterad_I_Block.txt", "resultOsorteradIBlockSets");
        Creator sorteradHundraTal = new Creator("Banan/Sorterad_I_Block.txt", "resultSorteradIBlockSets");
        Creator osorterad = new Creator("Banan/Osorterad.txt", "resultOsorteradSets");

        runAndWriteTestResults(osorteradIBlock);
        runAndWriteTestResults(sorteradHundraTal);
        runAndWriteTestResults(osorterad);
    }
    private void runAndWriteTestResults(Creator c){
        try{
            BufferedWriter writerHash = new BufferedWriter(new FileWriter(new File("./Results", c.outPutName + "HashMap.txt")));
            BufferedWriter writerTree = new BufferedWriter(new FileWriter(new File("./Results", c.outPutName + "TreeMap.txt")));

            double[] result1 = timeAddAll(c, reps);
            double[] result3 = timeContains(c, reps);
            double[] result5 = timeRemove(c, reps);
            double[] result7 = timeSize(c, reps);

            writerTree.write("TreeSet");
            writerTree.newLine();
            writerTree.write("timeAddAll " + result1[0]); 
            writerTree.newLine();
            writerTree.write("timeContains " + result3[0]);
            writerTree.newLine();
            writerTree.write("timeRemove " + result5[0]);
            writerTree.newLine();
            writerTree.write("timeSize " + result7[0]);
            writerHash.newLine();
            
            writerHash.write("HashSet");
            writerHash.newLine();
            writerHash.write("timeAddAll " + result1[1]); 
            writerHash.newLine();
            writerHash.write("timeContains " + result3[1]);
            writerHash.newLine();
            writerHash.write("timeRemove " + result5[1]);
            writerHash.newLine();
            writerHash.write("timeSize " + result7[1]);
    

            writerHash.close();
            writerTree.close();
        } catch (IOException e) {
            e.printStackTrace();
        }
    }


    public double[] timeAddAll(Creator c, int iterations) {
        TreeSet<Integer> treeSet = new TreeSet<>();
        HashSet<Integer> hashSet = new HashSet<>();

        double totalTreeSetTime;
        double totalHashSetTime;

        double t0 = System.nanoTime();
        for (int iter = 0; iter < iterations; iter++) {
            for (int numb : c.theInts) {
                treeSet.add(numb);
            }
            treeSet.clear();
        }
        totalTreeSetTime = (System.nanoTime() - t0);

        double t0_2 = System.nanoTime();
        for (int iter = 0; iter < iterations; iter++){
            
            for (int numb : c.theInts) {
                hashSet.add(numb);
            }
            
            // Clear lists for the next iteration
            
            hashSet.clear();
        }
        totalHashSetTime = (System.nanoTime() - t0_2);



        double[] result = new double[2];
        result[0] = totalTreeSetTime;
        result[1] = totalHashSetTime;
        return result;
    }



    public double[] timeContains(Creator c, int iterations) {
        TreeSet<Integer> treeSet = new TreeSet<>();
        HashSet<Integer> hashSet = new HashSet<>();

        for (int numb : c.theInts) {
            treeSet.add(numb);
        }
        for (int numb : c.theInts) {
            hashSet.add(numb);
        }



        double totalTreeSetTime;
        double totalHashSetTime;

        double t0 = System.nanoTime();
        for (int iter = 0; iter < iterations; iter++) {
            treeSet.contains(c.theInts[iter]);
        }
       
        totalTreeSetTime = (System.nanoTime() - t0);

        double t0_2 = System.nanoTime();
        for (int iter = 0; iter < iterations; iter++) {
            hashSet.contains(c.theInts[iter]);
        }
       
        totalHashSetTime = (System.nanoTime() - t0_2);

        double[] result = new double[2];
        result[0] = totalTreeSetTime;
        result[1] = totalHashSetTime;
        return result;
    }


    public double[] timeSize(Creator c, int iterations) {
        TreeSet<Integer> treeSet = new TreeSet<>();
        HashSet<Integer> hashSet = new HashSet<>();

        for (int numb : c.theInts) {
            treeSet.add(numb);
        }
        for (int numb : c.theInts) {
            hashSet.add(numb);
        }

        double totalTreeSetTime;
        double totalHashSetTime;

        double t0 = System.nanoTime();
        for (int iter = 0; iter < iterations; iter++) {
            int hej = treeSet.size();
        }
        totalTreeSetTime = (System.nanoTime() - t0);

        double t0_2 = System.nanoTime();
        for (int iter = 0; iter < iterations; iter++) {
            int tja = hashSet.size();
        }
        totalHashSetTime = (System.nanoTime() - t0_2);


        double[] result = new double[2];
        result[0] = totalTreeSetTime;
        result[1] = totalHashSetTime;
        return result;
    }

    public double[] timeRemove(Creator c, int iterations) {
        TreeSet<Integer> treeSet = new TreeSet<>();
        HashSet<Integer> hashSet = new HashSet<>();

        for (int numb : c.theInts) {
            treeSet.add(numb);
        }
        for (int numb : c.theInts) {
            hashSet.add(numb);
        }

        double totalTreeSetTime;
        double totalHashSetTime;

        double t0 = System.nanoTime();
        for (int iter = 0; iter < iterations; iter++) {
            TreeSet<Integer> copyTreeSet = new TreeSet<>(treeSet);
            for (int i = 0; i < 10000; i++) {
                copyTreeSet.remove(c.theInts[i]);
            }
        }
        totalTreeSetTime = (System.nanoTime() - t0);

        double t0_2 = System.nanoTime();
        for (int iter = 0; iter < iterations; iter++) {
            HashSet<Integer> copyHashSet = new HashSet<>(hashSet);
            for (int i = 0; i < 10000; i++) {
                copyHashSet.remove(c.theInts[i]);
            }  
        }
        totalHashSetTime = (System.nanoTime() - t0_2);

        double[] result = new double[2];
        result[0] = totalTreeSetTime;
        result[1] = totalHashSetTime;
        return result;
    }
}
