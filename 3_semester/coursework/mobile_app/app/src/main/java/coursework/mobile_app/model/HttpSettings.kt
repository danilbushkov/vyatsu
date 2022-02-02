package coursework.mobile_app.model

import android.content.SharedPreferences

class HttpSettings {
    var host:String=""
    var port:String=""

    fun save(s: SharedPreferences){
        var editor=s.edit();
        editor.putString("host",host)
        editor.putString("port",port)
        editor.apply()

    }


    companion object{
        const val DEFAULT_HOST = "http://127.0.0.1"
        const val DEFAULT_PORT = ":8080"
    }
}