# monitoring-master

An easily configurable containerized Tick stack, for doing server monitoring.
Comes bundled with a telegraf instance to monitor the master-node.

Use [monitoring-slave](https://github.com/frederiksberg/monitoring-slave) to deploy slave nodes to other servers.

To deploy, clone this repo.

```shell
$ git clone https://github.com/frederiksberg/monitoring-master
```

Create a .env file with node intrinsics.

```shell
$ cp example.env .env
$ vim .env
```

You will need to edit the nginx config file found in **./nginx/nginx/**. Ours is called monitor.smartcityfrb.dk.conf, the name is not important but it is convention to name it after your domain.

Inside this file you will need to change server_name to whatever your domain is. It **NEEDS** to be a fully qualified domain, as letsencrypt do not issue certificates to raw ip adresses.

First time you run a new deployment you will need to generate new SSL-certs.

Do this be starting the reverse proxy.

```shell
$ docker-compose up nginx
```

Wait for nginx to generate Diffie Helman keys. This should be apparent by the output.

Once done keep this terminal running while executing this command in a seperate shell.

```shell
$ docker exec -it monitoring-master_nginx_1 /bin/sh
```

Where you replace *monitoring-master_nginx_1* with what your container is called.

You are now inside the running container, from here you can run certbot to get your certificate.

```shell
# certbot
```

Give it an email address and select the domain ypu specified in the nginx .conf file. When asked if you want to redirect traffic select option 2: redirect.

Once done shut down everything and deploy by running
```shell
$ make deploy
```

To get debug output run
```shell
$ make run
```

Note that the service won't be available until nginx has generated new Diffie Helman keys, this might take few minutes.

The Chronograf interface will then be available the root endpoint.

## Dependencies
* **make**
* **docker**
* **docker-compose**
