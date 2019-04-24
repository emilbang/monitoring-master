# monitoring-master

An easily configurable containerized Tick stack, for doing server monitoring.
Comes bundled with a telegraf instance to monitor the master-node.

Use [monitoring-slave](https://github.com/frederiksberg/monitoring-slave) to deploy slave nodes to other servers.

To deploy, clone this repo.

```console
$ git clone https://github.com/frederiksberg/monitoring-master
```

Create a .env file with node intrinsics.

```console
$ cp example.env .env
$ vim .env
```
If you do not wish to run github authentication, you will only need to specify DB_USER and DB_PWD.

You will need to edit the nginx config file found in **./nginx/nginx/**. Ours is called monitor.smartcityfrb.dk.conf, the name is not important but it is convention to name it after your domain.

Inside this file you will need to change server_name to whatever your domain is. It **NEEDS** to be a fully qualified domain, as letsencrypt do not issue certificates to raw ip adresses.

First time you run a new deployment you will need to generate new SSL-certs.

Do this by starting the reverse proxy.

```console
$ docker-compose up nginx
```

Wait for nginx to generate Diffie Helman keys. This should be apparent by the output.

Once done keep this terminal running while executing this command in a seperate shell.

```console
$ docker exec -it monitoring-master_nginx_1 /bin/sh
```

Where you replace *monitoring-master_nginx_1* with what your container is called.

You are now inside the running container, from here you can run certbot to get your certificate.

```console
# certbot
```

Give it an email address and select the domain you specified in the nginx .conf file. When asked if you want to redirect traffic select option 2: redirect.

Once done shut down everything by running
```console
$ make kill
```

You can then deploy by running
```console
$ make deploy
```

To get debug output run
```console
$ make run
```

Note that the service won't be available until nginx has generated new Diffie Helman keys, this might take a few minutes.

The Chronograf interface will then be available on the root endpoint.

Do note, that if runnning with github authentication an influx and kapacitor connection will not be set up for you.
And you will need to do this manually. To read more about setting up github auth see: [This link][Chronograf docs](https://docs.influxdata.com/chronograf/v1.7/administration/managing-security/#configuring-github-authentication).

If you don't want to use github auth, comment out this line from docker-compose.yml:
```yml
      - 'TOKEN_SECRET=${TOKEN_SECRET}'
```

## Dependencies
* **make**
* **docker**
* **docker-compose**
