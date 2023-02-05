



--setof subscription

-- struct

--log gym

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
SELECT save_account(
    NULL,
    'Pavel',
    'Pavel',
    'Pavlov',
    'pavel@mail.com',
    '+78888888888',
    'lkasjdfklkdjaf'
);
SELECT save_account(
    3,
    'Pavel1',
    'Pavel1',
    'Pavlov1',
    'pavel1@mail.com',
    '+78888888889',
    'lkasjdfklkdjaff'
);


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
INSERT INTO bot(name, organization_id) VALUES ('test_bot', 1);

SELECT delete_bot(1);
SELECT delete_bot(3);


------------------------------------------------------------------------


