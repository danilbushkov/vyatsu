package coursework.mobile_app

import androidx.appcompat.app.AppCompatActivity
import android.os.Bundle
import android.widget.TextView

class AccountActivity : AppCompatActivity() {

    val levelText: TextView = findViewById(R.id.levelText)
    val comletedTasksText: TextView = findViewById(R.id.completedTasksText)

    override fun onCreate(savedInstanceState: Bundle?) {
        title = "Аккаунт"
        super.onCreate(savedInstanceState)
        setContentView(R.layout.activity_account)
    }
}