package com.example.coursework.model

data class Task(
    val id: Long,
    var title: String,
    var text: String,
    var date_create: String,
    var date_change: String,
    var deadline: String,
    var date_done: String,
    var done: Boolean

)