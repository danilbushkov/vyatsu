SELECT * FROM account;
SELECT id FROM organization WHERE name='organization1';
SELECT name, cost FROM subscription;


CREATE OR REPLACE VIEW view_organization_creators AS
    SELECT  
            a.login creator_login, 
            o.name organization_name, 
            a.first_name creator_name, 
            a.email creator_email, 
            a.phone creator_phone
        FROM account_organization ao 
        INNER JOIN account a ON ao.account_id=a.id
        INNER JOIN organization o ON ao.organization_id=o.id
        WHERE ao.role_name = 'creator';


CREATE OR REPLACE VIEW view_organizaton_bots AS
    SELECT  
            b.name bot_name, 
            o.name organization_name,
            o.email organization_email

        FROM bot b 
        INNER JOIN organization o ON b.organization_id=o.id;

        

CREATE OR REPLACE VIEW view_subscription_cost AS
    (SELECT  'Минимальное значение', cost, id FROM subscription 
        ORDER BY cost LIMIT 1)
    UNION ALL
    (SELECT  'Максимальное значение', cost, id FROM subscription 
        ORDER BY cost DESC LIMIT 1)
    UNION ALL
    (SELECT  'Среднее значение', avg(cost), NULL FROM subscription)
    UNION ALL
    (SELECT  'Сумма значений', sum(cost), NULL FROM subscription);


   


