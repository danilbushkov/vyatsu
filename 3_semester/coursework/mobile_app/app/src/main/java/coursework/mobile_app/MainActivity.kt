package coursework.mobile_app

import android.content.Intent
import androidx.appcompat.app.AppCompatActivity
import android.os.Bundle
import android.view.Menu
import android.view.MenuItem
import android.view.View

class MainActivity : AppCompatActivity() {

    var app:App? = null

    override fun onCreate(savedInstanceState: Bundle?) {
        title="Задачи"
        app =  (this?.applicationContext as App)

        super.onCreate(savedInstanceState)
        setContentView(R.layout.activity_main)
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
            }
            R.id.menu_settings ->{
                var intent = Intent(this,AppSettingsActivity::class.java)
                startActivity(intent)
            }
        }
        return super.onOptionsItemSelected(item)
    }
}