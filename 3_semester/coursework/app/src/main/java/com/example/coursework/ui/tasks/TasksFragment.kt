package com.example.coursework.ui.tasks



import android.os.Bundle
import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup

import androidx.fragment.app.Fragment

import com.example.coursework.App


import com.example.coursework.TasksAdapter
import com.example.coursework.databinding.FragmentTasksBinding

class TasksFragment : Fragment() {

    private lateinit var tasksViewModel: TasksViewModel
    //private var _binding: FragmentTasksBinding? = null
    private lateinit var adapter: TasksAdapter
    //private var state = TasksService()

    // This property is only valid between onCreateView and
    // onDestroyView.
    //private val binding get() = _binding!!

    override fun onCreateView(
        inflater: LayoutInflater,
        container: ViewGroup?,
        savedInstanceState: Bundle?
    ): View? {
//        tasksViewModel =
//            ViewModelProvider(this).get(TasksViewModel::class.java)
        //val root: View = inflater.inflate(R.layout.fragment_tasks,container,false)
        //var r = view.findViewById(R.id.recycler_tasks)
        var binding = FragmentTasksBinding.inflate(inflater,container,false)
//        //val
        var state = (activity?.applicationContext as App).tasksService
//
        adapter = TasksAdapter(state.getTasks())
        //val layoutManager = LinearLayoutManager(this)
        //binding.recyclerTasks.layoutManager = layoutManager
        binding.recyclerTasks.adapter = adapter




        //val textView: TextView = binding
//        tasksViewModel.text.observe(viewLifecycleOwner, Observer {
//            //textView.text = it
//        })
        return binding.root
    }

    override fun onDestroyView() {
        super.onDestroyView()
        //binding = null
    }
}