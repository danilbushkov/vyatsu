package coursework.mobile_app

import android.content.Intent
import androidx.appcompat.app.AppCompatActivity
import android.os.Bundle
import android.util.Log
import android.view.Menu
import android.view.MenuItem
import android.view.View
import android.widget.*
import android.widget.AdapterView.OnItemSelectedListener
import coursework.mobile_app.model.Errors
import coursework.mobile_app.model.Task
import coursework.mobile_app.model.TaskJSON
import kotlinx.coroutines.Dispatchers
import kotlinx.coroutines.GlobalScope
import kotlinx.coroutines.launch

class EditTaskActivity : AppCompatActivity() {

    private lateinit var editTitle: EditText
    private lateinit var editText: EditText
    private lateinit var completed: CheckBox
    private lateinit var spinner: Spinner
    private lateinit var  app: App
    private lateinit var toast:Toast

    private var task: Task?=null
    private var update: Boolean = false
    set(value){

        field = value
    }


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
        toast = Toast.makeText(this, "", Toast.LENGTH_SHORT)



        viewTask()
        getDates()




        supportActionBar?.setHomeButtonEnabled(true)
        supportActionBar?.setDisplayHomeAsUpEnabled(true)
    }

    private fun setSpinnerDates(dates:MutableList<String>){

        val adapter = ArrayAdapter<String>(this,android.R.layout.simple_spinner_item,dates)
        adapter.setDropDownViewResource(android.R.layout.simple_spinner_dropdown_item)
        spinner.adapter=adapter
        var context = this
        val itemSelectedListener = object: OnItemSelectedListener{
            override fun onItemSelected(
                parent: AdapterView<*>?,
                view: View?,
                position: Int,
                id: Long
            ) {
                val item = parent?.getItemAtPosition(position).toString()
                var t: TaskJSON? = null
                GlobalScope.launch(Dispatchers.Main) {
                    var status = app.httpClientService.StandardWrapper {
                        val value = app.httpClientService.getHistory(task!!.task_id,item)
                        t = value.task
                        value.status
                    }
                    Log.e("Http",t.toString())
                    Log.e("Http",status.toString())
                    var taskJSON = t
                    when (status) {
                        9 ->{
                            app.auth=false
                            toast.setText("Вы не авторизованы")
                            toast.show()
                            var intent = Intent(context, AuthActivity::class.java)
                            intent.addFlags(Intent.FLAG_ACTIVITY_CLEAR_TOP)
                            startActivity(intent)
                            context.finish()

                        }
                        in 20..21 ->{
                            var intent = Intent(context, MainActivity::class.java)
                            intent.addFlags(Intent.FLAG_ACTIVITY_CLEAR_TOP)
                            startActivity(intent)
                            context.finish()
                        }
                        0 -> {
                            task!!.title=taskJSON!!.title
                            task!!.text=taskJSON!!.text
                            task!!.status=taskJSON!!.status
                            editText.setText(task!!.text)
                            editTitle.setText(task!!.title)
                            completed.isChecked = task!!.status




                        }
                        else -> {
                            toast.setText("Ошибка")
                            toast.show()
                        }
                    }

                }
            }

            override fun onNothingSelected(parent: AdapterView<*>?) {
            }
        }
        spinner.onItemSelectedListener=itemSelectedListener
    }

    private fun getDates(){
        val toast = Toast.makeText(this, "", Toast.LENGTH_SHORT)
        var dates = mutableListOf<String>()
        var context = this
        var intent = Intent(context, MainActivity::class.java)
        intent.addFlags(Intent.FLAG_ACTIVITY_CLEAR_TOP)
        GlobalScope.launch(Dispatchers.IO) {
            var status = app.httpClientService.StandardWrapper {
                val value = app.httpClientService.getDates(task!!.task_id)
                dates = value.dates
                value.status
            }
            when (status) {
                9 ->{
                    app.auth=false
                    toast.setText("Вы не авторизованы")
                    toast.show()
                    var intent = Intent(context, AuthActivity::class.java)
                    intent.addFlags(Intent.FLAG_ACTIVITY_CLEAR_TOP)
                    startActivity(intent)
                    context.finish()

                }
                in 20..21 ->{
                    startActivity(intent)
                    context.finish()
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

    }

    override fun onOptionsItemSelected(item: MenuItem): Boolean {

        when(item.itemId){
            android.R.id.home ->{
                this.finish()
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
        var context = this
        GlobalScope.launch(Dispatchers.IO) {
            var status = app.httpClientService.StandardWrapper {
                val value = app.httpClientService.deleteTask(task!!)
                value.status
            }
            when (status) {

                0 -> {
                    toast.setText("Запись удалена")
                    toast.show()
                    startActivity(intent)
                }
                9 ->{
                    app.auth=false
                    toast.setText("Вы не авторизованы")
                    toast.show()
                    var intent = Intent(context, AuthActivity::class.java)
                    intent.addFlags(Intent.FLAG_ACTIVITY_CLEAR_TOP)
                    startActivity(intent)
                    context.finish()

                }
                in 20..21 ->{
                    startActivity(intent)
                    context.finish()
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
            task!!.task_id,
            "",
            "",
            editTitle.text.toString(),
            editTitle.text.toString(),
            completed.isChecked
        )
        val toast = Toast.makeText(this, "", Toast.LENGTH_SHORT)
        val context =this
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
                9 ->{
                    app.auth=false
                    toast.setText("Вы не авторизованы")
                    toast.show()
                    var intent = Intent(context, AuthActivity::class.java)
                    intent.addFlags(Intent.FLAG_ACTIVITY_CLEAR_TOP)
                    startActivity(intent)
                    context.finish()
                }
                in 20..21 ->{
                    startActivity(intent)
                    context.finish()
                }
                0 -> {

                    task!!.title = editTitle.text.toString()
                    task!!.text = editText.text.toString()
                    task!!.last_update = taskHttp.last_update
                    task!!.status = completed.isChecked
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