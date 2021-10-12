## rust constants
rust_cname := rust_dev
rust_workdir := /home
ifeq ($(rust_port),)
rust_port := 1111
endif
ifeq ($(rust_image),)
rust_image := rust:alpine
endif


## go constants
go_cname := go_dev
go_workdir := /go/src/github.com/abmamo
ifeq ($(go_port),)
go_port := 2222
endif
ifeq ($(go_image),)
go_image := golang:latest
endif


## linux constants
linux_cname := linux_dev
linux_workdir := /home
ifeq ($(linux_port),)
linux_port := 3333
endif
ifeq ($(linux_image),)
linux_image := ubuntu:latest
endif


## haskell constants
haskell_cname := haskell_dev
haskell_workdir := /home
ifeq ($(haskell_port),)
haskell_port := 4444
endif
ifeq ($(haskell_image),)
haskell_image := haskell:latest
endif

## node constants
node_cname := node_dev
node_workdir := /home
ifeq ($(node_port),)
node_port := 5555
endif
ifeq ($(node_image),)
node_image := node:latest
endif


## python constants
py_cname := py_dev
py_workdir := /home
ifeq ($(py_port),)
py_port := 6666
endif
ifeq ($(py_image),)
py_image := python:latest
endif


## java constants
java_cname := java_dev
java_workdir := /home
ifeq ($(java_port),)
java_port := 7777
endif
ifeq ($(java_image),)
java_image := openjdk:alpine
endif

## registry constants
registry_cname := registry_dev
registry_workdir := /home
ifeq ($(registry_port),)
registry_port := 5000
endif
ifeq ($(registry_image),)
registry_image := registry:latest
endif

## prometheus constants
prometheus_cname := prometheus_dev
prometheus_workdir := /prometheus
ifeq ($(prometheus_port),)
prometheus_port := 9090
endif
ifeq ($(prometheus_image),)
prometheus_image := prom/prometheus:latest
endif


## mongo constants
mongo_cname := mongo_dev
mongo_workdir := /home
ifeq ($(mongo_port),)
mongo_port := 27017
endif
ifeq ($(mongo_image),)
mongo_image := mongo:latest
endif
ifeq ($(mongo_user),)
mongo_user := abenezer
endif
ifeq ($(mongo_pass),)
mongo_pass := pw
endif
mongo_uri := mongodb://${mongo_user}:${mongo_pass}@localhost:${mongo_port}

## redis constants
redis_cname := redis_dev
redis_workdir := /home
ifeq ($(redis_port),)
redis_port := 27017
endif
ifeq ($(redis_image),)
redis_image := bitnami/redis:latest
endif
ifeq ($(redis_user),)
redis_user := abenezer
endif
ifeq ($(redis_pass),)
redis_pass := pw
endif
redis_uri := redis://:${redis_pass}@localhost:${redis_port}


## postgres constants
ifeq ($(pg_db),)
pg_db := pg_dev
endif
ifeq ($(pg_user),)
pg_user := abenezer
endif
ifeq ($(pg_pass),)
pg_pass := pw
endif
ifeq ($(pg_host),)
pg_host := localhost
endif
ifeq ($(pg_port),)
pg_port := 5432
endif
ifeq ($(pg_cname),)
pg_cname := pg_dev
endif
ifeq ($(pg_image),)
pg_image := postgres:latest
endif
pg_uri := postgresql://${pg_user}:${pg_pass}@${pg_host}:${pg_port}/${pg_db}

## mysql constants
ifeq ($(mysql_db),)
mysql_db := mysql_dev
endif
ifeq ($(mysql_user),)
mysql_user := abenezer
endif
ifeq ($(mysql_pass),)
mysql_pass := pw
endif
ifeq ($(mysql_rpass),)
mysql_rpass := rpw
endif
ifeq ($(mysql_host),)
mysql_host := localhost
endif
ifeq ($(mysql_port),)
mysql_port := 3306
endif
ifeq ($(mysql_cname),)
mysql_cname := mysql_dev
endif
ifeq ($(mysql_image),)
mysql_image := mysql:8.0
endif
mysql_uri := mysql://${mysql_user}:${mysql_pass}@${mysql_host}:${mysql_port}/${mysql_db}

help:
	@echo "list of available commands"
	@echo
	@echo "go               - create a go dev env in a docker container"
	@echo "rust             - create a rust dev env in a docker container"
	@echo "haskell          - create a haskell dev env in a docker container"
	@echo "python           - create a python dev env in a docker container"
	@echo "node             - create a node dev env in a docker container"
	@echo "linux            - create a linux dev env in a docker container"
	@echo "java             - create a openjdk [java] dev env in a docker container"
	@echo "registry         - create a dev registry in a docker container"
	@echo "prometheus       - create a dev prometheus in a docker container"
	@echo 
	@echo "mongo"
	@echo "mongo-create     - create a mongodb dev db in a docker container"
	@echo "mongo-shell      - create a mongodb dev db in a docker container"
	@echo "mongo-uri        - get a mongodb db connection uri"
	@echo
	@echo "redis"
	@echo "redis-create     - create a redis dev db in a docker container"
	@echo "redis-shell      - create a redis dev db in a docker container"
	@echo "redis-uri        - get a redis connection uri"
	@echo
	@echo "postgres"
	@echo "pg-start         - start a postgres db running in a docker container"
	@echo "pg-stop          - stop postgres db running in a docker container"
	@echo "pg-restart       - restart postgres db running in a docker container"
	@echo "pg-purge         - stop & remove postgres db running in a docker container"
	@echo "pg-shell         - access postgres shell using psql"
	@echo "pg-uri           - get postgres db connection uri"
	@echo
	@echo "mysql"
	@echo "mysql-start      - start a mysql db running in a docker container"
	@echo "mysql-stop       - stop dev mysql db running in a docker container"
	@echo "mysql-restart    - restart mysql db running in a docker container"
	@echo "mysql-purge      - stop & remove mysql db running in a docker container"
	@echo "mysql-shell      - access mysql shell using mysql-admin"
	@echo "mysql-uri        - get mysql db connection uri"

go:
	@echo "spawing: go"
	@docker run --rm -it --name ${go_cname} -p ${go_port}:${go_port} -v /var/run/docker.sock:/var/run/docker.sock -v $(CURDIR)/data/go/:${go_workdir} -w ${go_workdir} ${go_image}

rust:
	@echo "spawing: rust"
	@docker run --rm -it --name ${rust_cname} -p ${rust_port}:${rust_port} -v /var/run/docker.sock:/var/run/docker.sock -v $(CURDIR)/data/rust/:${rust_workdir} -w ${rust_workdir} ${rust_image}

haskell:
	@echo "spawing: haskell"
	@docker run --rm -it --name ${haskell_cname} -p ${haskell_port}:${haskell_port} -v /var/run/docker.sock:/var/run/docker.sock -v $(CURDIR)/data/haskell/:${haskell_workdir} -v $(CURDIR)/scripts/startup/:/home/scripts -w ${haskell_workdir} ${haskell_image} bash

python:
	@echo "spawing: python"
	@docker run --rm -it --name ${py_cname} -p ${py_port}:${py_port} -v /var/run/docker.sock:/var/run/docker.sock -v $(CURDIR)/data/py/:${py_workdir} -v $(CURDIR)/scripts/startup/:/home/scripts -w ${py_workdir} ${py_image} bash

node:
	@echo "spawing: node"
	@docker run --rm -it --name ${node_cname} -p ${node_port}:${node_port} -v /var/run/docker.sock:/var/run/docker.sock -v $(CURDIR)/data/node/:${node_workdir} -v $(CURDIR)/scripts/startup/:/home/scripts -w ${node_workdir} ${node_image} bash

linux:
	@echo "spawing: linux"
	@docker run --rm -it --name ${linux_cname} -p ${linux_port}:${linux_port} -v /var/run/docker.sock:/var/run/docker.sock -v $(CURDIR)/data/linux/:${linux_workdir} -v $(CURDIR)/scripts/startup/:/home/scripts -w ${linux_workdir} ${linux_image}

java:
	@echo "spawing: java"
	@docker run --rm -it --name ${java_cname} -p ${java_port}:${java_port} -v /var/run/docker.sock:/var/run/docker.sock -v $(CURDIR)/data/java/:${java_workdir} -v $(CURDIR)/scripts/startup/:/home/scripts -w ${java_workdir} ${java_image}

registry:
	@echo "spawing: registry"
	@docker run --rm -it --name ${registry_cname} -p ${registry_port}:${registry_port} -v /var/run/docker.sock:/var/run/docker.sock -v $(CURDIR)/data/registry/:${registry_workdir} -v $(CURDIR)/scripts/startup/:/home/scripts -w ${registry_workdir} ${registry_image}

prometheus:
	@echo "spawing: prometheus"
	@docker run --rm -it --name ${prometheus_cname} -p ${prometheus_port}:${prometheus_port} -v /var/run/docker.sock:/var/run/docker.sock -v $(CURDIR)/data/prometheus/:${prometheus_workdir} -v $(CURDIR)/scripts/startup/:/home/scripts -w ${prometheus_workdir} ${prometheus_image}

mongo-create:
	@echo "spawing: mongo"
	@docker run --rm -it --name ${mongo_cname} -p ${mongo_port}:${mongo_port} -v /var/run/docker.sock:/var/run/docker.sock -v $(CURDIR)/data/mongo/:${mongo_workdir} -v $(CURDIR)/scripts/startup/:/home/scripts -e MONGO_INITDB_ROOT_USERNAME=${mongo_user} -e MONGO_INITDB_ROOT_PASSWORD=${mongo_pass} -w ${mongo_workdir} ${mongo_image}

mongo-shell:
	$(eval mongo_cid = $(shell (docker ps -aqf "name=${mongo_cname}")))
	$(if $(strip $(mongo_cid)), \
		@docker exec -it ${mongo_cid} mongo,\
		@echo "no mongo container found!")
	$(endif)

mongo-uri:
	$(eval mongo_cid = $(shell (docker ps -aqf "name=${mongo_cname}")))
	$(if $(strip $(mongo_cid)), \
		@echo "uri: ${mongo_uri}",\
		@echo "no mongo container found!")
	$(endif)


redis-create:
	@echo "spawing: redis"
	@docker run --rm -it --name ${redis_cname} -e REDIS_PORT_NUMBER=${redis_port} -p ${redis_port}:${redis_port} -v /var/run/docker.sock:/var/run/docker.sock -v $(CURDIR)/data/redis/:${redis_workdir} -v $(CURDIR)/scripts/startup/:/home/scripts -e MONGO_INITDB_ROOT_USERNAME=${mongo_user} -e REDIS_PASSWORD=${redis_pass} -w ${redis_workdir} ${redis_image}

redis-shell:
	$(eval redis_cid = $(shell (docker ps -aqf "name=${redis_cname}")))
	$(if $(strip $(redis_cid)), \
		@docker exec -it ${redis_cid} redis-cli -h localhost -p ${redis_port} -a ${redis_pass},\
		@echo "no redis container found!")
	$(endif)

redis-uri:
	$(eval redis_cid = $(shell (docker ps -aqf "name=${redis_cname}")))
	$(if $(strip $(redis_cid)), \
		@echo "uri: ${redis_uri}",\
		@echo "no redis container found!")
	$(endif)

pg-create:
	$(eval pg_cid = $(shell (docker ps -aqf "name=${pg_cname}")))
	$(if $(strip $(pg_cid)), \
		@echo "existing pg: ${pg_cid}",\
		@echo "creating pg..." && docker run -t -i -d -v $(CURDIR)/data/postgres:/var/lib/postgresql/data --name ${pg_cname} -e POSTGRES_DB=${pg_db} -e POSTGRES_USER=${pg_user} -e POSTGRES_PASSWORD=${pg_pass} -p ${pg_port}:5432 ${pg_image} postgres -c log_statement=all)
	$(endif)

pg-start: pg-create
	@echo "waiting for pg..." && sleep 5 && docker exec -it $(shell docker ps -aqf "name=${pg_cname}") bash -c "while ! pg_isready -p 5432 -h localhost; do sleep 5; done"

pg-restart:
	$(eval pg_cid = $(shell (docker ps -aqf "name=${pg_cname}")))
	$(if $(strip $(pg_cid)), \
		@echo "restarting pg..." && docker run ${pg_cid},\
		@echo "no pg container found!")
	$(endif)

pg-stop:
	$(eval pg_cid = $(shell (docker ps -aqf "name=${pg_cname}")))
	$(if $(strip $(pg_cid)), \
		@echo "stopping pg..." && docker stop ${pg_cid},\
		@echo "no pg container found!")
	$(endif)

pg-purge: pg-stop
	$(eval pg_cid = $(shell (docker ps -aqf "name=${pg_cname}")))
	$(if $(strip $(pg_cid)), \
		@echo "purging pg..." && docker rm ${pg_cid} && rm -r $(CURDIR)/data/postgres && mkdir $(CURDIR)/data/postgres,\
		@echo "no pg container found!")
	$(endif)

pg-shell:
	$(eval pg_cid = $(shell (docker ps -aqf "name=${pg_cname}")))
	$(if $(strip $(pg_cid)), \
		@docker exec -it ${pg_cid} psql -h ${pg_host} -U ${pg_user} -p 5432 ${pg_db},\
		@echo "no pg container found!")
	$(endif)

pg-uri:
	$(eval pg_cid = $(shell (docker ps -aqf "name=${pg_cname}")))
	$(if $(strip $(pg_cid)), \
		@echo "uri: ${pg_uri}",\
		@echo "no pg container found!")
	$(endif)

mysql-create:
	$(eval mysql_cid = $(shell (docker ps -aqf "name=${mysql_cname}")))
	$(if $(strip $(mysql_cid)), \
		@echo "existing mysql: ${mysql_cid}",\
		@echo "creating mysql..." && docker run -t -i -d -v $(CURDIR)/data/mysql:/var/lib/mysql --name ${mysql_cname} -e MYSQL_DATABASE=${mysql_db} -e MYSQL_USER=${mysql_user} -e MYSQL_PASSWORD=${mysql_pass} -e MYSQL_ROOT_PASSWORD=${mysql_rpass} -p ${mysql_port}:3306 ${mysql_image})
	$(endif)

mysql-start: mysql-create
	@echo "waiting for mysql..." && sleep 5 && docker exec -it $(shell docker ps -aqf "name=${mysql_cname}") bash -c "while ! mysqladmin ping -h localhost --silent; do sleep 5; done"

mysql-restart:
	$(eval mysql_cid = $(shell (docker ps -aqf "name=${mysql_cname}")))
	$(if $(strip $(mysql_cid)), \
		@echo "restarting mysql..." && docker run ${mysql_cid},\
		@echo "no mysql container found!")
	$(endif)

mysql-stop:
	$(eval mysql_cid = $(shell (docker ps -aqf "name=${mysql_cname}")))
	$(if $(strip $(mysql_cid)), \
		@echo "stopping mysql..." && docker stop ${mysql_cid},\
		@echo "no mysql container found!")
	$(endif)

mysql-purge: mysql-stop
	$(eval mysql_cid = $(shell (docker ps -aqf "name=${mysql_cname}")))
	$(if $(strip $(mysql_cid)), \
		@echo "purging mysql..." && docker rm ${mysql_cid} && rm -r $(CURDIR)/data/postgres && mkdir $(CURDIR)/data/postgres,\
		@echo "no mysql container found!")
	$(endif)

mysql-shell:
	$(eval mysql_cid = $(shell (docker ps -aqf "name=${mysql_cname}")))
	$(if $(strip $(mysql_cid)), \
		@docker exec -it ${mysql_cid} mysql -h ${mysql_host} -u ${mysql_user} -P 5432 ${mysql_db} -p,\
		@echo "no mysql container found!")
	$(endif)

mysql-uri:
	$(eval mysql_cid = $(shell (docker ps -aqf "name=${mysql_cname}")))
	$(if $(strip $(mysql_cid)), \
		@echo "uri: ${mysql_uri}",\
		@echo "no mysql container found!")
	$(endif)