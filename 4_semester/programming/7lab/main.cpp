#include <iostream>
#include <boost/thread/thread.hpp>
#include <boost/interprocess/sync/interprocess_semaphore.hpp>
#include <boost/chrono.hpp>
#include <string>




#define NUMBER_PHILOSOPHERS 5
#define THINK 0
#define HUNGRY 1
#define EAT 2


using namespace std;




class Philosopher{
  public:
    Philosopher(){
        action = HUNGRY;
        countDinner = 0;
        b=0;
    }
    Philosopher(int number){
      action = HUNGRY;
      this->number = number;
      countDinner = 0;
    }
    void setAction(int action){
      this->action=action;
      if(action==EAT){
          countDinner++;
      }
    }
    char getPrintAction(){
      switch (action)
      {
      case THINK:
        return 'T';
      case HUNGRY:
        return 'H';
      case EAT:
        return 'E';
      }
      return 'A';
    }
    int getAction(){
        return action;
    }
    void setNumber(int number){
      this->number = number;
    }
    int getNumber(){
      return number;
    }
    int getCountDinner(){
        return countDinner;
    }
    void block(){
        this->b = 1;
    }
    void unblock(){
        this->b = 0;
    }
    int checkBlock(){
        return b;
    }
  private:
    int action;
    int number;
    int countDinner;
    int b;
};


class Table{
  public:
    static void initTable(){
        for(int i=0; i<NUMBER_PHILOSOPHERS; i++){
            philosophers[i]=Philosopher(i);
            
        }
    };
    static void action(Philosopher *philosopher);
    static void eat(Philosopher *philosopher);
    static void think(Philosopher *philosopher);
    static void printActionPhilosophers(Philosopher *philosopher);
    static void printNamesPhilosophers();
    static void printCountDinner();
    
    
    static void dinner();

    static int count;
    static int times[NUMBER_PHILOSOPHERS];
    static Philosopher philosophers[NUMBER_PHILOSOPHERS];
    static boost::thread threads[NUMBER_PHILOSOPHERS];
    static boost::interprocess::interprocess_semaphore printSemaphore;
    static boost::interprocess::interprocess_semaphore semaphores[NUMBER_PHILOSOPHERS];
};
int Table::count=0;
int Table::times[NUMBER_PHILOSOPHERS]={
        20, 50, 60, 20, 80
    };
boost::interprocess::interprocess_semaphore Table::printSemaphore=
    boost::interprocess::interprocess_semaphore(1);
Philosopher Table::philosophers[NUMBER_PHILOSOPHERS];
boost::thread Table::threads[NUMBER_PHILOSOPHERS];
boost::interprocess::interprocess_semaphore Table::semaphores[NUMBER_PHILOSOPHERS]={
        boost::interprocess::interprocess_semaphore(1),
        boost::interprocess::interprocess_semaphore(1),
        boost::interprocess::interprocess_semaphore(1),
        boost::interprocess::interprocess_semaphore(1),
        boost::interprocess::interprocess_semaphore(1)
    };

void Table::action(Philosopher *philosopher){
    while(count<1000){
        eat(philosopher);
        think(philosopher);
    }
}



void Table::eat(Philosopher *philosopher){
    int number=philosopher->getNumber();

    boost::this_thread::sleep_for(boost::chrono::milliseconds(times[number])); 

    semaphores[number].wait();
    semaphores[(number+1)%NUMBER_PHILOSOPHERS].wait();
    

    philosopher->setAction(EAT);
    
    printActionPhilosophers(philosopher);
    
    boost::this_thread::sleep_for(boost::chrono::milliseconds(10));  
    philosopher->setAction(THINK);

    semaphores[number].post();
    semaphores[(number+1)%NUMBER_PHILOSOPHERS].post();

}


void Table::think(Philosopher *philosopher){
    //boost::this_thread::sleep_for(boost::chrono::milliseconds(200));  
    philosopher->setAction(HUNGRY);
}   


void Table::printActionPhilosophers(Philosopher *philosopher){
    printSemaphore.wait();
    cout << philosopher->getNumber() <<": "; 
    for(int i=0; i<NUMBER_PHILOSOPHERS; i++){
        if(philosophers[i].getPrintAction()=='E'){
            string s(1,philosophers[i].getPrintAction());
            cout << "\033[1;31m"+s+"\033[0m ";
        }else{
            cout << philosophers[i].getPrintAction() <<' '; 
        }
         
    }
    cout<<' '<< count++ <<'\n';
    printSemaphore.post();
};

void Table::printNamesPhilosophers(){
  cout<<"Philosophers: \n";
  cout<<"   ";
  for(int i=0; i<NUMBER_PHILOSOPHERS; i++){
      cout << i <<' ';
      
  }
  cout<<'\n';
  cout<<"---------------"<<'\n';
}

void Table::printCountDinner(){
    cout <<"Count Dinner: \n";
    for(int i=0; i<NUMBER_PHILOSOPHERS; i++){
        cout << philosophers[i].getCountDinner() <<' ';
    }
    cout <<"\n";
}



void Table::dinner(){
    
    initTable();
    printNamesPhilosophers();
   
    
    
    for(int i=0; i<NUMBER_PHILOSOPHERS; i++){
        threads[i]=boost::thread(&action, &philosophers[i]);
    }
    for(int i=0; i<NUMBER_PHILOSOPHERS; i++){
        threads[i].join();
    }

}




int main()
{
    Table::initTable();
    Table::dinner();
    Table::printCountDinner();
    
    return 0;
}