CREATE TABLE IF NOT EXISTS users (
    id serial PRIMARY KEY,
    login VARCHAR ( 50 ) UNIQUE NOT NULL,
    password VARCHAR ( 50 ) NOT NULL
);


/*Добавление пользователя*/
INSERT INTO users (login,password) VALUES ($1,$2);

SELECT EXISTS(SELECT id FROM users WHERE login=$1);

SELECT id FROM users WHERE login=$1 AND password=$2;