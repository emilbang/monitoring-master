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

Deploy by running

```shell
$ make deploy
```

To get debug output run
```shell
$ make run
```

The Chronograf interface will then be available on port 6088.

## Dependencies
* **make**
* **docker**
* **docker-compose**
