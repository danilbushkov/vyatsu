package com.example.coursework.db

import android.content.Context
import android.database.sqlite.SQLiteDatabase
import android.database.sqlite.SQLiteOpenHelper

class DatabaseHelper(context: Context) : SQLiteOpenHelper(context, DATABASE_NAME,null, SCHEMA) {
    override fun onCreate(db: SQLiteDatabase){
        db.execSQL(SQL_CREATE_TASKS)
    }

    override fun onUpgrade(db:SQLiteDatabase, oldVersion:Int, newVersion:Int){
        db.execSQL(SQL_DELETE_TASKS)
        onCreate(db)
    }
    override fun onDowngrade(db:SQLiteDatabase, oldVersion: Int, newVersion: Int){
        onUpgrade(db,oldVersion,newVersion)
    }


    companion object {
        //База данных
        private const val DATABASE_NAME = "coursework.db"
        private const val SCHEMA = 1
        const val TABLE = "tasks"
        //Данные таблицы
        public const val COLUMN_ID = "id"
        public const val COLUMN_TITLE = "title"
        public const val COLUMN_TEXT = "text"
        public const val COLUMN_DATE_CREATE = "date_create"
        public const val COLUMN_DATE_UPDATE = "date_update"
        public const val COLUMN_DATE_DEADLINE = "date_deadline"
        public const val COLUMN_DATE_DONE = "date_done"
        public const val COLUMN_DONE = "done"
        //Запросы
        private const val SQL_CREATE_TASKS =
            "CREATE TABLE IF NOT EXISTS ${TABLE} (" +
                    "${COLUMN_ID} INTEGER PRIMARY KEY,"+
                    "${COLUMN_TITLE} TEXT,"+
                    "${COLUMN_TEXT} TEXT," +
                    "${COLUMN_DATE_CREATE} TEXT,"+
                    "${COLUMN_DATE_UPDATE} TEXT," +
                    "${COLUMN_DATE_DEADLINE} TEXT,"+
                    "${COLUMN_DATE_DONE} TEXT," +
                    "${COLUMN_DONE} INTEGER)"
        private  const val SQL_DELETE_TASKS = "DROP TABLE IF EXISTS ${TABLE}"
    }
}