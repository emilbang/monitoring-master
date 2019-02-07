MAKEFLAGS += --silent

clean:
	docker-compose rm -f

build: clean
	docker build -t frbsc/monitoring:telegraf -f ./Dockerfile ./telegraf

run: build
	docker-compose up

deploy: build
	docker-compose up -d