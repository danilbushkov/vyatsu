package com.example.coursework

import android.app.Application
import android.database.sqlite.SQLiteDatabase
import com.example.coursework.db.DatabaseHelper
import com.example.coursework.model.TasksService

class App:Application() {

    val tasksService = TasksService()
    var db: SQLiteDatabase? = null
        set(newValue){
            field = newValue
            tasksService.db = field
        }

}