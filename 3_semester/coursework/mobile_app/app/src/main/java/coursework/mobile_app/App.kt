package coursework.mobile_app

import android.app.Application
import coursework.mobile_app.model.Settings

class App:Application() {
    val settings: Settings = Settings()
    val auth: Boolean = false
    val token: String = ""
}