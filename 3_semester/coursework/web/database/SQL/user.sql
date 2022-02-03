CREATE TABLE IF NOT EXISTS users (
    id serial PRIMARY KEY,
    login VARCHAR ( 50 ) UNIQUE NOT NULL,
    password VARCHAR ( 50 ) NOT NULL
);

CREATE TABLE IF NOT EXISTS task (
    task_id serial PRIMARY KEY,
	user_id integer NOT NULL,
	date_create timestamp NOT NULL,
	last_update timestamp NOT NULL
);
CREATE TABLE IF NOT EXISTS task_archive (
    task_archive_id serial PRIMARY KEY,
	task_id integer NOT NULL,
    title VARCHAR(100) NOT NULL,
    task_text TEXT,
	date_create timestamp NOT NULL,
	status boolean
);
/*YYYY-MM-DD HH:MM:SS*/


/*Добавление пользователя*/
INSERT INTO users (login,password) VALUES ($1,$2);

SELECT EXISTS(SELECT id FROM users WHERE login=$1);

SELECT id FROM users WHERE login=$1 AND password=$2;

INSERT INTO task (user_id,date_create,last_update) VALUES ($1,$2,$3);
INSERT INTO task_archive (
    task_id,
    title,
    task_text,
    date_create,
    status) VALUES 
($1,$2,$3,$4,$5);