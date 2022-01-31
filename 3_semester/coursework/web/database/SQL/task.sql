

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



INSERT INTO task (user_id,date_create,last_update) VALUES ($1,$2,$3);
INSERT INTO task_archive (
    task_id,
    title,
    task_text,
    date_completion,
    deadline,
    date_create,
    status) VALUES 
($1,$2,$3,$4,$5,$6,$7);

UPDATE task
SET last_update = $1
WHERE task_id = $2;