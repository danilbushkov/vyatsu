
CREATE TABLE account (
    id BIGSERIAL PRIMARY KEY,
    login VARCHAR(50) UNIQUE NOT NULL,
    first_name VARCHAR(50) NOT NULL,
    second_name VARCHAR(50) NOT NULL,
    email VARCHAR(50) UNIQUE NOT NULL,
    phone VARCHAR(50),
    password VARCHAR(255) UNIQUE NOT NULL
);

CREATE TYPE role_type_enum as enum (
    'creator','admin', 'editor', 'member' 
);

CREATE TABLE organization (
    id BIGSERIAL PRIMARY KEY,
    name VARCHAR(50) UNIQUE NOT NULL,
    email VARCHAR(50) UNIQUE NOT NULL
);



CREATE TABLE account_organization (
    account_id BIGINT NOT NULL,
    organization_id BIGINT NOT NULL,
    role_name role_type_enum NOT NULL DEFAULT 'member',
    PRIMARY KEY(account_id, organization_id),
    FOREIGN KEY(account_id)
        REFERENCES account(id)
        ON DELETE CASCADE,
    FOREIGN KEY(organization_id)
        REFERENCES organization(id)
        ON DELETE CASCADE
);

CREATE TABLE bot (
    id BIGSERIAL PRIMARY KEY,
    name VARCHAR(50) UNIQUE NOT NULL,
    organization_id BIGINT NOT NULL,
    FOREIGN KEY(organization_id)
        REFERENCES organization(id)
        ON DELETE CASCADE
);


CREATE TABLE gym (
    id BIGSERIAL PRIMARY KEY,
    name VARCHAR(50) UNIQUE NOT NULL,
    address VARCHAR(50),
    bot_id BIGINT NOT NULL,
    FOREIGN KEY(bot_id)
        REFERENCES bot(id)
        ON DELETE CASCADE
);

CREATE TABLE subscription (
    id BIGSERIAL PRIMARY KEY,
    name VARCHAR(50) NOT NULL,
    cost INT CHECK (cost >= 0 and cost <= 1000000),
    num_trainings INT CHECK (num_trainings >= 0 and num_trainings <= 1000),
    gym_id BIGINT NOT NULL,
    FOREIGN KEY(gym_id)
        REFERENCES gym(id)
        ON DELETE CASCADE
);

DO LANGUAGE plpgsql $$
DECLARE
    _account_id bigint;
    _organization_id bigint;
    _bot_id bigint;
    _gym_id bigint;
BEGIN
    
    INSERT INTO account(login, first_name, second_name, email, phone, password) 
        VALUES('ivan', 'ivan', 'ivanov', 'ivan@mail.com', '1111111111', '12345678')
        RETURNING id INTO _account_id;

    INSERT INTO organization(name, email) 
        VALUES('organization1', 'organization1@mail.com')
        RETURNING id INTO _organization_id;

    INSERT INTO account_organization(account_id, organization_id, role_name) 
        VALUES(_account_id, _organization_id, 'creator');

    INSERT INTO bot(name, organization_id) 
        VALUES('bot1', _organization_id)
        RETURNING id INTO _bot_id;

    INSERT INTO gym(name, address, bot_id) 
        VALUES('bot1', 'address1',_bot_id)
        RETURNING id INTO _gym_id;


    INSERT INTO subscription(name, cost, num_trainings, gym_id)
        VALUES('test', 100, 10, _bot_id);



    INSERT INTO account(login, first_name, second_name, email, phone, password) 
        VALUES('andrey', 'andrey', 'andrey', 'andrey@mail.com', '2111111111', '22222222')
        RETURNING id INTO _account_id;

    INSERT INTO organization(name, email) 
        VALUES('organization2', 'organization2@mail.com')
        RETURNING id INTO _organization_id;

    INSERT INTO account_organization(account_id, organization_id, role_name) 
        VALUES(_account_id, _organization_id, 'creator');

    INSERT INTO bot(name, organization_id) 
        VALUES('bot2', _organization_id)
        RETURNING id INTO _bot_id;

    INSERT INTO gym(name, address, bot_id) 
        VALUES('bot2', 'address2',_bot_id)
        RETURNING id INTO _gym_id;


    INSERT INTO subscription(name, cost, num_trainings, gym_id)
        VALUES('test', 500, 30, _bot_id);

END ;
$$;

