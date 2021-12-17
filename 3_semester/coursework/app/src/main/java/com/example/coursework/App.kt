package com.example.coursework

import android.app.Application
import com.example.coursework.model.TasksService

class App:Application() {

    val tasksService = TasksService();


}