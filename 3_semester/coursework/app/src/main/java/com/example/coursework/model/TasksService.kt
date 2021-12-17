package com.example.coursework.model

import android.util.Log

class TasksService {

    private var tasks = mutableListOf<Task>()

    init{
        GetTestsTask()
    }

    fun GetTestsTask(){
        for(n in 0..9){
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

    fun getPositionByID(id:Long):Long? {
        var i = 0.toLong()
        for (n in tasks){
            if (n.id == id){
                return i
            }

            i++
        }
        return null
    }

    fun getTaskByID(id:Long):Task? {
        for (n in tasks){
            if (n.id == id){
                return n
            }

        }
        return null
    }

}