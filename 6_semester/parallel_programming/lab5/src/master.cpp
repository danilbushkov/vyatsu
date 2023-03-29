#include <pvm3.h>
#include <iostream>

using namespace std;

int main(int argc, char** argv) {
    int cc, tid, msgtag;
    char buf[100];
    cout << pvm_mytid() << endl;
    
    cc = pvm_spawn("slave", (char**)0, 0, "", 1, &tid);
    
    if(cc == 1) {
        msgtag = 1;
    
        pvm_recv(tid, msgtag);
        pvm_upkstr(buf);
        cout << tid << ":" << buf;
    } else {
       cout << "Error" << endl;
    }
    pvm_exit();
    return 0;
}