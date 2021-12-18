package com.example.coursework.model

import android.util.Log
import java.text.FieldPosition

typealias TasksListener = (tasks: List<Task>) -> Unit

class TasksService {

    private var tasks = mutableListOf<Task>()
    private val listeners = mutableSetOf<TasksListener>()

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
                date_change = n.toString(),
                "asdf",  "1111",
                false
            ));
            //Log.d("asfdasdf,", tasks[n-1].id.toString())
        }
    }

    fun addTask(task: Task){
        tasks.add(0,task);
        notifyChanges()
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
    fun deleteTaskByPosition(position: Int) {
        tasks.removeAt(position)
        notifyChanges()
    }
    fun doneTask(task: Task){
        task.done = true
        notifyChanges()
    }
    fun notDoneTask(task: Task){
        task.done = false
        notifyChanges()
    }

    fun doneTaskByPosition(position: Int) {
        tasks.get(position).done=true

    }

    fun addListener(listener: TasksListener){
        listeners.add(listener)
        listener.invoke(tasks)
    }

    fun removeListener(listener: TasksListener){
        listeners.remove(listener)
    }

    private fun notifyChanges(){
        listeners.forEach{it.invoke(tasks)}
    }

}