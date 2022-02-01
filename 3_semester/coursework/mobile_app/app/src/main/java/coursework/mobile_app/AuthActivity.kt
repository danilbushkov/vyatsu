package coursework.mobile_app

import android.content.Intent
import androidx.appcompat.app.AppCompatActivity
import android.os.Bundle
import android.view.View
import android.widget.EditText

class AuthActivity : AppCompatActivity() {

    var editAuthLogin: EditText? = null
    var editAuthPassword: EditText? = null
    var app: App? = null

    override fun onCreate(savedInstanceState: Bundle?) {
        title = "Авторизация"
        editAuthLogin = findViewById<EditText>(R.id.editAuthLogin)
        editAuthPassword = findViewById<EditText>(R.id.editAuthPassword)
        app = this.applicationContext as App

        super.onCreate(savedInstanceState)
        setContentView(R.layout.activity_auth)

        checkAuth()
    }


    fun onClickAuth(view: View){

    }

    fun onClickRegistration(view: View){
        var intent = Intent(this,RegistrationActivity::class.java)
        startActivity(intent)
    }

    fun checkAuth(){
        if(app!!.auth){
            this.finish()
        }
    }
}