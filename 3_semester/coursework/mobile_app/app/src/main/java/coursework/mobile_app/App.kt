package coursework.mobile_app

import android.app.Application
import coursework.mobile_app.model.Settings
import coursework.mobile_app.model.TasksService

class App:Application() {
    val settings: Settings = Settings()
    val auth: Boolean = true
    val token: String = ""
    val tasksService = TasksService()
}