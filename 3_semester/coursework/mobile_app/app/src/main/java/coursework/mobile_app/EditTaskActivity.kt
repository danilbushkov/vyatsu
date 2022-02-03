package coursework.mobile_app

import android.content.Intent
import androidx.appcompat.app.AppCompatActivity
import android.os.Bundle
import android.view.Menu
import android.view.MenuItem
import android.view.View
import android.widget.*
import coursework.mobile_app.model.Errors
import coursework.mobile_app.model.Task
import kotlinx.coroutines.Dispatchers
import kotlinx.coroutines.GlobalScope
import kotlinx.coroutines.launch

class EditTaskActivity : AppCompatActivity() {

    private lateinit var editTitle: EditText
    private lateinit var editText: EditText
    private lateinit var completed: CheckBox
    private lateinit var spinner: Spinner
    private lateinit var  app: App
    private lateinit var task: Task
    private var listenerTask: Task?=null
    set(value){
        //app.tasksService.deleteTask(value!!)
        field = value
    }
    private var datesListener:MutableList<String>?=null
    set(value){
        setSpinnerDates(value!!)
        field=value
    }

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.activity_edit_task)
        app = applicationContext as App

        title="Редактирование"

        editTitle=findViewById(R.id.editEditTitle)
        editText=findViewById(R.id.editEditText)
        completed=findViewById(R.id.checkBoxEditCompleted)
        spinner=findViewById(R.id.spinner)



        viewTask()
        getDates()




        supportActionBar?.setHomeButtonEnabled(true)
        supportActionBar?.setDisplayHomeAsUpEnabled(true)
    }

    private fun setSpinnerDates(dates:MutableList<String>){
        val adapter = ArrayAdapter<String>(this,android.R.layout.simple_spinner_item,dates)
        adapter.setDropDownViewResource(android.R.layout.simple_spinner_dropdown_item)
        spinner.adapter=adapter
    }

    private fun getDates(){
        val toast = Toast.makeText(this, "", Toast.LENGTH_SHORT)
        var dates = mutableListOf<String>()

        intent.addFlags(Intent.FLAG_ACTIVITY_CLEAR_TOP)
        GlobalScope.launch(Dispatchers.IO) {
            var status = app.httpClientService.StandardWrapper {
                val value = app.httpClientService.getDates(task.task_id)
                dates = value.dates
                value.status
            }
            when (status) {
                9 -> {
                    app.auth=false
                    toast.setText("Не авторизован")
                    toast.show()

                }
                0 -> {
                    datesListener=dates
                }
                else -> {
                    toast.setText("Ошибка")
                    toast.show()
                }
            }

        }
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
                deleteTask()
                return true
            }
        }
        return super.onOptionsItemSelected(item)


    }

    fun deleteTask(){

        val toast = Toast.makeText(this, "", Toast.LENGTH_SHORT)
        var intent = Intent(this, MainActivity::class.java)
        intent.addFlags(Intent.FLAG_ACTIVITY_CLEAR_TOP)
        GlobalScope.launch(Dispatchers.IO) {
            var status = app.httpClientService.StandardWrapper {
                val value = app.httpClientService.deleteTask(task)
                value.status
            }
            when (status) {

                0 -> {
                    toast.setText("Запись удалена")
                    toast.show()
                    startActivity(intent)
                }
                else -> {
                    toast.setText("Ошибка")
                    toast.show()
                }
            }

        }
    }

    override fun onCreateOptionsMenu(menu: Menu?): Boolean {
        menuInflater.inflate(R.menu.edit_menu, menu)
        return true
    }

    fun onClickEditTask(view: View) {
        view.isClickable = false
        var taskHttp = Task(
            task.task_id,
            "",
            "",
            editTitle.text.toString(),
            editTitle.text.toString(),
            completed.isChecked
        )
        val toast = Toast.makeText(this, "", Toast.LENGTH_SHORT)
        //val context =this
        var intent = Intent(this, MainActivity::class.java)
        intent.addFlags(Intent.FLAG_ACTIVITY_CLEAR_TOP)
        GlobalScope.launch(Dispatchers.IO) {
            var status = app.httpClientService.StandardWrapper {
                val value = app.httpClientService.editTask(taskHttp)

                value.status
            }

            when (status) {
                11 -> {
                    toast.setText(Errors.getError(status))
                    toast.show()

                }
                0 -> {

                    task.title = editTitle.text.toString()
                    task.text = editText.text.toString()
                    task.last_update = taskHttp.last_update
                    task.status = completed.isChecked
                    toast.setText("Запись изменена")
                    toast.show()

                    startActivity(intent)


                }
                else -> {
                    toast.setText("Ошибка")
                    toast.show()
                }
            }
            view.isClickable = true

        }
    }

}