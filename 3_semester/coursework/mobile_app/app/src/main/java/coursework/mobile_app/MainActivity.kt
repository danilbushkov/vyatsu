package coursework.mobile_app

import android.content.Intent
import android.os.Build
import androidx.appcompat.app.AppCompatActivity
import android.os.Bundle
import android.util.Log
import android.view.Menu
import android.view.MenuItem
import android.view.View
import android.widget.EditText
import android.widget.Toast
import androidx.annotation.RequiresApi
import coursework.mobile_app.databinding.ActivityMainBinding
import coursework.mobile_app.model.Errors
import coursework.mobile_app.model.Task
import coursework.mobile_app.model.TasksListener
import kotlinx.coroutines.Dispatchers
import kotlinx.coroutines.GlobalScope
import kotlinx.coroutines.launch

class MainActivity : AppCompatActivity() {

    private var app:App? = null
    private lateinit var adapter: TasksAdapter
    private lateinit var binding: ActivityMainBinding
    private var tasks:MutableList<Task> = mutableListOf<Task>()
    set(value){
        app!!.tasksService.setTasks(value)
    }

    @RequiresApi(Build.VERSION_CODES.M)
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        title="Задачи"
        app =  (this?.applicationContext as App)
        app!!.storage=getSharedPreferences(App.NAME_STORAGE, MODE_PRIVATE)

        //checkAuth()
        binding = ActivityMainBinding.inflate(layoutInflater)
        setContentView(binding.root)


        val intent = Intent(this,EditTaskActivity::class.java)
        adapter = TasksAdapter(object: TaskActionListener{
            override fun onTaskClick(task: Task, position: Int) {
                Log.v("Task",task.toString())
                intent.putExtra("taskId",task.task_id)
                startActivity(intent)
            }

            override fun onTaskDone(task: Task) {
                app!!.tasksService.done(task)
            }

            override fun onTaskNotDone(task: Task) {
                app!!.tasksService.notDone(task)
            }

        })

        binding.recyclerTasks.adapter = adapter
        app!!.tasksService.addListener(tasksListener)

        checkConnect()
        getTaskHttp()
    }


    fun onClickAddTask(view:View){
        var intent = Intent(this,AddTaskActivity::class.java)
        startActivity(intent)
    }

    override fun onCreateOptionsMenu(menu: Menu?): Boolean {
        menuInflater.inflate(R.menu.main_menu, menu)
        return true
    }

    override fun onOptionsItemSelected(item: MenuItem): Boolean {
        var id = item.itemId
        when(id){
            R.id.menu_account->{
                var intent = Intent(this,AccountActivity::class.java)
                startActivity(intent)
                return true
            }
            R.id.menu_settings ->{
                var intent = Intent(this,AppSettingsActivity::class.java)
                startActivity(intent)
                return true
            }
        }
        return super.onOptionsItemSelected(item)
    }

    private fun checkAuth(){
        if(!app!!.auth){
            var intent = Intent(this, AuthActivity::class.java)
            intent.addFlags(Intent.FLAG_ACTIVITY_CLEAR_TOP);
            startActivity(intent)
            this.finish()
        }
    }
    private val tasksListener: TasksListener={
        adapter.tasks = it
    }

    override fun onDestroy() {
        super.onDestroy()
        app?.tasksService?.removeListener(tasksListener)
    }

    fun getTaskHttp(){
        val toast = Toast.makeText(this, "", Toast.LENGTH_SHORT)
        var t = mutableListOf<Task>()
        var intent = Intent(this, MainActivity::class.java)
        intent.addFlags(Intent.FLAG_ACTIVITY_CLEAR_TOP)
        GlobalScope.launch(Dispatchers.Main) {
            var status = app!!.httpClientService.StandardWrapper {
                val value = app!!.httpClientService.getAllTask()
                t=value.tasks
                value.status
            }

            when (status) {
                17 -> {
                    toast.setText(Errors.getError(status))
                    toast.show()
                }
                0 -> {
                    tasks = t
                }

                else -> {
                    toast.setText("Ошибка")
                    toast.show()
                }
            }

        }

    }






    @RequiresApi(Build.VERSION_CODES.M)
    fun checkConnect(){
        if(!app!!.httpClientService.isOnline(this)){
            var toast = Toast.makeText(this,"Нет подключения к интернету",Toast.LENGTH_SHORT)
            toast.show()
        }else{
            var toast = Toast.makeText(this,"Нет авторизован",Toast.LENGTH_SHORT)
            var intent1 = Intent(this, AppSettingsActivity::class.java)
            var intent2= Intent(this,AuthActivity::class.java)

            GlobalScope.launch(Dispatchers.IO){
                var status = app!!.httpClientService.CheckConnection()

                if(status == 20){

                    startActivity(intent1)
                    finish()
                }else if(status == 9){
                    toast.show()
                    startActivity(intent2)
                    app!!.auth=false

                }else {
                    app!!.auth = true
                }
            }
        }



    }
}