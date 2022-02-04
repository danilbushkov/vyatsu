package coursework.mobile_app

import android.content.Intent
import androidx.appcompat.app.AppCompatActivity
import android.os.Bundle
import android.util.Log
import android.view.MenuItem
import android.view.View
import android.widget.EditText
import android.widget.Toast
import coursework.mobile_app.model.Errors
import coursework.mobile_app.model.User
import kotlinx.coroutines.Dispatchers
import kotlinx.coroutines.GlobalScope
import kotlinx.coroutines.launch

class RegistrationActivity : AppCompatActivity() {

    var editLogin: EditText? = null
    var editPassword: EditText? = null
    var app:App?=null

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.activity_registration)
        title="Регистрация"
        editLogin = findViewById(R.id.editRegistrationLogin)
        editPassword = findViewById(R.id.editRegistrationPassword)
        app = applicationContext as App;



        supportActionBar?.setHomeButtonEnabled(true)
        supportActionBar?.setDisplayHomeAsUpEnabled(true)

    }


    fun onClickRegistration(view: View){
        val login = editLogin!!.text.toString()
        val password = editPassword!!.text.toString()
        val toast = Toast.makeText(this, "", Toast.LENGTH_SHORT)
        val context = this
        GlobalScope.launch(Dispatchers.IO) {
            var status = app!!.httpClientService.StandardWrapper {
                val user = User(
                    login,
                    password,
                )
                val value = app!!.httpClientService.Registration(user)

                value.status
            }

            when(status) {
                in 1..8 -> {
                    toast.setText(Errors.getError(status))
                    toast.show()
                }
                0-> {
                    //Перейти к авторизации
                    toast.setText("Вы зарегистрировались")
                    toast.show()
                    context.finish()
                }
                in 20..21 ->{
                    var intent = Intent(context,MainActivity::class.java)
                    intent.addFlags(Intent.FLAG_ACTIVITY_CLEAR_TOP)
                    startActivity(intent)
                }
            }

            Log.e("Status", status.toString())
        }
    }


    override fun onOptionsItemSelected(item: MenuItem): Boolean {

        when(item.itemId){
            android.R.id.home ->{
                this.finish()
                return true
            }
        }
        return super.onOptionsItemSelected(item)


    }
}