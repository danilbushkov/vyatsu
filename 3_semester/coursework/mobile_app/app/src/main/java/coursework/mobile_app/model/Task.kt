package coursework.mobile_app.model

data class Task(

    val task_id:Int,
    val date_create:String,
    var last_update:String,
    var title:String,
    var text:String,
    var status:Boolean,
)