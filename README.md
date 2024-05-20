#Teamwork makes the dream work!


#Litteratur LUBCAT

##Nyckelord: 
"time complexity"

##Sökningsresultat:
Binary Search Sort Algorithm -Yet Another Sorting Algorithm with Binary Search having O(nlogn) and O(n) time complexity

Exhaustive Analysis and Time Complexity Evaluation of Sorting Algorithms

Time and Space Complexity of Deterministic and Nondeterministic Decision Trees: Local Approach




















#RandonIntegerGernator

Randomeintegergenrator.java is only for creating data, dont download!
import java.io.BufferedWriter;
import java.io.FileWriter;
import java.io.IOException;
import java.util.Arrays;
import java.util.Random;

public class RandomIntegerGenerator {
    public static int[] generateRandomInts(int count, int min, int max){
        int[] randomIntegers = new int[count];
        Random random = new Random();
        for (int i = 0; i < count; i++) {
            randomIntegers[i] = random.nextInt(max - min + 1) + min;
        }
        return randomIntegers;
    }

    public static int[] generatePartiallyRandomInts(int count, int min, int max) {
        if (count <= 0 || min > max) {
            throw new IllegalArgumentException("Invalid parameters");
        }

        int[] partiallyOrderedIntegers = new int[count];
        Random random = new Random();

        // Generate blocks of 100 partially ordered integers
        for (int i = 0; i < count; i += 100) {
            int[] block = new int[100];
            for (int j = 0; j < 100; j++) {
                block[j] = random.nextInt(max - min + 1) + min;
            }
            Arrays.sort(block);
            System.arraycopy(block, 0, partiallyOrderedIntegers, i, 100);
        }

        return partiallyOrderedIntegers;
    }

    public static int[] generateUnsortedBlocksOfInts(int count){
        int[] unsortedIntegers = new int[count];
        Random random = new Random();

        for (int i = 0; i < count; i += 100) {
            int start = i + 1;
            int end = Math.min(i + 100, count);
            for (int j = start; j <= end; j++) {
                unsortedIntegers[j - 1] = random.nextInt(100) + i + 1;
            }
        }

        return unsortedIntegers;
    }

    public static void main(String[] args) {
        int[] randomIntegers = generateRandomInts(10000, 1, 10000);
        int[] partiallyOrderedIntegers = generatePartiallyRandomInts(10000, 1, 10000);
        int[] unsortedIntegers = generateUnsortedBlocksOfInts(10000);

        try (BufferedWriter writer = new BufferedWriter(new FileWriter("random_integers.txt"))) {
            for (int i = 0; i < randomIntegers.length; i++) {
                writer.write(String.valueOf(randomIntegers[i]));
                writer.newLine();
            }
            System.out.println("Random integers written to file successfully.");
        } catch (IOException e) {
            System.err.println("An error occurred while writing to the file: " + e.getMessage());
        }

        try (BufferedWriter writer = new BufferedWriter(new FileWriter("partially_ordered_integers.txt"))) {
            for (int i = 0; i < partiallyOrderedIntegers.length; i++) {
                writer.write(String.valueOf(partiallyOrderedIntegers[i]));
                writer.newLine();
            }
            System.out.println("Partially ordered integers written to file successfully.");
        } catch (IOException e) {
            System.err.println("An error occurred while writing to the file: " + e.getMessage());
        }

        try (BufferedWriter writer = new BufferedWriter(new FileWriter("unsorted_integers.txt"))) {
            for (int i = 0; i < unsortedIntegers.length; i++) {
                writer.write(String.valueOf(unsortedIntegers[i]));
                writer.newLine();
            }
            System.out.println("Unsorted integers written to file successfully.");
        } catch (IOException e) {
            System.err.println("An error occurred while writing to the file: " + e.getMessage());
        }
    }
}

Kopiera den här main metoden och runna med argument 100. package Banan;
import java.io.BufferedReader;
import java.io.BufferedWriter;
import java.io.FileReader;
import java.io.FileWriter;
import java.io.IOException;

public class Main {
    public static void main(String[] args) {
        runTestsAndGatherResults(100);
    }

    public static void runTestsAndGatherResults(int iterations) {
        try {
            BufferedWriter writer = new BufferedWriter(new FileWriter("all_results.txt"));

            for (int i = 0; i < iterations; i++) {
                TestList t = new TestList(10000);
                TestSet t_2 = new TestSet(10000);
                t.testLists();
                t_2.testSets();

                // Write the results of each iteration to the file
                writer.write("Iteration " + (i + 1) + ":\n");

                // Append the results from TestList
                writer.write("Results from TestList:\n");
                 writer.write("Input resultOsorteradIBlock:\n");
                appendResultsToFile(writer, "resultOsorteradIBlock.txt");
                 writer.write("Input resultSorteradIBlock:\n");
                appendResultsToFile(writer, "resultSorteradIBlock.txt");
                 writer.write("Input resultOsorterad:\n");
                appendResultsToFile(writer, "resultOsorterad.txt");

                // Append the results from TestSet
                writer.write("Results from TestSet:\n");
                writer.write("Input resultOsorteradIBlockSets:\n");
                appendResultsToFile(writer, "resultOsorteradIBlockSets.txt");
                writer.write("Input resultSorteradIBlockSets:\n");
                appendResultsToFile(writer, "resultSorteradIBlockSets.txt");
                writer.write("Input resultOsorteradSets:\n");
                appendResultsToFile(writer, "resultOsorteradSets.txt");

                writer.newLine(); // Add a newline for clarity between iterations
            }

            writer.close();
        } catch (IOException e) {
            e.printStackTrace();
        }
    }

    public static void appendResultsToFile(BufferedWriter writer, String fileName) throws IOException {
        BufferedReader reader = new BufferedReader(new FileReader(fileName));
        String line;
        while ((line = reader.readLine()) != null) {
            writer.write(line);
            writer.newLine();

            
        }
        reader.close();
    }
}
