package com.example.coursework.ui.tasks

import androidx.lifecycle.LiveData
import androidx.lifecycle.MutableLiveData
import androidx.lifecycle.ViewModel


    class TasksViewModel : ViewModel() {

        private val _text = MutableLiveData<String>().apply {
            value = "This is task Fragment"
        }
        val text: LiveData<String> = _text
    }
