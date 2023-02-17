



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
    