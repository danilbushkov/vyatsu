package coursework.mobile_app

import androidx.appcompat.app.AppCompatActivity
import android.os.Bundle
import android.view.View
import android.widget.EditText

class AppSettingsActivity : AppCompatActivity() {
    val app:App = (this?.applicationContext as App)
    val editPort = findViewById<EditText>(R.id.editPort)
    val editHost = findViewById<EditText>(R.id.editHost)

    override fun onCreate(savedInstanceState: Bundle?) {
        title="Настройки"
        super.onCreate(savedInstanceState)
        setContentView(R.layout.activity_app_settings)
    }

    fun clickButtonApply(view: View){
        app.settings.host = editHost.text.toString()
        app.settings.port = editPort.text.toString()

    }
}