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
	TaskArchiveId  int    `json:"task_archive_id"`
	TaskId         int    `json:"task_id"`
	Title          string `json:"title"`
	Text           string `json:"text"`
	DateCompletion string `json:"date_completion"`
	Deadline       string `json:"deadline"`
	Status         int    `json:"status"`
	DateCreate     string `json:"date_create"`
}

type TaskJSON struct {
	Title    string `json:"title"`
	Text     string `json:"text"`
	Deadline string `json:"deadline"`
	Status   int    `json:"status"`
}

func (t *TaskJSON) AddDB(user_id int) int {
	if t.Title == "" {
		return 11
	}

	if t.Deadline != "" && !CheckTime("2006-01-02T15:04:05", t.Deadline) {
		return 12
	}

	var id int
	timeNow := time.Now().Format("2006-01-02T15:04:05")

	database.DB.QueryRow("INSERT INTO task (user_id,date_create,last_update) VALUES ($1,$2,$3)",
		user_id,
		timeNow,
		timeNow,
	).Scan(&id)
	_, err := database.DB.Exec(`INSERT INTO task_archive (
		task_id,
		title,
		task_text,
		date_completion,
		deadline,
		date_create,
		status) VALUES 
		($1,$2,$3,$4,$5,$6,$7);`,
		id,
		t.Title,
		t.Text,
		nil,
		nil,
		timeNow,
		false,
	)
	if err != nil {
		log.Print(err)
		return 13
	}
	return 0
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
