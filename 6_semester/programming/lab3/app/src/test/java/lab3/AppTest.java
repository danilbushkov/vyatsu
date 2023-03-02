/*
 * This Java source file was generated by the Gradle 'init' task.
 */
package lab3;

import org.junit.jupiter.api.Test;
import static org.junit.jupiter.api.Assertions.*;

class AppTest {
    @Test void isPrefix() {
        
        
        assertTrue(StringLibrary.isPrefix("", ""));
        assertTrue(StringLibrary.isPrefix("abcdef", ""));
        assertTrue(StringLibrary.isPrefix("abcdef", "a"));
        assertTrue(StringLibrary.isPrefix("abcdef", "ab"));
        assertTrue(StringLibrary.isPrefix("abcdef", "abcdef"));
        


        assertTrue(!StringLibrary.isPrefix("", "abcdef"));
        assertTrue(!StringLibrary.isPrefix("abcdef", "abcdefe"));
        assertTrue(!StringLibrary.isPrefix("abcdef", "c"));
        assertTrue(!StringLibrary.isPrefix("abcdef", "ac"));
        assertTrue(!StringLibrary.isPrefix("abcdef", "abcdee"));
    }

    @Test void isSuffix() {
        

        assertTrue(StringLibrary.isSuffix("", ""));
        assertTrue(StringLibrary.isSuffix("abcdef", ""));
        assertTrue(StringLibrary.isSuffix("abcdef", "f"));
        assertTrue(StringLibrary.isSuffix("abcdef", "def"));
        assertTrue(StringLibrary.isSuffix("abcdef", "abcdef"));
        


        assertTrue(!StringLibrary.isSuffix("", "abcdef"));
        assertTrue(!StringLibrary.isSuffix("abcdef", "abcdefe"));
        assertTrue(!StringLibrary.isSuffix("abcdef", "e"));
        assertTrue(!StringLibrary.isSuffix("abcdef", "fef"));
        assertTrue(!StringLibrary.isSuffix("abcdef", "ebcdef"));
    }


    @Test void isSubstring() {
        

        assertTrue(StringLibrary.isSubstring("", ""));
        assertTrue(StringLibrary.isSubstring("abcdef", "b"));
        assertTrue(StringLibrary.isSubstring("abcdef", "ef"));
        assertTrue(StringLibrary.isSubstring("abcdef", "bc"));
        assertTrue(StringLibrary.isSubstring("abcdef", "bcd"));
        assertTrue(StringLibrary.isSubstring("abcdef", "abcdef"));
        


        assertTrue(!StringLibrary.isSubstring("", "abcdef"));
        assertTrue(!StringLibrary.isSubstring("abcdef", "abcdefe"));
        assertTrue(!StringLibrary.isSubstring("abcdef", "ce"));
        assertTrue(!StringLibrary.isSubstring("abcdef", "fef"));
        assertTrue(!StringLibrary.isSubstring("abcdef", "abcdea"));
    }


    @Test void isSubsequence() {
        

        assertTrue(StringLibrary.isSubsequence("", ""));
        assertTrue(StringLibrary.isSubsequence("abcdef", "b"));
        assertTrue(StringLibrary.isSubsequence("abcdef", "af"));
        assertTrue(StringLibrary.isSubsequence("abcdef", "be"));
        assertTrue(StringLibrary.isSubsequence("abcdef", "ace"));
        assertTrue(StringLibrary.isSubsequence("abcdef", "abcdef"));
        


        assertTrue(!StringLibrary.isSubsequence("", "abcdef"));
        assertTrue(!StringLibrary.isSubsequence("abcdef", "afe"));
        assertTrue(!StringLibrary.isSubsequence("abcdef", "ba"));
        assertTrue(!StringLibrary.isSubsequence("abcdef", "ec"));
        assertTrue(!StringLibrary.isSubsequence("abcdef", "cbcdef"));
    }


}