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
    var task_id:Int,
    var title:String,
    var text:String,
    var status: Boolean,
)

@Serializable
data class AddTaskStatus(val status: Int,val id:Int,val date_create:String)

@Serializable
data class EditTaskStatus(val status: Int,val date_update:String)

@Serializable
data class GetAllTaskStatus(val status: Int,val tasks:MutableList<Task>)

@Serializable
data class DatesTaskStatus(val status: Int,val dates:MutableList<String>)

@Serializable
data class HistoryTaskStatus(val status: Int, val task: TaskJSON)