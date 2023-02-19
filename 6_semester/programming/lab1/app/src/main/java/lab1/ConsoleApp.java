package lab1;


import java.util.ArrayList;
import java.util.Scanner;
import java.util.function.BiPredicate;

public class ConsoleApp {

    ArrayList<BiPredicate<String,String>> handlers;
    ArrayList<String> messages; 

    ConsoleApp() {
        this.handlers = new ArrayList<BiPredicate<String,String>>();
        this.messages = new ArrayList<String>();

        handlers.add(Task::isPrefix);
        messages.add("Second string is prefix: ");

        handlers.add(Task::isSuffix);
        messages.add("Second string is suffix: ");

        handlers.add(Task::isSubstring);
        messages.add("Second string is substring: ");

        handlers.add(Task::isSubsequence);
        messages.add("Second string is subsequence: ");

    }
    private void info() {
        System.out.println("Menu items: ");
        System.out.println("1 - isPrefix");
        System.out.println("2 - isSuffix");
        System.out.println("3 - isSubstring");
        System.out.println("4 - isSubsequence");
        System.out.println("5 - exit");
        System.out.println();

    }

    private int inputMenuItem(Scanner in) {
        
        
        
        int num = 0;
        boolean input = true;
        while(input) {
            System.out.print("Enter menu item: ");
            String str = in.nextLine().trim();
            try {
                num = Integer.parseInt(str);

                if(num > 0 && num < 6) {
                    input = false;
                } else {
                    System.out.println("Error! Item must be number between 1 and 5 inclusive.");
                }
            }
            catch (NumberFormatException e) {
                System.out.println("Error! Is not number!");
            }
        }
        




        return num;
    }

    

    private void handler(Scanner in, BiPredicate<String,String> stringHendler, String message) {
        

        System.out.print("Enter a first string: ");
        String str1 = in.nextLine().trim();;

        System.out.print("Enter a second string: ");
        String str2 = in.nextLine().trim();;


        System.out.print(message);
        if(stringHendler.test(str1, str2)) {
            System.out.println("Yes.");
        } else {
            System.out.println("No.");
        }

        System.out.println("Press Enter...");
        in.nextLine();

        System.out.println();

    }



    public void run() {
        Scanner in = new Scanner(System.in);
        
        boolean run = true;
        do {
            this.info();
            int menuNum = this.inputMenuItem(in);
            if(menuNum == 5) {
                run = false;
            } else {
                this.handler(
                    in,
                    this.handlers.get(menuNum-1), 
                    this.messages.get(menuNum-1)
                );
            }


        } while(run);
        
        
        System.out.println("Exit.");

        in.close();
    }





}