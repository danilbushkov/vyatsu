






--example function
CREATE OR REPLACE FUNCTION test_function(arg1 NUMERIC, arg2 NUMERIC) 
RETURNS NUMERIC
AS $$
    SELECT arg1 + arg2;
$$ LANGUAGE SQL;


------------------------------------------------------------------------




--save account
CREATE OR REPLACE FUNCTION save_account (
    _id BIGINT,
    _login VARCHAR(50),
    _first_name VARCHAR(50),
    _second_name VARCHAR(50),
    _email VARCHAR(50),
    _phone VARCHAR(50),
    _password VARCHAR(255)
)
RETURNS BIGINT
AS $$
DECLARE
    return_id BIGINT;
BEGIN
    IF _id IS NULL THEN
        INSERT INTO account (
            login,
            first_name,
            second_name,
            email,
            phone,
            password
        ) VALUES (
            _login,
            _first_name,
            _second_name,
            _email,
            _phone,
            _password
        ) RETURNING id INTO return_id;

    ELSE
        UPDATE account SET 
            login = _login,
            first_name = _first_name,
            second_name = _second_name,
            email = _email,
            phone = _phone,
            password = _password
        WHERE id = _id;

        return_id := _id;


    END IF;

    RETURN return_id;
END;
$$ LANGUAGE plpgsql;

--example
-- SELECT save_account(
--     NULL,
--     'Pavel',
--     'Pavel',
--     'Pavlov',
--     'pavel@mail.com',
--     '+78888888888',
--     'lkasjdfklkdjaf'
-- );
-- SELECT save_account(
--     3,
--     'Pavel1',
--     'Pavel1',
--     'Pavlov1',
--     'pavel1@mail.com',
--     '+78888888889',
--     'lkasjdfklkdjaff'
-- );


------------------------------------------------------------------------

--delete bot
CREATE OR REPLACE FUNCTION delete_bot(
    _id BIGINT
) RETURNS VOID
AS $$
BEGIN
    DELETE FROM bot WHERE id = _id; 
    
    EXCEPTION
        WHEN foreign_key_violation THEN 
            RAISE EXCEPTION 'Невозможно выполнить удаление, так как есть внешние
        ссылки.';
END;
$$ LANGUAGE plpgsql;

--example
--INSERT INTO bot(name, organization_id) VALUES ('test_bot', 1);

--SELECT delete_bot(1);
--SELECT delete_bot(3);


------------------------------------------------------------------------


--filter subscription
CREATE OR REPLACE FUNCTION filter_subscription_by_cost (
    min_val BIGINT
)
RETURNS SETOF subscription
AS $$
BEGIN
    RETURN QUERY (SELECT * FROM subscription WHERE cost >= min_val);
END;
$$ LANGUAGE plpgsql;

--example
--SELECT * FROM filter_subscription_by_cost(200);


------------------------------------------------------------------------

CREATE TYPE t_subscription AS (
    id BIGINT,
    name VARCHAR(50),
    num_trainings INT
);

CREATE OR REPLACE FUNCTION filter_array_of_subscriptions (
    arr t_subscription[],
    filter_var INTEGER
)
RETURNS t_subscription[]
AS $$
BEGIN
    RETURN ARRAY( 
        SELECT (id, name, num_trainings)::t_subscription
            FROM unnest(arr)
            WHERE num_trainings >= filter_var
    );
END;
$$ LANGUAGE plpgsql;

--example
-- SELECT filter_array_of_subscriptions(
--     ARRAY(SELECT (id, name, num_trainings)::t_subscription FROM subscription),
--     20
-- );


------------------------------------------------------------------------


CREATE TABLE log_gym (
    id BIGSERIAL PRIMARY KEY,
    gym_id BIGINT REFERENCES gym(id),
    change_datetime TIMESTAMP DEFAULT NOW(),
    old_value VARCHAR(50) DEFAULT NULL,
    new_value VARCHAR(50) DEFAULT NULL
);

CREATE OR REPLACE FUNCTION trigger_func()
RETURNS TRIGGER
AS $$
DECLARE
    old_val VARCHAR(50);
BEGIN
    IF (TG_OP = 'UPDATE') THEN
        old_val := OLD.address;
    ELSIF (TG_OP = 'INSERT') THEN
        old_val := NULL;
    END IF;
    INSERT INTO log_gym
        (gym_id, old_value, new_value)
    VALUES
        (NEW.id, old_val, NEW.address);
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER commit_gym_change
    AFTER UPDATE OR INSERT
    ON gym
    FOR EACH ROW
    EXECUTE PROCEDURE trigger_func();


--example
--INSERT INTO gym (name, address, bot_id) VALUES ('gym100', 'address3', 1);
--UPDATE gym SET address = 'address4' WHERE id = 3;

------------------------------------------------------------------------
