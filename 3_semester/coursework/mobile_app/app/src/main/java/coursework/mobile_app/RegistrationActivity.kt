package coursework.mobile_app

import androidx.appcompat.app.AppCompatActivity
import android.os.Bundle
import android.view.MenuItem
import android.view.View
import android.widget.EditText

class RegistrationActivity : AppCompatActivity() {

    var editLogin: EditText? = null
    var editPassword: EditText? = null


    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        title="Регистрация"
        editLogin = findViewById(R.id.editRegistrationLogin)
        editPassword = findViewById(R.id.editRegistrationPassword)


        setContentView(R.layout.activity_registration)

        supportActionBar?.setHomeButtonEnabled(true)
        supportActionBar?.setDisplayHomeAsUpEnabled(true)

    }


    fun onCloseRegistration(view: View){

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