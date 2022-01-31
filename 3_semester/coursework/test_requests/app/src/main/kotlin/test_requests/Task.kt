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
    val task_id:Int,
    val title:String,
    val text:String,
    val status: Boolean
    )

@Serializable    
data class Task(
    
	val task_id:Int,
	val date_create:String,
	val last_update:String,
	val title:String,
	val text:String,
	val status:Boolean,
)

@Serializable
data class CreateTaskStatus(val status:Int,val id:Int)

@Serializable
data class UpdateTaskStatus(val status:Int)
@Serializable
data class DeleteTaskStatus(val status:Int)
@Serializable
data class GetAllTaskStatus(val status:Int,val tasks:MutableList<Task>)
// data class User(val login:String, val password:String)




suspend fun AddTask(c:HttpClient,token:String):CreateTaskStatus{
    val response: CreateTaskStatus = c.post("http://localhost:8080/task/add") {
        contentType(ContentType.Application.Json)
        body = TaskJSON(0,"test","test",false)
        headers {
            append("Authorization", "Bearer "+token)
        }
    }
    return response
}

suspend fun UpdateTask(c:HttpClient,token:String):UpdateTaskStatus{
    val response: UpdateTaskStatus = c.post("http://localhost:8080/task/update") {
        contentType(ContentType.Application.Json)
        body = TaskJSON(1,"test-update","test-update",false)
        headers {
            append("Authorization", "Bearer "+token)
        }
    }
    return response
}
suspend fun DeleteTask(c:HttpClient,token:String):DeleteTaskStatus{
    val response: DeleteTaskStatus = c.get("http://localhost:8080/task/delete") {
        parameter("id", 0)
        headers {
            append("Authorization", "Bearer "+token)
        }
    }
    return response
}

suspend fun GetAllTask(c:HttpClient,token:String):GetAllTaskStatus{
    val response: GetAllTaskStatus = c.get("http://localhost:8080/tasks/get/all") {
        //parameter("id", 0)
        headers {
            append("Authorization", "Bearer "+token)
        }
    }
    return response
}
