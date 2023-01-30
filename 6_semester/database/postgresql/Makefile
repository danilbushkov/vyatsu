all: run

run: build
	docker run \
		--rm \
		--name postgres1 \
		-v $(PWD)/pgdata:/var/lib/postgresql/data \
		-p 5432:5432 \
		-d \
		postgres_test
		

build:	
	docker build -t postgres_test .

rm:
	rm -r pgdata/

start:
	docker container start postgres1

stop: 
	docker container stop postgres1

psql:
	psql -h 127.0.0.1 -p 5432 -U testuser -d testdb




