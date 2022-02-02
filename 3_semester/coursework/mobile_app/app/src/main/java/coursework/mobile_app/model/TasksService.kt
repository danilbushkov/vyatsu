package coursework.mobile_app.model


typealias TasksListener = (tasks: List<Task>) -> Unit

class TasksService {

    private var tasks = mutableListOf<Task>()

    private val listeners = mutableSetOf<TasksListener>()

    init{
        tasks=getTestTasks().toMutableList()

    }
    fun getTasks():List<Task>{
        return tasks
    }

    fun addTasks(task:Task){
        tasks.add(task)
        notifyChanges()
    }

    fun getTaskById(id: Int):Task{
        return tasks.first { it.task_id == id }
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



    private fun getTestTasks():List<Task>{
        var tasks = mutableListOf<Task>()
        tasks = (1..10).map{
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
}