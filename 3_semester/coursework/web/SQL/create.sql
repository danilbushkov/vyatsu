CREATE TABLE IF NOT EXISTS table_name (
    id serial PRIMARY KEY,
    login VARCHAR ( 50 ) UNIQUE NOT NULL,
    password VARCHAR ( 50 ) NOT NULL
);