package coursework.mobile_app.model

import android.content.Context
import android.content.Intent
import android.content.SharedPreferences
import android.net.ConnectivityManager
import android.net.NetworkCapabilities
import android.os.Build
import android.util.Log
import android.util.Log.ASSERT
import android.widget.Toast
import androidx.annotation.RequiresApi
import androidx.core.content.ContextCompat.startActivity
import coursework.mobile_app.App
import coursework.mobile_app.AppSettingsActivity
import io.ktor.client.*
import io.ktor.client.features.*
import io.ktor.client.features.get
import io.ktor.client.features.json.*
import io.ktor.client.features.json.serializer.*

import io.ktor.client.features.observer.*
import io.ktor.client.request.*
import io.ktor.client.request.forms.*
import io.ktor.client.statement.*
import io.ktor.http.*

import kotlinx.coroutines.Dispatchers
import kotlinx.coroutines.GlobalScope
import kotlinx.coroutines.launch
import kotlinx.serialization.json.Json
import org.json.JSONObject
import java.net.ConnectException
import javax.sql.StatementEvent

class HttpClientService(val httpSettings: HttpSettings) {
    private val client = HttpClient(){
        install(JsonFeature){
            serializer = KotlinxSerializer()
        }
        expectSuccess = true
    }
    private var path = httpSettings.host+httpSettings.port
    var token = ""

    fun updatePath(){
        path = httpSettings.host+httpSettings.port
    }
    fun saveToken(s: SharedPreferences, t:String){
        token=t
        var editor=s.edit();
        editor.putString("token",token)

        editor.apply()
    }

    suspend fun editTask(task:Task):EditTaskStatus{
        Log.v("HttpInfo:",task.status.toString())
        val response:EditTaskStatus = client.post(path+"/task/update"){
            contentType(ContentType.Application.Json)
            body = TaskJSON(
                task.task_id,
                task.title,
                task.text,
                task.status,
            )
            headers {
                append("Authorization", "Bearer "+token)
            }
        }
        task.date_create=response.date_update
        task.last_update=response.date_update

        return response
    }


    suspend fun addTask(task:Task):AddTaskStatus{
        val response:AddTaskStatus = client.post(path+"/task/add"){
            contentType(ContentType.Application.Json)
            body = TaskJSON(
                0,
                task.title,
                task.text,
                task.status,
            )
            headers {
                append("Authorization", "Bearer "+token)
            }
        }
        task.task_id=response.id
        task.date_create=response.date_create
        task.last_update=response.date_create

        return response
    }

    suspend fun getAllTask():GetAllTaskStatus{
        var response: GetAllTaskStatus = client.get(path + "/tasks/get/all") {
            headers{
                append("Authorization","Bearer "+token)
            }
        }
        return response
    }

    suspend fun logout():Status{
        var response: Status = client.get(path + "/user/logout") {
            headers{
                append("Authorization","Bearer "+token)
            }
        }
        return response
    }

    suspend fun deleteTask(task:Task):Status{
        var response: Status = client.get(path + "/task/delete") {
            parameter("id",task.task_id)
            headers{
                append("Authorization","Bearer "+token)
            }
        }
        return response
    }

    suspend fun Registration(user:User):Status{
        val response:Status = client.submitForm(
            url=path+"/user/registration",
            formParameters = Parameters.build {
                append("login",user.login)
                append("password",user.password)
            },
            encodeInQuery = false
        )
        return response
    }

    suspend fun Auth(user:User):AuthStatus{
        val response:AuthStatus = client.submitForm(
            url=path+"/user/auth",
            formParameters = Parameters.build {
                append("login",user.login)
                append("password",user.password)
            },
            encodeInQuery = false
        )
        return response
    }


    suspend fun StandardWrapper(f:suspend ()->Int):Int{
        try {
            var status = f()
            return status

        }catch(c:Throwable){

            return when(c){
                is ConnectException ->{
                    20
                }
                is ResponseException ->{
                    var status:Status = Json.decodeFromString(Status.serializer(),c.response.readText())
                    Log.v("Ktor: ",status.status.toString())
                    return status.status.toInt()
                }
                else -> {
                    21
                }
            }
        }
        return 21


    }

    suspend fun CheckConnection():Int{
        try {
            var response: Status = client.get(path + "/check/") {
                headers{
                    append("Authorization","Bearer "+token)
                }
            }

            return response.status

        }catch(c:Throwable){

            return when(c){
                is ConnectException ->{
                    20
                }
                is ResponseException ->{
                    var status:Status = Json.decodeFromString(Status.serializer(),c.response.readText())
                    Log.v("Ktor: ",status.status.toString())
                    return status.status.toInt()
                }
                else -> {
                    Log.v("Error: ",c.toString())
                    21
                }
            }
        }
        return 21
    }




    @RequiresApi(Build.VERSION_CODES.M)
    fun isOnline(context: Context): Boolean {
        val connectivityManager =
            context.getSystemService(Context.CONNECTIVITY_SERVICE) as ConnectivityManager
        if (connectivityManager != null) {
            val capabilities =
                connectivityManager.getNetworkCapabilities(connectivityManager.activeNetwork)
            if (capabilities != null) {
                if (capabilities.hasTransport(NetworkCapabilities.TRANSPORT_CELLULAR)) {
                    Log.i("Internet", "NetworkCapabilities.TRANSPORT_CELLULAR")
                    return true
                } else if (capabilities.hasTransport(NetworkCapabilities.TRANSPORT_WIFI)) {
                    Log.i("Internet", "NetworkCapabilities.TRANSPORT_WIFI")
                    return true
                } else if (capabilities.hasTransport(NetworkCapabilities.TRANSPORT_ETHERNET)) {
                    Log.i("Internet", "NetworkCapabilities.TRANSPORT_ETHERNET")
                    return true
                }
            }
        }
        return false
    }
}