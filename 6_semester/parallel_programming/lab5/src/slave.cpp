#include <pvm3.h>
#include <iostream>
#include <unistd.h>
#include <cstring>


int main() {
    int ptid, msgtag;
    char buf[100] = "1000\0";
    ptid = pvm_parent();

    gethostname(buf + strlen(buf), 64);
    msgtag = 1;
    pvm_initsend(PvmDataDefault);
    pvm_pkstr(buf);
    pvm_send(ptid, msgtag);



    pvm_exit();
    return 0;
}