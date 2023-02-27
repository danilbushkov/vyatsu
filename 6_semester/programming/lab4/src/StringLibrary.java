package lab4;


/**
    * Class for working with strings.
    * @author Danil Bushkov
    * @version 1
    
*/
public class StringLibrary {

    /**
        * Check if the second string is a prefix of the first.
        * @param str First string
        * @param sub Second string
        * @return Returns a boolean value indicating whether the second string is a prefix of the first
    */
    public static boolean isPrefix(String str, String sub) {
        if(str.length() < sub.length()) {
            return false;
        }
        for(int i = 0; i < sub.length(); i++) {
            if(str.charAt(i)!=sub.charAt(i)) return false;
        }
        
        
        return true;
    }

    /**
        * Check if the second string is a suffix of the first.
        * @param str First string
        * @param sub Second string
        * @return Returns a boolean value indicating whether the second string is a suffix of the first
    */
    public static boolean isSuffix(String str, String sub) {
        int n = str.length();
        int m = sub.length();
        if(n < m) {
            return false;
        }

        int a = n-m;
        for(int i = n-1; i > a-1; i--){
            if(str.charAt(i) != sub.charAt(i-a)) return false;
        }
        
        
        return true;
    }

    /**
        * Check if the second string is a substring of the first.
        * @param str First string
        * @param sub Second string
        * @return Returns a boolean value indicating whether the second string is a substring of the first
    */
    public static boolean isSubstring(String str, String sub) {
        int n = str.length();
        int m = sub.length();
        if(n < m) {
            return false;
        }
        if(m == 0) {
            return true;
        }

        for(int i = 0; i <= n-m; i++) {
            if(str.charAt(i) == sub.charAt(0)) {
                int j = 1;
                while(j < m && str.charAt(i+j) == sub.charAt(j)) j++;
                if(j == m) return true;
                
            } 
        }

        return false;
    }

    /**
        * Check if the second string is a subsequence of the first.
        * @param str First string
        * @param sub Second string
        * @return Returns a boolean value indicating whether the second string is a subsequence of the first
    */
    public static boolean isSubsequence(String str, String sub) {
        int n = str.length();
        int m = sub.length();
        
        if(n < m) {
            return false;
        }
        if(m == 0) {
            return true;
        }


        int i = 0;
        int j = 0;
        while(i < n-m+j+1) {

            if(str.charAt(i) == sub.charAt(j)) {
                j++;
                if(j == m) return true;
            }

            i++;
        }


        return false;
    }


}