package coursework.mobile_app.model

class Settings {
    var host: String = DEFAULT_HOST
    var port: String = DEFAULT_PORT


    companion object{
        const val DEFAULT_HOST = "127.0.0.1"
        const val DEFAULT_PORT = "8080"
    }
}