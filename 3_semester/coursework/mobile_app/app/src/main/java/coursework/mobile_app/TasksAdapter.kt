package coursework.mobile_app


import android.view.LayoutInflater
import android.view.Menu

import android.view.View
import android.view.ViewGroup
import android.widget.PopupMenu


import androidx.recyclerview.widget.RecyclerView
import coursework.mobile_app.model.Task
import coursework.mobile_app.databinding.ItemTaskBinding


interface TaskActionListener {
    fun onTaskClick(task: Task, position: Int)
    //fun onTaskDone(task: Task)
    //fun onTaskNotDone(task: Task)
}

class TasksAdapter(

    private val actionListener: TaskActionListener
) : RecyclerView.Adapter<TasksAdapter.TasksViewHolder>(),View.OnClickListener {

    var tasks: List<Task> = emptyList()
        set(newValue){
            field = newValue
            notifyDataSetChanged()
        }

    override fun onClick(v: View) {

        when(v.id) {
            R.id.more_task -> {
                showPopupMenu(v)
            }
            else -> {
                val task = v.tag as Task
                val position = tasks.indexOfFirst { it.task_id == task.task_id }
                actionListener.onTaskClick(task, position);
            }
        }

    }


    override fun getItemCount(): Int = tasks.size

    override fun onCreateViewHolder(parent: ViewGroup, viewType: Int): TasksViewHolder {
        val inflater = LayoutInflater.from(parent.context)
        val binding = ItemTaskBinding.inflate(inflater, parent, false)

        binding.root.setOnClickListener(this)
        binding.moreTask.setOnClickListener(this)

        return TasksViewHolder(binding)
    }



    override fun onBindViewHolder(holder: TasksViewHolder, position: Int) {

        val task = tasks[position]
        with(holder.binding) {
            holder.itemView.tag = task
            moreTask.tag = task

            taskTitleView.text = task.title//task.title
            taskTextView.text = task.text


            if(task.status) {

            }else{

            }
        }



    }



    private fun showPopupMenu(view: View){
        val popupMenu = PopupMenu(view.context, view)
        val context = view.context
        val task = view.tag as Task
        val position = tasks.indexOfFirst { it.task_id == task.task_id }



        if(!task.status) {

            popupMenu.menu.add(0, ID_DONE, Menu.NONE,"Выполнено")
        }else{
            popupMenu.menu.add(0, ID_NOT_DONE, Menu.NONE,"Не выполнено")
        }
        popupMenu.setOnMenuItemClickListener {
            when(it.itemId){
                ID_DONE -> {
                    //actionListener.onTaskDone(task)
                }
                ID_NOT_DONE -> {
                    //actionListener.onTaskNotDone(task)
                }else -> {

            }
            }
            return@setOnMenuItemClickListener true
        }


        popupMenu.show()




    }


    class TasksViewHolder(
        val binding: ItemTaskBinding
    ) : RecyclerView.ViewHolder(binding.root)

    companion object {
        private const val ID_DONE = 1
        private const val ID_NOT_DONE = 2
    }
}