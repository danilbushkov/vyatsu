package com.example.coursework.model

import android.content.ContentValues
import android.database.sqlite.SQLiteDatabase
import android.provider.ContactsContract
import android.util.Log
import com.example.coursework.db.DatabaseHelper
import java.text.SimpleDateFormat
import java.util.*


typealias TasksListener = (tasks: List<Task>) -> Unit

class TasksService() {

    private var tasks = mutableListOf<Task>()
    private val listeners = mutableSetOf<TasksListener>()
    var db: SQLiteDatabase?=null
        set(value){
            field = value

        }

    init{
        //GetTasksFromDB()
    }

    fun GetTasksFromDB(){
        if (db == null){
            return
        }
        val projection = arrayOf(
            DatabaseHelper.COLUMN_ID,
            DatabaseHelper.COLUMN_TITLE,
            DatabaseHelper.COLUMN_TEXT
        )

        tasks = mutableListOf<Task>()
        val cursor = db!!.query(
            DatabaseHelper.TABLE,
            projection,
            null,
            null,
            null,
            null,
            null
        )
        with(cursor){
            while(moveToNext()) {
                val id  = getLong(getColumnIndexOrThrow(DatabaseHelper.COLUMN_ID))
                val title = getString(getColumnIndexOrThrow(DatabaseHelper.COLUMN_TITLE))
                val text = getString(getColumnIndexOrThrow(DatabaseHelper.COLUMN_TEXT))
                tasks.add(
                    Task(
                        id = id,
                        title = title,
                        text = text,
                        date_create = "",
                        date_change = "",
                        "",
                        "",
                        false
                    )
                )
            }
        }


        cursor.close()
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
        val sdf = SimpleDateFormat("yyyy-M-dd hh:mm:ss")
        val time = sdf.format(Date())
        Log.d("T",time)
        val values = ContentValues().apply {
            put(DatabaseHelper.COLUMN_TITLE,task.title)
            put(DatabaseHelper.COLUMN_TEXT,task.text)
            put(DatabaseHelper.COLUMN_DATE_CREATE,time)
        }
        db?.insert(DatabaseHelper.TABLE, null, values)
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
        val task = tasks.get(position)
        db!!.delete(
            DatabaseHelper.TABLE,
            "${DatabaseHelper.COLUMN_ID} LIKE ?",
            arrayOf(task.id.toString())
        )

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

    fun updateTask(task: Task) {
        val values = ContentValues().apply {
            put(DatabaseHelper.COLUMN_TITLE,task.title)
            put(DatabaseHelper.COLUMN_TEXT,task.text)
        }
        db!!.update(
            DatabaseHelper.TABLE,
            values,
            "${DatabaseHelper.COLUMN_ID} LIKE ?",
            arrayOf(task.id.toString())
        )
    }

}