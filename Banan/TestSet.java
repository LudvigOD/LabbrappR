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
    private void runAndWriteTestResults(Creator c) {
        try {
            BufferedWriter writer = new BufferedWriter(new FileWriter(c.outPutName + ".txt"));

            // Test timeAddAll
            float[] result1 = timeAddAll(c, reps);
            writer.write("Time taken for TreeSet addAll  " + result1[0] + " nanoseconds");
            writer.newLine();
            writer.write("Time taken for HashSet addAll " + result1[1] + " nanoseconds");
            writer.newLine();

            // Test timeContains
            float[] result3 = timeContains(c, reps*100);
            writer.write("Time taken for TreeSet contains " + result3[0] + " nanoseconds");
            writer.newLine();
            writer.write("Time taken for HashSet contains " + result3[1] + " nanoseconds");
            writer.newLine();

            // Test timeRemove
            float[] result5 = timeRemove(c, reps);
            writer.write("Time taken for TreeSet remove  " + result5[0] + " nanoseconds");
            writer.newLine();
            writer.write("Time taken for HashSet remove  " + result5[1] + " nanoseconds");
            writer.newLine();

            float[] result7 = timeSize(c, reps*100);
            writer.write("Time taken for TreeSet size  " + result7[0] + " nanoseconds");
            writer.newLine();
            writer.write("Time taken for HashSet size  " + result7[1] + " nanoseconds");
            writer.newLine();

            writer.close();
        } catch (IOException e) {
            e.printStackTrace();
        }
    }


    public float[] timeAddAll(Creator c, int iterations) {
        TreeSet<Integer> treeSet = new TreeSet<>();
        HashSet<Integer> hashSet = new HashSet<>();

        float totalLinkedListTime = 0;
        float totalArrayListTime = 0;

        for (int iter = 0; iter < iterations; iter++) {
            float t0 = System.nanoTime();
            for (int numb : c.theInts) {
                treeSet.add(numb);
            }
            totalLinkedListTime += (System.nanoTime() - t0);

            float t0_2 = System.nanoTime();
            for (int numb : c.theInts) {
                hashSet.add(numb);
            }
            totalArrayListTime += (System.nanoTime() - t0_2);

            // Clear lists for the next iteration
            treeSet.clear();
            hashSet.clear();
        }


        float[] result = new float[2];
        result[0] = totalLinkedListTime;
        result[1] = totalArrayListTime;
        return result;
    }



    public float[] timeContains(Creator c, int iterations) {
        TreeSet<Integer> treeSet = new TreeSet<>();
        HashSet<Integer> hashSet = new HashSet<>();

        for (int numb : c.theInts) {
            treeSet.add(numb);
        }
        for (int numb : c.theInts) {
            hashSet.add(numb);
        }

        Random rand = new Random();
        int r;

        float totalLinkedListTime = 0;
        float totalArrayListTime = 0;

        for (int iter = 0; iter < iterations; iter++) {
            r = rand.nextInt(9999) + 1;
            // Measure time for LinkedList contains
            float t0 = System.nanoTime();
            treeSet.contains(r);
            totalLinkedListTime += (System.nanoTime() - t0);

            // Measure time for ArrayList contains
            float t0_2 = System.nanoTime();
            hashSet.contains(r);
            totalArrayListTime += (System.nanoTime() - t0_2);
        }

        float[] result = new float[2];
        result[0] = totalLinkedListTime;
        result[1] = totalArrayListTime;
        return result;
    }


    public float[] timeSize(Creator c, int iterations) {
        TreeSet<Integer> treeSet = new TreeSet<>();
        HashSet<Integer> hashSet = new HashSet<>();

        for (int numb : c.theInts) {
            treeSet.add(numb);
        }
        for (int numb : c.theInts) {
            hashSet.add(numb);
        }

        float totalTreeSetTime = 0;
        float totalHashSetTime = 0;

        for (int iter = 0; iter < iterations; iter++) {
            // Measure time for LinkedList remove
            float t0 = System.nanoTime();
            int hej = treeSet.size();
            totalTreeSetTime += (System.nanoTime() - t0);

            // Measure time for ArrayList remove
            float t0_2 = System.nanoTime();
            int tja = hashSet.size();
            totalHashSetTime += (System.nanoTime() - t0_2);
        }


        float[] result = new float[2];
        result[0] = totalTreeSetTime;
        result[1] = totalHashSetTime;
        return result;
    }

    public float[] timeRemove(Creator c, int iterations) {
        TreeSet<Integer> treeSet = new TreeSet<>();
        HashSet<Integer> hashSet = new HashSet<>();

        for (int numb : c.theInts) {
            treeSet.add(numb);
        }
        for (int numb : c.theInts) {
            hashSet.add(numb);
        }

        float totalTreeSetTime = 0;
        float totalHashSetTime = 0;

        for (int iter = 0; iter < iterations; iter++) {
            TreeSet<Integer> copyTreeSet = new TreeSet<>(treeSet);
            HashSet<Integer> copyHashSet = new HashSet<>(hashSet);
            // Measure time for LinkedList remove
            float t0 = System.nanoTime();
            for (int i = 0; i < 10000; i++) {
                copyTreeSet.remove(c.theInts[i]);
            }
            totalTreeSetTime += (System.nanoTime() - t0);

            // Measure time for ArrayList remove
            float t0_2 = System.nanoTime();
            for (int i = 0; i < 10000; i++) {
                copyHashSet.remove(c.theInts[i]);
            }
            totalHashSetTime += (System.nanoTime() - t0_2);
        }

        float[] result = new float[2];
        result[0] = totalTreeSetTime;
        result[1] = totalHashSetTime;
        return result;
    }
}
