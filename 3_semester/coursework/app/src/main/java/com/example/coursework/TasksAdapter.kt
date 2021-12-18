package com.example.coursework

import android.annotation.SuppressLint
import android.util.Log
import android.view.LayoutInflater
import android.view.Menu

import android.view.View
import android.view.ViewGroup
import android.widget.PopupMenu
import android.content.res.Resources
import android.graphics.Color

import androidx.recyclerview.widget.RecyclerView
import com.example.coursework.model.Task
import com.example.coursework.databinding.ItemTaskBinding
import java.lang.Byte.decode

//import Log



interface TaskActionListener {
    fun onTaskClick(task:Task,position: Int)
    fun onTaskDone(task: Task)
    fun onTaskNotDone(task: Task)
}

class TasksAdapter(
    val colorLine: Int,
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
                val position = tasks.indexOfFirst { it.id == task.id }
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
        //Log.d("asd",position.toString())
        //holder.binding.taskTextView.text="100"
        val task = tasks[position]
        with(holder.binding) {
            holder.itemView.tag = task
            moreTask.tag = task

            taskTitleView.text = task.title//task.title
            taskTextView.text = task.text

            if(task.done) {
                taskLine.setBackgroundColor(colorLine)
            }
        }



    }



    private fun showPopupMenu(view: View){
        val popupMenu = PopupMenu(view.context, view)
        val context = view.context
        val task = view.tag as Task
        val position = tasks.indexOfFirst { it.id == task.id }

        if(!task.done) {
            popupMenu.menu.add(0, ID_DONE, Menu.NONE, context.getString(R.string.done))
        }else{
            popupMenu.menu.add(0, ID_NOT_DONE, Menu.NONE, context.getString(R.string.not_done))
        }
        popupMenu.setOnMenuItemClickListener {
            when(it.itemId){
                ID_DONE -> {
                    actionListener.onTaskDone(task)
                }
                ID_NOT_DONE -> {
                    actionListener.onTaskNotDone(task)
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