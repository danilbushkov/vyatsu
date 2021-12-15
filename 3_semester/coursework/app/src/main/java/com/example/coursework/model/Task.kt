package com.example.coursework.model

data class Task(
    val id: Long,
    val title: String,
    val text: String,
    val date_create: Long,
    val date_change: Long
)