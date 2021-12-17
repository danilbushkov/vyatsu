package com.example.coursework

import android.content.Intent
import androidx.appcompat.app.AppCompatActivity
import android.os.Bundle
import android.util.Log
import android.view.View
import android.widget.EditText
import android.widget.Toast
import com.example.coursework.model.Task

class EditTaskActivity : AppCompatActivity() {

    private var positoin:Int = 0


    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.activity_edit_task)
        title = "Задача"

        val arg = intent.extras

        if(arg!=null){
            val editTitle = findViewById<EditText>(R.id.edit_edit_title)
            val editText = findViewById<EditText>(R.id.edit_edit_text)
            this.positoin = arg.getInt("taskPosition").toInt()
            val task: Task? = (this?.applicationContext as App).tasksService.getTaskByID(arg.getLong("taskId"))
            Log.d("T",arg.getLong("taskId").toString())
            Log.d("TaskId",task!!.id.toString())
            Log.d("P",this.positoin.toString())
            editTitle.setText(task!!.title)
            editText.setText(task!!.text)

            //editTitle.setText("test")
            //editText.setText("test")
        }



    }

    fun editTask(view: View) {

        val title = findViewById<EditText>(R.id.edit_edit_title)
        val text = findViewById<EditText>(R.id.edit_edit_text)
        var task:Task = (applicationContext as App).tasksService.getTasks().elementAt(this.positoin.toInt())

        if (title.text.toString() == "") {
            Toast.makeText(this, "Заполните поле названия задачи", Toast.LENGTH_SHORT)
                .show()

        } else {
            task.text = text.text.toString()
            task.title = title.text.toString()


            intent = Intent(this, MainActivity::class.java)
            intent.addFlags(Intent.FLAG_ACTIVITY_CLEAR_TOP)
            startActivity(intent)
        }
    }


}