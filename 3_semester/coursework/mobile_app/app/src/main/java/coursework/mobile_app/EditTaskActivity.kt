package coursework.mobile_app

import android.content.Intent
import androidx.appcompat.app.AppCompatActivity
import android.os.Bundle
import android.view.Menu
import android.view.MenuItem
import android.view.View
import android.widget.CheckBox
import android.widget.EditText
import coursework.mobile_app.model.Task

class EditTaskActivity : AppCompatActivity() {

    private lateinit var editTitle: EditText
    private lateinit var editText: EditText
    private lateinit var completed: CheckBox
    private lateinit var  app: App
    private lateinit var task: Task

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        app = applicationContext as App
        setContentView(R.layout.activity_edit_task)
        title="Редактирование"

        editTitle=findViewById(R.id.editEditTitle)
        editText=findViewById(R.id.editEditText)
        completed=findViewById(R.id.checkBoxEditCompleted)



        viewTask()





        supportActionBar?.setHomeButtonEnabled(true)
        supportActionBar?.setDisplayHomeAsUpEnabled(true)
    }


    private fun viewTask(){
        val arg = intent.extras
        task = app.tasksService.getTaskById(arg!!.getInt("taskId"))
        editText.setText(task.text)
        editTitle.setText(task.title)
        if (task.status) {
            completed.toggle()
        }
    }

    override fun onOptionsItemSelected(item: MenuItem): Boolean {

        when(item.itemId){
            android.R.id.home ->{
                this.finish()
                return true
            }
            R.id.menu_edit_info->{

                return true
            }
            R.id.menu_edit_delete ->{
                app.tasksService.deleteTask(task)
                intent = Intent(this,MainActivity::class.java)
                intent.addFlags(Intent.FLAG_ACTIVITY_CLEAR_TOP)
                startActivity(intent)
                return true
            }
        }
        return super.onOptionsItemSelected(item)


    }

    override fun onCreateOptionsMenu(menu: Menu?): Boolean {
        menuInflater.inflate(R.menu.edit_menu, menu)
        return true
    }

    fun onClickEditTask(view: View){
        task.title = editTitle.text.toString()
        task.text = editText.text.toString()
        task.status = completed.isChecked
        var intent = Intent(this,MainActivity::class.java)
        intent.addFlags(Intent.FLAG_ACTIVITY_CLEAR_TOP)
        startActivity(intent)
    }

}