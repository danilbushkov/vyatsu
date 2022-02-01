package coursework.mobile_app

import android.content.Intent
import androidx.appcompat.app.AppCompatActivity
import android.os.Bundle
import android.view.Menu
import android.view.MenuItem
import android.view.View
import coursework.mobile_app.databinding.ActivityMainBinding
import coursework.mobile_app.model.Task
import coursework.mobile_app.model.TasksListener

class MainActivity : AppCompatActivity() {

    private var app:App? = null
    private lateinit var adapter: TasksAdapter
    private lateinit var binding: ActivityMainBinding

    override fun onCreate(savedInstanceState: Bundle?) {
        title="Задачи"
        app =  (this?.applicationContext as App)
        super.onCreate(savedInstanceState)
        checkAuth()
        binding = ActivityMainBinding.inflate(layoutInflater)
        setContentView(binding.root)

        adapter = TasksAdapter(object: TaskActionListener{
            override fun onTaskClick(task: Task, position: Int) {
                TODO("Not yet implemented")
            }
        })
        binding.recyclerTasks.adapter = adapter
        app!!.tasksService.addListener(tasksListener)
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
}