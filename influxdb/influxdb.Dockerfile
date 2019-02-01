ARG user
ARG pwd

FROM influxdb:latest

COPY ./influxdb.conf /etc/influxdb/influxdb.conf

ONBUILD RUN influx -execute 'CREATE USER ${user} WITH PASSWORD "${pwd}" WITH ALL PRIVILEGES'
