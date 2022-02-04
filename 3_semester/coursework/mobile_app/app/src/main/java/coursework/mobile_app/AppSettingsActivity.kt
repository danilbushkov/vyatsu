package coursework.mobile_app

import android.content.Intent
import android.os.Build
import androidx.appcompat.app.AppCompatActivity
import android.os.Bundle
import android.util.Log
import android.view.View
import android.widget.EditText
import android.widget.Toast
import androidx.annotation.RequiresApi
import kotlinx.coroutines.Dispatchers
import kotlinx.coroutines.GlobalScope
import kotlinx.coroutines.launch

class AppSettingsActivity : AppCompatActivity() {
    var app:App? = null
    var editPort: EditText? = null
    var editHost: EditText?  = null

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.activity_app_settings)
        title="Настройки"
        this.app = (this?.applicationContext as App)
        this.editPort = findViewById<EditText>(R.id.editPort)
        this.editHost = findViewById<EditText>(R.id.editHost)

        this.editHost!!.setText(app!!.httpClientService.httpSettings.host)
        this.editPort!!.setText( app!!.httpClientService.httpSettings.port)
    }

    @RequiresApi(Build.VERSION_CODES.M)
    fun clickButtonApply(view: View){
        app!!.httpClientService.httpSettings.host = editHost?.text.toString()
        app!!.httpClientService.httpSettings.port = editPort?.text.toString()
        app!!.httpClientService.updatePath()
        app!!.httpClientService.httpSettings.save(app!!.storage!!)


        checkConnect()
    }

    @RequiresApi(Build.VERSION_CODES.M)
    fun checkConnect(){
        var toast = Toast.makeText(this,"", Toast.LENGTH_SHORT)
        if(!app!!.httpClientService.isOnline(this)){
            toast.setText("Нет подключения к интернету")
            toast.show()
        }else{
            var intent = Intent(this,AuthActivity::class.java)
            intent.addFlags(Intent.FLAG_ACTIVITY_CLEAR_TOP)
            var context = this
            GlobalScope.launch(Dispatchers.Main){
                var status = app!!.httpClientService.CheckConnection()
                if(status == 20){
                    toast.setText("Ошибка подключения")
                    toast.show()

                }else if (status == 9){
                    startActivity(intent)
                    app!!.auth = false
                    toast.setText("Не авторизован")
                    toast.show()
                }else if (status == 0){
                    toast.setText("Подключено")
                    toast.show()
                }else{
                    Log.e("Internet",status.toString())
                    var intent = Intent(context,AuthActivity::class.java)
                    intent.addFlags(Intent.FLAG_ACTIVITY_CLEAR_TOP)
                    startActivity(intent)
                }
            }
        }
    }
}