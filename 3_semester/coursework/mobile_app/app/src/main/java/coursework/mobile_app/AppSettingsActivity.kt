package coursework.mobile_app

import androidx.appcompat.app.AppCompatActivity
import android.os.Bundle
import android.view.View
import android.widget.EditText

class AppSettingsActivity : AppCompatActivity() {
    var app:App? = null
    var editPort: EditText? = null
    var editHost: EditText?  = null

    override fun onCreate(savedInstanceState: Bundle?) {
        title="Настройки"
        this.app = (this?.applicationContext as App)
        this.editPort = findViewById<EditText>(R.id.editPort)
        this.editHost = findViewById<EditText>(R.id.editHost)

        super.onCreate(savedInstanceState)
        setContentView(R.layout.activity_app_settings)
    }

    fun clickButtonApply(view: View){
        app!!.settings.host = editHost?.text.toString()
        app!!.settings.port = editPort?.text.toString()

    }
}