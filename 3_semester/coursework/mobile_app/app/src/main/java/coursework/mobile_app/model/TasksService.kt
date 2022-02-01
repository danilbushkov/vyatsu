package coursework.mobile_app.model


typealias TasksListener = (tasks: List<Task>) -> Unit

class TasksService {

    private var tasks = mutableListOf<Task>()

    private val listeners = mutableSetOf<TasksListener>()

    init{
        //tasks=getTestTasks().toMutableList()
        tasks = (1..20).map{
            Task(
                task_id=it.toInt(),
                date_create = "test",
                last_update ="test",
                title="title "+it.toString(),
                text="text "+it.toString(),
                status=false,
            )
        }.toMutableList()
    }
    fun getTasks():List<Task>{
        return tasks
    }
    private fun getTestTasks():List<Task>{
        var tasks = mutableListOf<Task>()
        tasks = (1..20).map{
            Task(
                task_id=it.toInt(),
            date_create = "test",
            last_update ="test",
            title="title "+it.toString(),
            text="text "+it.toString(),
            status=false,
            )
        }.toMutableList()
        return  tasks
    }

    fun addListener(listener: TasksListener){
        listeners.add(listener)
        listener.invoke(tasks)
    }

    fun removeListener(listener: TasksListener){
        listeners.remove(listener)
    }

    private fun notifyChanges(){
        listeners.forEach{it.invoke(tasks)}
    }

}