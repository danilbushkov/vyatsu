package coursework.mobile_app.model

data class Task(

    var task_id:Int,
    var date_create:String,
    var last_update:String,
    var title:String,
    var text:String,
    var status:Boolean,
)