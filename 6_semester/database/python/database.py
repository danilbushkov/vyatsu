import psycopg2


class DataBase:

    def __init__(self):
        self.conn = None

    def connect(self, config):
        try:
            self.conn = psycopg2.connect(
                dbname=config["db"]["dbname"], 
                host=config["db"]["host"], 
                user=config["db"]["user"], 
                password=config["db"]["password"], 
                port=config["db"]["port"]
            )
        except:
            return False

        return True

    def select(self, query, values=None):
        if self.conn:
            data = []
            try:
                cursor = self.conn.cursor()
                cursor.execute(query, values)
                for row in cursor.fetchall():
                    data.append(row);

                cursor.close()
            except BaseException as e:
                print(e)
                return ([], False)

            return (data, True)

    
    def execute(self, query, data=None):
        if self.conn:
            try:
                cursor = self.conn.cursor()
                cursor.execute(query, data) 
                self.conn.commit()
                cursor.close()  
            except:
                return False

            return True
        
    
    
        

    def close(self):
        if self.conn:
            self.conn.close()