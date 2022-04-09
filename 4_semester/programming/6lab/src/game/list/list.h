#ifndef LIST_H
#define LIST_H



template <class T>
struct Node{
    Node<T>* next;
    Node<T>* prev;
    T *obj;
};

template <class T>
class List{
    public:
        Node<T> *begin;
        Node<T> *end;
        void DeleteNode(Node<T> *);
        void AddNode(T*);
        void Clear();
        List();
        ~List();
};

template <class T>
List<T>::List(){
    begin = nullptr;
    end = nullptr;
}

template <class T>
void List<T>::DeleteNode(Node<T> *node){
    if(node!=nullptr){
        if(node->prev==nullptr){
            begin = node->next;
        }else{
            node->prev->next = node->next;
        }
        
        if(node->next==nullptr){
            end = node->prev;
        }else{
            node->next->prev = node->prev;
        }

        
        if(node->obj!=nullptr){
            delete node->obj;
        }
        delete node;
        node = nullptr;

    }
}

template <class T>
void List<T>::AddNode(T *obj){
    Node<T> *node = new Node<T>();
    node->obj = obj;
    node->next = nullptr;
    node->prev = end;

    if(begin == nullptr){
        begin = node;
    }else{
        end->next = node;
    }
    end = node;
}

template <class T>
void List<T>::Clear(){
    Node<T> *node = begin;
    while(node != nullptr){
        DeleteNode(node);
        node = begin;
    }
}

template <class T>
List<T>::~List(){
    Clear();
}

#endif