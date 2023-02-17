



class Model:

    def __init__(self, db):
        self.db = db
        
    def get_subscriptions(self):
        return self.db.select(
        ''' 
            SELECT 
                s.id,
                s.name, 
                s.cost, 
                s.num_trainings, 
                g.name 
            FROM 
                subscription s 
            INNER JOIN 
                gym g 
            ON 
                s.gym_id = g.id 
            
        '''
        )

    def add_subscription(self, subscription):
        return self.db.execute(
        '''
            INSERT INTO subscription (name, cost, num_trainings, gym_id) 
            VALUES (%s, %s, %s, %s)
        ''',
        subscription
        )

    def get_gyms(self):
        return self.db.select(
        ''' 
            SELECT 
                id,
                name
            FROM 
                gym 
            
        '''
        )

    def delete_subscription(self, id):
        return self.db.execute(
            '''
            DELETE FROM subscription WHERE id=%s
            ''',
            (id,)
        )

    def update_subscription(self, subscription):
        return self.db.execute(
        '''
            UPDATE subscription 
            SET 
                name = %s, 
                cost = %s, 
                num_trainings = %s, 
                gym_id = %s 
            WHERE id = %s
        ''',
        subscription
        )

    def get_filter_subscriptions(self, filter):
        return self.db.select(
        ''' 
            SELECT 
                s.id,
                s.name, 
                s.cost, 
                s.num_trainings, 
                g.name 
            FROM 
                subscription s 
            INNER JOIN 
                gym g 
            ON 
                s.gym_id = g.id 
            WHERE s.cost >= %s AND s.cost <= %s
        ''',
        filter
        )