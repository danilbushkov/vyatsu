package lab4;

import java.awt.event.ActionListener;
import java.util.ArrayList;
import java.awt.event.ActionEvent;
import java.util.function.BiPredicate;

public class Presenter {
    Window view;
    ArrayList<BiPredicate<String,String>> biPredicates;
    
    Presenter(Window window) {
        this.view = window;

        this.biPredicates = new ArrayList<BiPredicate<String,String>>();
        this.biPredicates.add(StringLibrary::isPrefix);
        this.biPredicates.add(StringLibrary::isSuffix);
        this.biPredicates.add(StringLibrary::isSubstring);
        this.biPredicates.add(StringLibrary::isSubsequence);
        

    }

    


    public ActionListener test() {
        return new ActionListener() {
            @Override
            public void actionPerformed(ActionEvent e) {
                if(view != null) {
                    String str = view.getFirstString();
                    String sub = view.getSecondString();
                    if(biPredicates
                        .get(view.getRadioNumber())
                        .test(str, sub)) {

                        view.setTextInAnswer("Answer: Yes");
                    } else {
                        view.setTextInAnswer("Answer: No");
                    }
                }
                
            }
        };
    }


    
}
