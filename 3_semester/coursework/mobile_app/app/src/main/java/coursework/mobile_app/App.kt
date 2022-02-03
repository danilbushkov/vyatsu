package coursework.mobile_app

import android.app.Application
import android.content.Intent
import android.content.SharedPreferences
import coursework.mobile_app.model.HttpClientService
import coursework.mobile_app.model.HttpSettings
import coursework.mobile_app.model.TasksService

class App:Application() {
    val httpClientService:HttpClientService = HttpClientService(HttpSettings())
    var auth: Boolean = false
    set(value){
        if (!value){
//            val intent = Intent(this,AuthActivity::class.java)
//            intent.addFlags(Intent.FLAG_ACTIVITY_CLEAR_TOP)
//            startActivity(intent)
        }
        field = value
    }
    val tasksService = TasksService()
    var storage: SharedPreferences? = null
        set(value){
            field=value

            httpClientService.httpSettings.host=
                field!!.getString("host",HttpSettings.DEFAULT_HOST).toString()


            httpClientService.httpSettings.port=
                field!!.getString("port",HttpSettings.DEFAULT_PORT).toString()
            httpClientService.updatePath()
            httpClientService.token=field!!.getString("token","").toString()
        }
    companion object{
        val NAME_STORAGE="storage"
    }

}