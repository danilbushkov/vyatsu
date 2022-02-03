package coursework.mobile_app

import android.content.Intent
import androidx.appcompat.app.AppCompatActivity
import android.os.Bundle
import android.util.Log
import android.view.MenuItem
import android.view.View
import android.widget.CheckBox
import android.widget.EditText
import android.widget.Toast
import coursework.mobile_app.model.AddTaskStatus
import coursework.mobile_app.model.Errors
import coursework.mobile_app.model.Task
import coursework.mobile_app.model.User
import kotlinx.coroutines.Dispatchers
import kotlinx.coroutines.GlobalScope
import kotlinx.coroutines.launch

class AddTaskActivity : AppCompatActivity() {

    var editTitle:EditText?=null
    var editText:EditText?=null
    var completed: CheckBox?=null
    private lateinit var app:App

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.activity_add_task)
        app=applicationContext as App

        editTitle=findViewById(R.id.editAddTitle)
        editText=findViewById(R.id.editAddText)
        completed=findViewById(R.id.checkBoxCompleted)

        supportActionBar?.setHomeButtonEnabled(true)
        supportActionBar?.setDisplayHomeAsUpEnabled(true)


    }

    fun onClickAddTask(view: View){
        view.isClickable=false
        var task = Task(
            0,
            "",
            "",
            editTitle!!.text.toString(),
            editTitle!!.text.toString(),
            completed!!.isChecked
        )
        val toast = Toast.makeText(this, "", Toast.LENGTH_SHORT)
        //val context =this
        var intent = Intent(this,MainActivity::class.java)
        intent.addFlags(Intent.FLAG_ACTIVITY_CLEAR_TOP)
        GlobalScope.launch(Dispatchers.IO) {
            var status = app.httpClientService.StandardWrapper {
                val value = app.httpClientService.addTask(task)

                value.status
            }

            when(status) {
                11 -> {
                    toast.setText(Errors.getError(status))
                    toast.show()

                }
                0-> {
                    app.tasksService.addTask(task)
                    //Перейти к авторизации
                    toast.setText("Запись добавлена")
                    toast.show()

                    startActivity(intent)


                }
                else->
                {
                    toast.setText("Ошибка")
                    toast.show()
                }
            }
            view.isClickable=true

        }
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