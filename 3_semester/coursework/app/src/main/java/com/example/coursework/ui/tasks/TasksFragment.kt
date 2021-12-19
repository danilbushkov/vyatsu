package com.example.coursework.ui.tasks



import android.content.Intent
import android.os.Build
import android.os.Bundle
import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import androidx.annotation.RequiresApi

import androidx.fragment.app.Fragment
import com.example.coursework.*


import com.example.coursework.databinding.FragmentTasksBinding
import com.example.coursework.model.Task
import com.example.coursework.model.TasksListener
import com.example.coursework.model.TasksService

class TasksFragment : Fragment() {

    private lateinit var tasksViewModel: TasksViewModel
    //private var _binding: FragmentTasksBinding? = null
    private lateinit var adapter: TasksAdapter
    private val tasksService:TasksService
        get() = (activity?.applicationContext as App).tasksService
    //private var state = TasksService()

    // This property is only valid between onCreateView and
    // onDestroyView.
    //private val binding get() = _binding!!


    override fun onCreateView(
        inflater: LayoutInflater,
        container: ViewGroup?,
        savedInstanceState: Bundle?
    ): View? {

        var binding = FragmentTasksBinding.inflate(inflater,container,false)

        val color = resources.getColor(R.color.green)
        val colorMain = resources.getColor(R.color.main)
        adapter = TasksAdapter(color,colorMain,object:  TaskActionListener{
            override fun onTaskClick(task: Task, position: Int){
                val intent = Intent(activity,EditTaskActivity::class.java)
                intent.putExtra("taskId",task.id)
                intent.putExtra("taskPosition",position)
                startActivity(intent)
            }
            override  fun onTaskDone(task:Task){
                tasksService.doneTask(task)
            }
            override fun onTaskNotDone(task:Task){
                tasksService.notDoneTask(task)
            }

        })

        binding.recyclerTasks.adapter = adapter



        tasksService.addListener(tasksListener)

        return binding.root
    }

    override fun onDestroyView() {
        super.onDestroyView()
        tasksService.removeListener(tasksListener)
        //binding = null
    }
    private val tasksListener: TasksListener = {
        adapter.tasks = it
    }

}