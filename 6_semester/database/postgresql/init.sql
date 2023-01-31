
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
    'admin', 'editor', 'member' 
);

CREATE TABLE organization (
    id BIGSERIAL PRIMARY KEY,
    name VARCHAR(50) UNIQUE NOT NULL,
    email VARCHAR(50) UNIQUE NOT NULL
);



CREATE TABLE user_organization (
    user_id BIGINT NOT NULL,
    organization_id BIGINT NOT NULL,
    role_name role_type_enum NOT NULL DEFAULT 'member',
    PRIMARY KEY(user_id, organization_id),
    FOREIGN KEY(user_id)
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
    name VARCHAR(50) UNIQUE NOT NULL,
    cost INT CHECK (cost >= 0 and cost <= 1000000),
    num_trainings INT CHECK (num_trainings >= 0 and num_trainings <= 1000),
    gym_id BIGINT NOT NULL,
    FOREIGN KEY(gym_id)
        REFERENCES gym(id)
        ON DELETE CASCADE
);

