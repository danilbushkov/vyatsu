package com.example.coursework

import android.content.Intent
import androidx.appcompat.app.AppCompatActivity
import android.os.Bundle
import android.view.View
import android.widget.EditText
import android.widget.Toast
import com.example.coursework.databinding.ActivityAddTaskBinding
import com.example.coursework.model.Task

class AddTaskActivity : AppCompatActivity() {
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        title = "Добавить задачу"
        setContentView(R.layout.activity_add_task)
    }

    fun addTask(view: View){

        val title = findViewById<EditText>(R.id.edit_add_title)
        if(title.text.toString() == "") {
            Toast.makeText(this, "Заполните поле названия задачи",Toast.LENGTH_SHORT)
                .show()

        }else{
            val task = Task(1,
                title.text.toString()
                ,"addedtext","111","111");
            (applicationContext as App).tasksService.addTask(task);


            intent = Intent(this, MainActivity::class.java)
            intent.addFlags(Intent.FLAG_ACTIVITY_CLEAR_TOP)
            startActivity(intent)
        }




    }

}