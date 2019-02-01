MAKEFLAGS += --silent

clean:
	docker-compose rm -f

build: clean
	docker build -t frbsc/monitoring:influxdb -f ./influxdb.Dockerfile ./influxdb
	docker build -t frbsc/monitoring:kapacitor -f ./kapacitor.Dockerfile ./kapacitor
	docker build -t frbsc/monitoring:chronograf -f ./chronograf.Dockerfile ./chronograf

run: build
	docker-compose up

deploy: build
	docker-compose up -d
	cd ./monitoring-slave; make deploy