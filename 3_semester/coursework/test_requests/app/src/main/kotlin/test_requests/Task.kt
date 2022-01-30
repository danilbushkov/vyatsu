package test_requests

import io.ktor.client.*
import io.ktor.client.request.*
import io.ktor.client.statement.*
import io.ktor.http.*
import io.ktor.client.engine.cio.*
import kotlinx.coroutines.*
import kotlinx.serialization.*
import io.ktor.client.features.json.*
import io.ktor.client.features.json.serializer.*
import io.ktor.client.request.forms.*


@Serializable
data class TaskJSON(
    val title:String,
    val text:String,
    val deadline: String,
    val status: Int
    )

@Serializable
data class CreateTaskStatus(val status:Int)
// data class User(val login:String, val password:String)




suspend fun AddTask(c:HttpClient,token:String):CreateTaskStatus{
    val response: CreateTaskStatus = c.post("http://localhost:8080/task/add") {
        contentType(ContentType.Application.Json)
        body = TaskJSON("test","test","2006-01-02T15:04:05",0)
        headers {
            append("Authorization", "Bearer "+token)
        }
    }
    return response
}