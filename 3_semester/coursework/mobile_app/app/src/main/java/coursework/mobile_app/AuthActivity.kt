package coursework.mobile_app

import android.content.Intent
import androidx.appcompat.app.AppCompatActivity
import android.os.Bundle
import android.util.Log
import android.view.View
import android.widget.EditText
import android.widget.Toast
import coursework.mobile_app.model.Errors
import coursework.mobile_app.model.User
import kotlinx.coroutines.Dispatchers
import kotlinx.coroutines.GlobalScope
import kotlinx.coroutines.launch



class AuthActivity : AppCompatActivity() {

    var editAuthLogin: EditText? = null
    var editAuthPassword: EditText? = null
    var app: App? = null

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.activity_auth)
        title = "Авторизация"
        editAuthLogin = findViewById<EditText>(R.id.editAuthLogin)
        editAuthPassword = findViewById<EditText>(R.id.editAuthPassword)
        app = this.applicationContext as App




        if(app!!.auth){
            this.finish()
        }
    }


    fun onClickAuth(view: View){
        val login = editAuthLogin!!.text.toString()
        val password = editAuthPassword!!.text.toString()
        var toast = Toast.makeText(this, "",Toast.LENGTH_SHORT)
        var token = ""
        GlobalScope.launch(Dispatchers.IO) {
            var status = app!!.httpClientService.StandardWrapper {
                val user = User(
                    login,
                    password,
                )
                val value = app!!.httpClientService.Auth(user)
                token=value.token
                value.status
            }

            when(status) {
                in 1..8 -> {
                    toast.setText(Errors.getError(status))
                    toast.show()
                }
                0-> {
                    app!!.httpClientService.saveToken(app!!.storage!!,token)
                }
            }

            Log.e("Status", status.toString())
        }

    }

    fun onClickRegistration(view: View){
        var intent = Intent(this,RegistrationActivity::class.java)
        startActivity(intent)
    }


//    override fun onPause() {
//        super.onPause()
//        if(!app!!.auth){
//            finishAndRemoveTask()
//        }
//    }

}