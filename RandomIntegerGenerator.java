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
