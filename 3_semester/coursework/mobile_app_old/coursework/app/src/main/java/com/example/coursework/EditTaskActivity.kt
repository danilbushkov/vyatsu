package com.example.coursework

import android.annotation.SuppressLint
import android.content.Intent
import android.graphics.drawable.ColorDrawable
import androidx.appcompat.app.AppCompatActivity
import android.os.Bundle
import android.util.Log
import android.view.Menu
import android.view.MenuItem
import android.view.View
import android.widget.EditText
import android.widget.Toast
import com.example.coursework.model.Task

class EditTaskActivity : AppCompatActivity() {

    private var positoin:Int = 0



    override fun onCreate(savedInstanceState: Bundle?) {
        val arg = intent.extras
        val task: Task? = (this?.applicationContext as App).tasksService.getTaskByID(arg!!.getLong("taskId"))
        if (task!!.done) {
            setTheme(R.style.Theme_CourseWork_Done)
        }
        super.onCreate(savedInstanceState)
        setContentView(R.layout.activity_edit_task)
        title = "Задача"
        //actionBar!!.setBackgroundDrawable(ColorDrawable(R.color.green))




        if(arg!=null){
            val editTitle = findViewById<EditText>(R.id.edit_edit_title)
            val editText = findViewById<EditText>(R.id.edit_edit_text)
            this.positoin = arg.getInt("taskPosition").toInt()

//            Log.d("T",arg.getLong("taskId").toString())
//            Log.d("TaskId",task!!.id.toString())
//            Log.d("P",this.positoin.toString())
            editTitle.setText(task!!.title)
            editText.setText(task!!.text)

            //editTitle.setText("test")
            //editText.setText("test")
        }



    }

    fun editTask(view: View) {

        val title = findViewById<EditText>(R.id.edit_edit_title)
        val text = findViewById<EditText>(R.id.edit_edit_text)
        var task:Task = (applicationContext as App).tasksService.getTasks().elementAt(this.positoin)

        if (title.text.toString() == "") {
            Toast.makeText(this, "Заполните поле названия задачи", Toast.LENGTH_SHORT)
                .show()

        } else {
            val tasksService = (this?.applicationContext as App).tasksService
            task.title = title.text.toString()
            task.text = text.text.toString()
            tasksService.updateTask(task)



            intent = Intent(this, MainActivity::class.java)
            intent.addFlags(Intent.FLAG_ACTIVITY_CLEAR_TOP)
            startActivity(intent)
        }
    }

    override fun onCreateOptionsMenu(menu: Menu?): Boolean {
        menuInflater.inflate(R.menu.task_menu,menu)
        return true
    }

    override fun onOptionsItemSelected(item: MenuItem): Boolean {
        val id = item.itemId
        var tasksService = (applicationContext as App).tasksService
        when(id){
            R.id.delete_task -> {
                tasksService.deleteTaskByPosition(this.positoin)
                intent = Intent(this, MainActivity::class.java)
                intent.addFlags(Intent.FLAG_ACTIVITY_CLEAR_TOP)
                startActivity(intent)
            }

        }

        return super.onOptionsItemSelected(item)
    }

}