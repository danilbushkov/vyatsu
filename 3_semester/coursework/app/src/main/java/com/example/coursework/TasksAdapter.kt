package com.example.coursework

import android.util.Log
import android.view.LayoutInflater

import android.view.View
import android.view.ViewGroup

import androidx.recyclerview.widget.RecyclerView
import com.example.coursework.model.Task
import com.example.coursework.databinding.ItemTaskBinding
//import Log



interface TaskActionListener {
    fun onTaskClick(task:Task,position: Int)
}

class TasksAdapter(
    private val tasks: List<Task>,
    private val actionListener: TaskActionListener
) : RecyclerView.Adapter<TasksAdapter.TasksViewHolder>() {




//    override fun onClick(v: View?) {
//       onClickL
//
//    }


    override fun getItemCount(): Int = tasks.size

    override fun onCreateViewHolder(parent: ViewGroup, viewType: Int): TasksViewHolder {
        val inflater = LayoutInflater.from(parent.context)
        val binding = ItemTaskBinding.inflate(inflater, parent, false)

        return TasksViewHolder(binding)
    }

    override fun onBindViewHolder(holder: TasksViewHolder, position: Int) {
        Log.d("asd",position.toString())
        //holder.binding.taskTextView.text="100"
        val task = tasks[position]
        with(holder.binding) {
            holder.itemView.tag = task

            taskTitleView.text = task.title//task.title
            taskTextView.text = task.text

        }

        holder.itemView.setOnClickListener {
            actionListener.onTaskClick(task,position);
        }

    }


    class TasksViewHolder(
        val binding: ItemTaskBinding
    ) : RecyclerView.ViewHolder(binding.root)


}