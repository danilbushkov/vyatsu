package coursework.mobile_app.model


typealias TasksListener = (tasks: List<Task>) -> Unit

class TasksService {

    private var tasks = mutableListOf<Task>()

    private val listeners = mutableSetOf<TasksListener>()

    init{
        //tasks=getTestTasks().toMutableList()

    }
    fun getTasks():List<Task>{
        return tasks
    }
    fun setTasks(tasks: MutableList<Task>){
        this.tasks = tasks
        notifyChanges()
    }

    fun addTask(task:Task){
        tasks.add(task)

    }

    fun getTaskById(id: Int):Task{
        return tasks.first { it.task_id == id }
    }

    fun done(task:Task){
        task.status=true
        notifyChanges()
    }
    fun  notDone(task: Task){
        task.status=false
        notifyChanges()
    }
    fun deleteTask(task:Task){
        tasks.remove(task)
        notifyChanges()
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