package com.example.coursework.model

import android.util.Log

class TasksService {

    private var tasks = mutableListOf<Task>()

    init{
        GetTestsTask()
    }

    fun GetTestsTask(){
        for(n in 1..10){
            tasks.add(Task(
                id = n.toLong(),
                title = "Title"+n.toString(),
                text = "Text"+n.toString(),
                date_create = n.toString(),
                date_change = n.toString()
            ));
            //Log.d("asfdasdf,", tasks[n-1].id.toString())
        }
    }

    fun addTask(task: Task){
        tasks.add(0,task);
    }


    fun getTasks(): List<Task>{
        return  tasks
    }



}