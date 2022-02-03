package coursework.mobile_app

import android.content.Intent
import androidx.appcompat.app.AppCompatActivity
import android.os.Bundle
import android.view.Menu
import android.view.MenuItem
import android.widget.TextView
import android.widget.Toast
import kotlinx.coroutines.Dispatchers
import kotlinx.coroutines.GlobalScope
import kotlinx.coroutines.launch

class AccountActivity : AppCompatActivity() {

    private var levelText: TextView? = null
    private var completedTasksText: TextView? = null
    private var app: App? = null

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        title = "Аккаунт"
        this.levelText = findViewById(R.id.levelText)
        this.completedTasksText= findViewById(R.id.completedTasksText)
        app = this.applicationContext as App


        setContentView(R.layout.activity_account)

        checkAuth()

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
        GlobalScope.launch(Dispatchers.IO) {
            var status = app!!.httpClientService.StandardWrapper {
                val value = app!!.httpClientService.logout()
                value.status
            }
            when (status) {

                0 -> {
                    toast.setText("Вы разлогинились")
                    toast.show()
                    app!!.auth=false
                    startActivity(intent)
                }
                else -> {
                    toast.setText("Ошибка")
                    toast.show()
                }
            }

        }
    }

}