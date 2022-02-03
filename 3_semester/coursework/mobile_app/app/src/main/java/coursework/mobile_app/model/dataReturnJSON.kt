package coursework.mobile_app.model

import kotlinx.serialization.Serializable

//user
@Serializable
data class Status(val status:Int)
@Serializable
data class AuthStatus(val status: Int,val token:String)


//task
@Serializable
data class TaskJSON(
    val task_id:Int,
    val title:String,
    val text:String,
    val status: Boolean,
)

@Serializable
data class AddTaskStatus(val status: Int,val id:Int,val date_create:String)

@Serializable
data class EditTaskStatus(val status: Int,val date_create:String)