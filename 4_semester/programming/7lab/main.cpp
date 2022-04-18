#include <iostream>
#include <boost/thread/thread.hpp>
#include <boost/interprocess/sync/interprocess_semaphore.hpp>
#include <boost/chrono.hpp>
#include <cstdlib>
#include <ctime>
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
  private:
    int action;
    int number;
    int countDinner;
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
    static Philosopher philosophers[NUMBER_PHILOSOPHERS];
    static boost::thread threads[NUMBER_PHILOSOPHERS];
    static boost::interprocess::interprocess_semaphore tableSemaphore;
    static boost::interprocess::interprocess_semaphore printSemaphore;
    static boost::interprocess::interprocess_semaphore semaphores[NUMBER_PHILOSOPHERS];
};
int Table::count=0;
boost::interprocess::interprocess_semaphore Table::tableSemaphore=
    boost::interprocess::interprocess_semaphore(1);
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
    while(count<100000){
        //cout<<philosopher->getNumber()<<'\n';
        if(philosopher->getAction()==HUNGRY){
            tableSemaphore.wait();
            eat(philosopher);
            tableSemaphore.post();
        }else{
            think(philosopher);
        }
    }
}
void Table::eat(Philosopher *philosopher){
    int number=philosopher->getNumber();
        if(philosophers[number+1].getAction()!=EAT &&
            philosophers[number-1].getAction()!=EAT){
            semaphores[number].wait();
            semaphores[(number+1)%NUMBER_PHILOSOPHERS].wait();

            philosopher->setAction(EAT);
            printActionPhilosophers(philosopher);
            //int n = rand() % 5;
            //boost::this_thread::sleep_for(boost::chrono::milliseconds(100));  
            philosopher->setAction(THINK);

            semaphores[number].post();
            semaphores[(number+1)%NUMBER_PHILOSOPHERS].post();
    }
}


void Table::think(Philosopher *philosopher){
    //int n = rand() % 5;
    boost::this_thread::sleep_for(boost::chrono::milliseconds(200));  
    philosopher->setAction(HUNGRY);
}   


void Table::printActionPhilosophers(Philosopher *philosopher){
    printSemaphore.wait();
    cout << philosopher->getNumber() <<": "; 
    for(int i=0; i<NUMBER_PHILOSOPHERS; i++){
        if(i==philosopher->getNumber()){
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
    srand(time(NULL));
    Table::initTable();
    Table::dinner();
    Table::printCountDinner();
    
  return 0;
}