package coursework.mobile_app

import android.content.Intent
import androidx.appcompat.app.AppCompatActivity
import android.os.Bundle
import android.util.Log
import android.view.Menu
import android.view.MenuItem
import android.widget.TextView
import android.widget.Toast
import coursework.mobile_app.model.ProgressStatus
import kotlinx.coroutines.Dispatchers
import kotlinx.coroutines.GlobalScope
import kotlinx.coroutines.launch

class AccountActivity : AppCompatActivity() {

    private var levelText: TextView? = null
    private var completedTasksText: TextView? = null
    private var app: App? = null

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.activity_account)
        title = "Аккаунт"
        this.levelText = findViewById(R.id.levelText)
        this.completedTasksText= findViewById(R.id.completedTasksText)
        app = this.applicationContext as App




        checkAuth()
        getInfo()
    }

    fun getInfo(){
        val toast = Toast.makeText(this, "", Toast.LENGTH_SHORT)
        var intent = Intent(this, AuthActivity::class.java)

        GlobalScope.launch(Dispatchers.Main) {
            var progress: ProgressStatus?=null
            var status = app!!.httpClientService.StandardWrapper {
                val value = app!!.httpClientService.progress()
                progress = value
                value.status
            }
            Log.e("Account",progress.toString())
            when (status) {
                9 ->{
                    toast.setText("Вы не авторизованы")
                    toast.show()
                    app!!.auth=false
                    startActivity(intent)
                }
                0 -> {
                    completedTasksText!!.text=progress!!.count.toString()
                    levelText!!.text=progress!!.level.toString()
                }
                else -> {
                    toast.setText("Ошибка")
                    toast.show()
                }
            }

        }
    }


    override fun onResume() {
        super.onResume()

        //Стягивание данные рейтинга
    }

    private fun checkAuth(){
        if(!app!!.auth){
            var intent = Intent(this, AuthActivity::class.java)
            intent.addFlags(Intent.FLAG_ACTIVITY_CLEAR_TOP);
            startActivity(intent)
            this.finish()
        }
    }

    override fun onCreateOptionsMenu(menu: Menu?): Boolean {
        menuInflater.inflate(R.menu.account_menu, menu)
        return true
    }

    override fun onOptionsItemSelected(item: MenuItem): Boolean {

        when(item.itemId){
            R.id.menu_account_exit->{
                logout()
                return true
            }

        }
        return super.onOptionsItemSelected(item)


    }
    fun logout(){
        val toast = Toast.makeText(this, "", Toast.LENGTH_SHORT)
        var intent = Intent(this, AuthActivity::class.java)
        intent.addFlags(Intent.FLAG_ACTIVITY_CLEAR_TOP)
        var context = this
        GlobalScope.launch(Dispatchers.Main) {
            var status = app!!.httpClientService.StandardWrapper {
                val value = app!!.httpClientService.logout()
                value.status
            }
            when (status) {
                9 ->{
                    toast.setText("Вы не авторизованы")
                    toast.show()
                    app!!.auth=false
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
                    toast.setText("Вы разлогинились")
                    toast.show()
                    app!!.auth=false
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

}