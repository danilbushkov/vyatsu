package coursework.mobile_app.model

data class Task(

    val task_id:Int,
    val date_create:String,
    val last_update:String,
    val title:String,
    val text:String,
    val status:Boolean,
)