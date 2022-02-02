package coursework.mobile_app

import android.content.Intent
import androidx.appcompat.app.AppCompatActivity
import android.os.Bundle
import android.view.MenuItem
import android.view.View
import android.widget.CheckBox
import android.widget.EditText
import coursework.mobile_app.model.Task

class AddTaskActivity : AppCompatActivity() {

    var editTitle:EditText?=null
    var editText:EditText?=null
    var completed: CheckBox?=null
    private lateinit var app:App

    override fun onCreate(savedInstanceState: Bundle?) {
        app=applicationContext as App
        super.onCreate(savedInstanceState)
        setContentView(R.layout.activity_add_task)
        editTitle=findViewById(R.id.editAddTitle)
        editText=findViewById(R.id.editAddText)
        completed=findViewById(R.id.checkBoxCompleted)

        supportActionBar?.setHomeButtonEnabled(true)
        supportActionBar?.setDisplayHomeAsUpEnabled(true)


    }

    fun onClickAddTask(view: View){

        val task = Task(
            1,
            "123",
            "123",
            editTitle!!.text.toString(),
            editTitle!!.text.toString(),
            completed!!.isChecked
        )
        app.tasksService.addTasks(task)

        val intent = Intent(this,MainActivity::class.java)
        intent.addFlags(Intent.FLAG_ACTIVITY_CLEAR_TOP)
        startActivity(intent)
    }

    override fun onOptionsItemSelected(item: MenuItem): Boolean {

        when(item.itemId){
            android.R.id.home ->{
                this.finish()
                return true
            }
        }
        return super.onOptionsItemSelected(item)


    }
}