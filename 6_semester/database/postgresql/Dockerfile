FROM postgres:15.1-alpine


ENV POSTGRES_PASSWORD=testpassword \ 
    POSTGRES_DB=testdb \
    POSTGRES_USER=testuser 

COPY ./*.sql /docker-entrypoint-initdb.d/init.sql