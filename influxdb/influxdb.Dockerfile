FROM influxdb:latest

COPY ./influxdb.conf /etc/influxdb/influxdb.conf

ONBUILD RUN influx -execute 'CREATE USER ${USERNAME} WITH PASSWORD "${PASSWORD}" WITH ALL PRIVILEGES'
