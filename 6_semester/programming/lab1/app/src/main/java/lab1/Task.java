package lab1;



public class Task {

    public static boolean isPrefix(String str, String sub) {
        if(str.length() < sub.length()) {
            return false;
        }
        for(int i = 0; i < sub.length(); i++) {
            if(str.charAt(i)!=sub.charAt(i)) return false;
        }
        
        
        return true;
    }

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