package coursework.mobile_app

import android.content.Intent
import androidx.appcompat.app.AppCompatActivity
import android.os.Bundle
import android.widget.TextView

class AccountActivity : AppCompatActivity() {

    private var levelText: TextView? = null
    private var completedTasksText: TextView? = null
    private var app: App? = null

    override fun onCreate(savedInstanceState: Bundle?) {
        title = "Аккаунт"
        this.levelText = findViewById(R.id.levelText)
        this.completedTasksText= findViewById(R.id.completedTasksText)
        app = this.applicationContext as App

        super.onCreate(savedInstanceState)
        setContentView(R.layout.activity_account)



    }

    override fun onResume() {
        super.onResume()
        checkAuth()
        //Стягивание данные рейтинга
    }

    private fun checkAuth(){
        if(!app!!.auth){
            var intent = Intent(this, AuthActivity::class.java)
            startActivity(intent)
        }
    }
}