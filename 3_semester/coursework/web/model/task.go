package model

import (
	"log"
	"time"

	"github.com/danilbushkov/university/3_semester/coursework/web/database"
)

type Task struct {
	TaskId     int    `json:"task_id"`
	UserId     int    `json:"user_id"`
	DateCreate string `json:"date_create"`
	LastUpdate string `json:"last_update"`
}

type TaskArchive struct {
	TaskArchiveId int    `json:"task_archive_id"`
	TaskId        int    `json:"task_id"`
	Title         string `json:"title"`
	Text          string `json:"text"`
	Status        int    `json:"status"`
	DateCreate    string `json:"date_create"`
}

type TaskJSON struct {
	Id     int    `json:"task_id"`
	Title  string `json:"title"`
	Text   string `json:"text"`
	Status int    `json:"status"`
}

func (t *TaskJSON) UpdateTask(user_id int) int {
	if t.Id == 0 {
		return 14
	}
	if !t.checkExistsTask(user_id) {
		return 12
	}
	if t.Title == "" {
		return 11
	}

	timeNow := time.Now().Format("2006-01-02T15:04:05")

	_, err := database.DB.Exec(`UPDATE task
		SET last_update = $1
		WHERE task_id = $2`, timeNow, t.Id)
	if err != nil {
		return 14
	}

	_, err = database.DB.Exec(`INSERT INTO task_archive (
		task_id,
		title,
		task_text,
		date_create,
		status) VALUES 
		($1,$2,$3,$4,$5);`,
		t.Id,
		t.Title,
		t.Text,
		timeNow,
		t.Status,
	)
	if err != nil {
		log.Print(err)
		return 13
	}
	return 0
}

func DeleteDB(user_id int, task_id int) int {
	if !checkExistsTask(user_id, task_id) {
		return 12
	}
	_, err := database.DB.Exec("DELETE FROM task where task_id = $1", task_id)
	if err != nil {
		return 16
	}
	_, err = database.DB.Exec("DELETE FROM task_archive where task_id = $1", task_id)
	if err != nil {
		return 16
	}
	return 0
}

func (t *TaskJSON) AddDB(user_id int, task_id *int) int {
	if t.Title == "" {
		return 11
	}

	var id int
	timeNow := time.Now().Format("2006-01-02T15:04:05")

	database.DB.QueryRow("INSERT INTO task (user_id,date_create,last_update) VALUES ($1,$2,$3) RETURNING task_id",
		user_id,
		timeNow,
		timeNow,
	).Scan(&id)
	_, err := database.DB.Exec(`INSERT INTO task_archive (
		task_id,
		title,
		task_text,
		date_create,
		status) VALUES 
		($1,$2,$3,$4,$5);`,
		id,
		t.Title,
		t.Text,
		timeNow,
		false,
	)
	if err != nil {
		log.Print(err)
		return 13
	}
	return 0
}

func (t *TaskJSON) checkExistsTask(user_id int) bool {
	var exists bool
	row := database.DB.QueryRow("SELECT EXISTS(SELECT 1 FROM task WHERE user_id=$1 and task_id=$2)",
		user_id, t.Id)
	err := row.Scan(&exists)

	if err != nil {
		log.Fatal(err)
	}
	return exists
}

func checkExistsTask(user_id int, task_id int) bool {
	var exists bool
	row := database.DB.QueryRow("SELECT EXISTS(SELECT 1 FROM task WHERE user_id=$1 and task_id=$2)",
		user_id, task_id)
	err := row.Scan(&exists)

	if err != nil {
		log.Fatal(err)
	}
	return exists
}

//YYYY-MM-DD HH:MM:SS
//2006-01-02T15:04:05
func CheckTime(format, date string) bool {
	t, err := time.Parse(format, date)
	if err != nil {
		return false
	}
	return t.Format(format) == date
}
