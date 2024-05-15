import java.io.BufferedWriter;
import java.io.FileWriter;
import java.io.IOException;

import Banan.TestList;
import Banan.TestSet;

public class Main {
    public static void main(String[] args){
        TestList t = new TestList(10000);
        TestSet t_2 = new TestSet(10000);
        t.testLists();
        t_2.testSets();
    }
}
