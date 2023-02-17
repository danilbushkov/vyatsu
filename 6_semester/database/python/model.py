



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
        return self.db.insert(
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
    